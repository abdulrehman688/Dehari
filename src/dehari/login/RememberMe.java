package dehari.login;

import java.io.*;
import java.util.Properties;

public class RememberMe {

    private static final String FILE_NAME = "rememberme.properties";

    public static void saveLogin(String email) {
        try (FileOutputStream fos = new FileOutputStream(FILE_NAME)) {
            Properties props = new Properties();
            props.setProperty("email", email);
            props.store(fos, null);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static String loadSavedEmail() {
        try (FileInputStream fis = new FileInputStream(FILE_NAME)) {
            Properties props = new Properties();
            props.load(fis);
            return props.getProperty("email", null);
        } catch (IOException e) {
            return null;
        }
    }

    public static void clear() {
        File file = new File(FILE_NAME);
        if (file.exists()) {
            file.delete();
        }
    }
}
