package dehari.login;

import com.formdev.flatlaf.FlatClientProperties;
import javax.swing.*;
import net.miginfocom.swing.MigLayout;
import dehari.menu.FormManager;
import dehari.model.ModelUser;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Login extends JPanel {

    private JTextField txtEmail;
    private JPasswordField txtPassword;
    private JCheckBox chRememberMe;
    private JButton cmdLogin;
    private JButton cmdRegister;

    public Login() {
        init();

        // Auto-login if saved email exists
        String savedEmail = RememberMe.loadSavedEmail();
        if (savedEmail != null) {
            txtEmail.setText(savedEmail);
            autoLogin(savedEmail);
        }
    }

    private void init() {
        setLayout(new MigLayout("fill,insets 20", "[center]", "[center]"));

        txtEmail = new JTextField();
        txtPassword = new JPasswordField();
        chRememberMe = new JCheckBox("Remember me");
        cmdLogin = new JButton("Login");
        cmdRegister = new JButton("Register");

        JPanel panel = new JPanel(new MigLayout("wrap,fillx,insets 35 45 30 45", "fill,250:280"));
        panel.putClientProperty(FlatClientProperties.STYLE, "arc:20;"
                + "[light]background:darken(@background,3%);"
                + "[dark]background:lighten(@background,3%)");

        txtPassword.putClientProperty(FlatClientProperties.STYLE, "showRevealButton:true");
        cmdLogin.putClientProperty(FlatClientProperties.STYLE, ""
                + "[light]background:darken(@background,10%);"
                + "[dark]background:lighten(@background,10%);"
                + "borderWidth:0;focusWidth:0;innerFocusWidth:0");

        cmdRegister.putClientProperty(FlatClientProperties.STYLE, "borderWidth:0;focusWidth:0;innerFocusWidth:0");

        txtEmail.putClientProperty(FlatClientProperties.PLACEHOLDER_TEXT, "Enter your email");
        txtPassword.putClientProperty(FlatClientProperties.PLACEHOLDER_TEXT, "Enter your password");

        JLabel lbTitle = new JLabel("Welcome back!");
        lbTitle.putClientProperty(FlatClientProperties.STYLE, "font:bold +10");

        JLabel description = new JLabel("Please sign in to access your account");
        description.putClientProperty(FlatClientProperties.STYLE, ""
                + "[light]foreground:lighten(@foreground,30%);"
                + "[dark]foreground:darken(@foreground,30%)");

        panel.add(lbTitle);
        panel.add(description);
        panel.add(new JLabel("Email"), "gapy 8");
        panel.add(txtEmail);
        panel.add(new JLabel("Password"), "gapy 8");
        panel.add(txtPassword);
        panel.add(chRememberMe, "grow 0");
        panel.add(cmdLogin, "gapy 10");
        panel.add(cmdRegister, "gapy 5");

        add(panel);

        cmdLogin.addActionListener(e -> login());
        cmdRegister.addActionListener(e -> FormManager.register());
    }

    private void login() {
        String email = txtEmail.getText().trim();
        String password = new String(txtPassword.getPassword());

        if (email.isEmpty() || password.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Please enter email and password.", "Error", JOptionPane.ERROR_MESSAGE);
            return;
        }

        try (Connection conn = dehari.database.DBConnection.getConnection()) {
            String sql = "SELECT id, username, email, password, admin, usertype, full_name FROM users WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String dbPassword = rs.getString("password");
                String username = rs.getString("username");
                String dbEmail = rs.getString("email");
                String adminValue = rs.getString("admin");
                int userId = rs.getInt("id");

                // Compare hashed passwords
                String hashedInput = Register.hashPassword(password);
                if (hashedInput.equalsIgnoreCase(dbPassword)) {
                    boolean isAdmin = "yes".equalsIgnoreCase(adminValue);

                String usertype = rs.getString("usertype");

                String fullName = rs.getString("full_name"); // Make sure this column exists and is fetched
                ModelUser user = new ModelUser(
                    userId,
                    username,
                    dbEmail,
                    dbPassword,
                    isAdmin,
                    usertype,
                    null // profileImagePath
                );
                user.setFullName(fullName); // <-- Set the full name!


                    // Remember Me
                    if (chRememberMe.isSelected()) {
                        RememberMe.saveLogin(dbEmail);
                    } else {
                        RememberMe.clear();
                    }

                    FormManager.login(user);  // Continue to dashboard
                } else {
                    JOptionPane.showMessageDialog(this, "Invalid password.", "Login Failed", JOptionPane.ERROR_MESSAGE);
                }
            } else {
                JOptionPane.showMessageDialog(this, "Email not found.", "Login Failed", JOptionPane.ERROR_MESSAGE);
            }
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(this, "Error: " + ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
            ex.printStackTrace();
        }
    }

    private void autoLogin(String email) {
        try (Connection conn = dehari.database.DBConnection.getConnection()) {
            String sql = "SELECT id, username, email, password, admin, usertype FROM users WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String username = rs.getString("username");
                String dbEmail = rs.getString("email");
                String dbPassword = rs.getString("password");
                boolean isAdmin = "yes".equalsIgnoreCase(rs.getString("admin"));

                ModelUser user = new ModelUser(
                    rs.getInt("id"),
                    username,
                    dbEmail,
                    dbPassword,
                    isAdmin,
                    rs.getString("usertype"),
                    null // profileImagePath can be set if available
                );


                FormManager.login(user);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
