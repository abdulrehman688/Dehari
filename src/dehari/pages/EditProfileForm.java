package dehari.pages;

import dehari.components.SimpleForm;
import dehari.menu.FormManager;
import dehari.login.Register; // for hashPassword method
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.*;

public class EditProfileForm extends SimpleForm {

    private JTextField txtUsername;
    private JTextField txtEmail;
    private JPasswordField txtPassword;
    private JTextField txtFullName;
    private JTextField txtPhone;
    private JTextField txtAddress;
    private JLabel lblProfilePic;
    private JButton btnChoosePic;
    private JButton btnSave, btnCancel;

    private int userId;
    private File selectedProfilePicFile = null; // stores selected file

    public EditProfileForm(int userId) {
        this.userId = userId;
        initComponents();
        loadUserData();
    }

    private void initComponents() {
//        setTitle("Edit Profile");
        setSize(450, 450);
//        setLocationRelativeTo(null);
//        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);

        JPanel panel = new JPanel(new GridBagLayout());
        GridBagConstraints gbc = new GridBagConstraints();

        JLabel lblUsername = new JLabel("Username:");
        JLabel lblEmail = new JLabel("Email:");
        JLabel lblPassword = new JLabel("Password:");
        JLabel lblFullName = new JLabel("Full Name:");
        JLabel lblPhone = new JLabel("Phone:");
        JLabel lblAddress = new JLabel("Address:");
        JLabel lblPic = new JLabel("Profile Picture:");

        txtUsername = new JTextField(20);
        txtEmail = new JTextField(20);
        txtPassword = new JPasswordField(20);
        txtFullName = new JTextField(20);
        txtPhone = new JTextField(20);
        txtAddress = new JTextField(20);

        lblProfilePic = new JLabel("No file chosen");
        btnChoosePic = new JButton("Choose Picture");

        btnSave = new JButton("Save");
        btnCancel = new JButton("Cancel");

        gbc.insets = new Insets(5, 5, 5, 5);
        gbc.anchor = GridBagConstraints.WEST;

        int row = 0;
        gbc.gridx = 0; gbc.gridy = row; panel.add(lblUsername, gbc);
        gbc.gridx = 1; panel.add(txtUsername, gbc);

        gbc.gridx = 0; gbc.gridy = ++row; panel.add(lblEmail, gbc);
        gbc.gridx = 1; panel.add(txtEmail, gbc);

        gbc.gridx = 0; gbc.gridy = ++row; panel.add(lblPassword, gbc);
        gbc.gridx = 1; panel.add(txtPassword, gbc);

        gbc.gridx = 0; gbc.gridy = ++row; panel.add(lblFullName, gbc);
        gbc.gridx = 1; panel.add(txtFullName, gbc);

        gbc.gridx = 0; gbc.gridy = ++row; panel.add(lblPhone, gbc);
        gbc.gridx = 1; panel.add(txtPhone, gbc);

        gbc.gridx = 0; gbc.gridy = ++row; panel.add(lblAddress, gbc);
        gbc.gridx = 1; panel.add(txtAddress, gbc);

        gbc.gridx = 0; gbc.gridy = ++row; panel.add(lblPic, gbc);
        JPanel picPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 0, 0));
        picPanel.add(lblProfilePic);
        picPanel.add(Box.createHorizontalStrut(10));
        picPanel.add(btnChoosePic);
        gbc.gridx = 1; panel.add(picPanel, gbc);

        gbc.gridx = 0; gbc.gridy = ++row; gbc.gridwidth = 2; gbc.anchor = GridBagConstraints.CENTER;
        JPanel btnPanel = new JPanel();
        btnPanel.add(btnSave);
        btnPanel.add(btnCancel);
        panel.add(btnPanel, gbc);

        add(panel);

        btnChoosePic.addActionListener(e -> chooseProfilePicture());
        btnSave.addActionListener(this::saveProfile);
