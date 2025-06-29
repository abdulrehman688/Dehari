package dehari.login;

import com.formdev.flatlaf.FlatClientProperties;
import dehari.database.DBConnection;
import dehari.menu.FormManager;
import java.security.MessageDigest;
import javax.swing.*;
import net.miginfocom.swing.MigLayout;import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;



public class Register extends JPanel {

    public Register() {
        init();
    }
    

    public static String hashPassword(String password) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(password.getBytes("UTF-8"));
        StringBuilder hex = new StringBuilder();
        for (byte b : hash) {
            hex.append(String.format("%02x", b));
        }
        return hex.toString();
    }


    private void init() {
        setLayout(new MigLayout("fill,insets 20", "[center]", "[center]"));

        JTextField txtUsername = new JTextField();
        JTextField txtEmail = new JTextField();
        JPasswordField txtPassword = new JPasswordField();
        JButton cmdRegister = new JButton("Register");
        JButton cmdBackToLogin = new JButton("Already have and account Login?");

        JPanel panel = new JPanel(new MigLayout("wrap,fillx,insets 35 45 30 45", "fill,250:280"));
                panel.putClientProperty(FlatClientProperties.STYLE, ""
                + "arc:20;"
                + "[light]background:darken(@background,3%);"
                + "[dark]background:lighten(@background,3%)");

        txtPassword.putClientProperty(FlatClientProperties.STYLE, ""
                + "showRevealButton:true");
        
        txtUsername.putClientProperty(FlatClientProperties.PLACEHOLDER_TEXT, "Enter username");
        txtEmail.putClientProperty(FlatClientProperties.PLACEHOLDER_TEXT, "Enter email");
        txtPassword.putClientProperty(FlatClientProperties.PLACEHOLDER_TEXT, "Enter password");

        JLabel lbTitle = new JLabel("Welcome!");
        JLabel description = new JLabel("Please Register to create your account");
        lbTitle.putClientProperty(FlatClientProperties.STYLE, ""
                + "font:bold +10");
        description.putClientProperty(FlatClientProperties.STYLE, ""
                + "[light]foreground:lighten(@foreground,30%);"
                + "[dark]foreground:darken(@foreground,30%)");

        panel.add(lbTitle);
        panel.add(description);
        panel.add(txtUsername);
        panel.add(new JLabel("Email"));
        panel.add(txtEmail);
        panel.add(new JLabel("Password"));
        panel.add(txtPassword);
        panel.add(cmdRegister, "gapy 10");
        panel.add(cmdBackToLogin, "gapy 5");

        add(panel);

        // Register button action (you'll implement the logic here)
        cmdRegister.addActionListener(e -> {
            String username = txtUsername.getText().trim();
            String email = txtEmail.getText().trim();
            // TODO: handle registration logic
            JOptionPane.showMessageDialog(this, 
                "Registered:\n" +
                "Username: " + username + "\n" +
                "Email: " + email + "\n" +
                "Password: ********"
            );        
        });
        

        // Back to login
        cmdBackToLogin.addActionListener(e -> {
            FormManager.logout();
        });
        cmdRegister.addActionListener(e -> {
            String username = txtUsername.getText().trim();
            String email = txtEmail.getText().trim();
            String password = new String(txtPassword.getPassword());

                // 🔸 Step 1: Basic input check
            if (username.isEmpty() || email.isEmpty() || password.isEmpty()) {
                JOptionPane.showMessageDialog(this, "Please fill all fields.", "Error", JOptionPane.ERROR_MESSAGE);
                return;
            }
            
                // 🔸 Step 2: Email format check
            if (!email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
                JOptionPane.showMessageDialog(this, "Invalid email format.", "Error", JOptionPane.ERROR_MESSAGE);
                return;
            }

            try (Connection conn = DBConnection.getConnection()) {
                       // 🔸 Step 3: Check if email already exists
                PreparedStatement checkStmt = conn.prepareStatement("SELECT COUNT(*) FROM users WHERE email = ?");
                checkStmt.setString(1, email);
                ResultSet rs = checkStmt.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    JOptionPane.showMessageDialog(this, "Email is already registered.", "Error", JOptionPane.ERROR_MESSAGE);
                    return;
                }
                
                // 🔸 Step 4: Insert new user
                PreparedStatement stmt = conn.prepareStatement(
                    "INSERT INTO users (username, email, password, usertype, admin) VALUES (?, ?, ?, ?, ?)"
                );
                stmt.setString(1, username);
                stmt.setString(2, email);
                stmt.setString(3, hashPassword(password));
                stmt.setString(4, "user");  // default usertype
                stmt.setString(5, "no");    // default admin status

                int rows = stmt.executeUpdate();
                if (rows > 0) {
                    JOptionPane.showMessageDialog(this, "Registration successful!");
                    FormManager.logout(); // Switch to login form
                } else {
                    JOptionPane.showMessageDialog(this, "Registration failed.");
                }
            } catch (Exception ex) {
                JOptionPane.showMessageDialog(this, "Error: " + ex.getMessage(), "Database Error", JOptionPane.ERROR_MESSAGE);
            }

        });

    }
}