//        btnCancel.addActionListener(e -> dispose());
    }

    private void chooseProfilePicture() {
        JFileChooser chooser = new JFileChooser();
        chooser.setDialogTitle("Select Profile Picture");
        chooser.setFileSelectionMode(JFileChooser.FILES_ONLY);

        // Optional: Filter for images only
        chooser.setAcceptAllFileFilterUsed(false);
        chooser.addChoosableFileFilter(new javax.swing.filechooser.FileNameExtensionFilter(
                "Image files", "jpg", "jpeg", "png", "gif", "bmp"));

        int result = chooser.showOpenDialog(this);
        if (result == JFileChooser.APPROVE_OPTION) {
            selectedProfilePicFile = chooser.getSelectedFile();
            lblProfilePic.setText(selectedProfilePicFile.getName());
        }
    }

    private void loadUserData() {
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dehari_app", "root", "")) {
            String query = "SELECT username, email, full_name, phone, address, profile_picture FROM users WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                txtUsername.setText(rs.getString("username"));
                txtEmail.setText(rs.getString("email"));
                txtFullName.setText(rs.getString("full_name"));
                txtPhone.setText(rs.getString("phone"));
                txtAddress.setText(rs.getString("address"));
                String picPath = rs.getString("profile_picture");
                if (picPath != null && !picPath.isEmpty()) {
                    File picFile = new File(picPath);
                    lblProfilePic.setText(picFile.getName());
                }
            }
            rs.close();
            stmt.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Failed to load user data: " + ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void saveProfile(ActionEvent event) {
        String username = txtUsername.getText().trim();
        String email = txtEmail.getText().trim();
        String fullName = txtFullName.getText().trim();
        String phone = txtPhone.getText().trim();
        String address = txtAddress.getText().trim();
        String password = new String(txtPassword.getPassword()).trim();

        if (username.isEmpty() || email.isEmpty() || fullName.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Please fill in all required fields.", "Warning", JOptionPane.WARNING_MESSAGE);
            return;
        }

        // Validate email format (basic)
        if (!email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            JOptionPane.showMessageDialog(this, "Invalid email format.", "Warning", JOptionPane.WARNING_MESSAGE);
            return;
        }

        // Save profile picture to folder if selected
        String savedProfilePicPath = null;
        if (selectedProfilePicFile != null) {
            try {
                File destDir = new File("src/dehari/resource/image");
                if (!destDir.exists()) {
                    destDir.mkdirs();
                }

                // Rename file to avoid name clashes (optional)
                String newFileName = System.currentTimeMillis() + "_" + selectedProfilePicFile.getName();
                File destFile = new File(destDir, newFileName);

                Files.copy(selectedProfilePicFile.toPath(), destFile.toPath(), StandardCopyOption.REPLACE_EXISTING);

                // Save relative path for DB
                savedProfilePicPath = "resource/image/" + newFileName;

            } catch (IOException e) {
                e.printStackTrace();
                JOptionPane.showMessageDialog(this, "Failed to save profile picture: " + e.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
                return;
            }
        }

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dehari_app", "root", "")) {
            String sql;
            boolean updatePassword = !password.isEmpty();
            boolean updatePic = (savedProfilePicPath != null);

            if (updatePassword && updatePic) {
                sql = "UPDATE users SET username = ?, email = ?, full_name = ?, phone = ?, address = ?, password = ?, profile_picture = ? WHERE id = ?";
            } else if (updatePassword) {
                sql = "UPDATE users SET username = ?, email = ?, full_name = ?, phone = ?, address = ?, password = ? WHERE id = ?";
            } else if (updatePic) {
                sql = "UPDATE users SET username = ?, email = ?, full_name = ?, phone = ?, address = ?, profile_picture = ? WHERE id = ?";
            } else {
                sql = "UPDATE users SET username = ?, email = ?, full_name = ?, phone = ?, address = ? WHERE id = ?";
            }

            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, username);
            stmt.setString(2, email);
            stmt.setString(3, fullName);
            stmt.setString(4, phone);
            stmt.setString(5, address);

            int paramIndex = 6;

            if (updatePassword) {
                String hashedPassword = Register.hashPassword(password);
                stmt.setString(paramIndex++, hashedPassword);
            }

            if (updatePic) {
                stmt.setString(paramIndex++, savedProfilePicPath);
            }

            stmt.setInt(paramIndex, userId);

            int rowsUpdated = stmt.executeUpdate();
            stmt.close();

            if (rowsUpdated > 0) {
                JOptionPane.showMessageDialog(this, "Profile updated successfully!", "Success", JOptionPane.INFORMATION_MESSAGE);
//                dispose();
            } else {
                JOptionPane.showMessageDialog(this, "Update failed. Try again.", "Error", JOptionPane.ERROR_MESSAGE);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Database error: " + ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> new EditProfileForm(1).setVisible(true));
    }
}
