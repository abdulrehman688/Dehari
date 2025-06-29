package dehari.forms;

import com.formdev.flatlaf.FlatClientProperties;
import dehari.components.SimpleForm;
import dehari.model.ModelUser;
import net.miginfocom.swing.MigLayout;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class Checking extends SimpleForm {

    public Checking(ModelUser user) {
        // Access control check
        if (user == null || !user.isAdmin()) {
            JOptionPane.showMessageDialog(null, "Access Denied. Admins only.", "Unauthorized", JOptionPane.ERROR_MESSAGE);
            removeAll();
            revalidate();
            repaint();
            return;
        }

        init();
    }

    private int getServicesBoughtCount() {
        int count = 0;
        try (Connection conn = dehari.database.DBConnection.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM booked_services")) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return count;
    }

    private int getTotalUsersCount() {
        int count = 0;
        try (Connection conn = dehari.database.DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM users")) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return count;
    }

    private void init() {
        
        setLayout(new MigLayout("fill,insets 20", "[center]", "[top]"));

        JPanel cardsPanel = new JPanel(new MigLayout("insets 0, gap 30", "[][][]", ""));
        cardsPanel.setOpaque(false);

        int servicesBoughtCount = getServicesBoughtCount();
        int profit = servicesBoughtCount * 150;
        cardsPanel.add(createCard("Services Bought", String.valueOf(servicesBoughtCount), "\uD83D\uDED2", "#FFCDD2"), "w 270!, h 180!, grow");
        cardsPanel.add(createCard("Profit", "RS " + profit, "\uD83D\uDCB0", "#C8E6C9"), "w 270!, h 180!, grow");
        cardsPanel.add(createCard("Total Users", String.valueOf(getTotalUsersCount()), "\uD83D\uDC65", "#BBDEFB"), "w 270!, h 180!, grow");

        add(cardsPanel, "wrap");

        JLabel tableTitle = new JLabel("Registered Users");
        tableTitle.putClientProperty(FlatClientProperties.STYLE, "font:bold +2");
        add(tableTitle, "wrap");

        JPanel tablePanel = new JPanel(new BorderLayout());

        // === Button Row ===
        JPanel buttonPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        JButton addButton = new JButton("Add");
        JButton updateButton = new JButton("Update");
        JButton deleteButton = new JButton("Delete");
        buttonPanel.add(addButton);
        buttonPanel.add(updateButton);
        buttonPanel.add(deleteButton);

        tablePanel.add(buttonPanel, BorderLayout.NORTH);

        // === Table ===
        String[] columnNames = {
            "ID", "Username", "Email", "Full Name", "Phone", "Address", "Profile Picture",
            "Admin", "Usertype", "Created At", "Updated At", "Status"
        };
        DefaultTableModel model = new DefaultTableModel(null, columnNames) {
            @Override
            public boolean isCellEditable(int row, int column) {
                return false;
            }
        };

        try (Connection conn = dehari.database.DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT id, username, email, full_name, phone, address, profile_picture, admin, usertype, created_at, updated_at, status FROM users")) {
            while (rs.next()) {
                model.addRow(new Object[]{
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("email"),
                    rs.getString("full_name"),
                    rs.getString("phone"),
                    rs.getString("address"),
                    rs.getString("profile_picture"),
                    rs.getString("admin"),
                    rs.getString("usertype"),
                    rs.getString("created_at"),
                    rs.getString("updated_at"),
                    rs.getString("status")
                });
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        JTable table = new JTable(model);
        table.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        JScrollPane scrollPane = new JScrollPane(table);
        scrollPane.putClientProperty(FlatClientProperties.STYLE, "border:5,5,5,5");

        tablePanel.add(scrollPane, BorderLayout.CENTER);
        add(tablePanel, "grow");

        addButton.addActionListener(e -> showAddUserDialog(model));
        updateButton.addActionListener(e -> showUpdateUserDialog(model, table));
        deleteButton.addActionListener(e -> deleteSelectedUsers(model, table));
    }

    private JPanel createCard(String title, String value, String icon, String bgColorHex) {
        Font emojiFont = new Font("Segoe UI Emoji", Font.PLAIN, 36);
        Font valueFont = new Font("SansSerif", Font.BOLD, 24);
        Color textColor = Color.decode("#212121");

        JLabel lblIcon = new JLabel(icon);
        lblIcon.setFont(emojiFont);
        lblIcon.setForeground(textColor);

        JLabel lblTitle = new JLabel(title);
        lblTitle.setFont(new Font("SansSerif", Font.PLAIN, 16));
        lblTitle.setForeground(textColor);

        JLabel lblValue = new JLabel(value);
        lblValue.setFont(valueFont);
        lblValue.setForeground(textColor);

        JPanel panel = new JPanel(new MigLayout("wrap,fillx,insets 20", "[]", "[]10[]"));
        panel.putClientProperty(FlatClientProperties.STYLE, "arc:20; background:" + bgColorHex + ";");

        panel.add(lblIcon);
        panel.add(lblTitle);
        panel.add(lblValue);

        return panel;
    }

    private void showAddUserDialog(DefaultTableModel model) {
        JPanel panel = new JPanel(new GridLayout(0, 2, 8, 8));
        JTextField username = new JTextField();
        JTextField email = new JTextField();
        JTextField password = new JTextField();
        JTextField fullName = new JTextField();
        JTextField phone = new JTextField();
        JTextField address = new JTextField();
        JTextField profilePicture = new JTextField();
        JComboBox<String> admin = new JComboBox<>(new String[]{"yes", "no"});
        JComboBox<String> usertype = new JComboBox<>(new String[]{"admin", "user", "provider"});
        JComboBox<String> status = new JComboBox<>(new String[]{"active", "inactive", "banned"});

        panel.add(new JLabel("Username:")); panel.add(username);
        panel.add(new JLabel("Email:")); panel.add(email);
        panel.add(new JLabel("Password:")); panel.add(password);
        panel.add(new JLabel("Full Name:")); panel.add(fullName);
        panel.add(new JLabel("Phone:")); panel.add(phone);
        panel.add(new JLabel("Address:")); panel.add(address);
        panel.add(new JLabel("Profile Picture:")); panel.add(profilePicture);
        panel.add(new JLabel("Admin:")); panel.add(admin);
        panel.add(new JLabel("Usertype:")); panel.add(usertype);
        panel.add(new JLabel("Status:")); panel.add(status);

        int result = JOptionPane.showConfirmDialog(this, panel, "Add User", JOptionPane.OK_CANCEL_OPTION, JOptionPane.PLAIN_MESSAGE);
        if (result == JOptionPane.OK_OPTION) {
            try (Connection conn = dehari.database.DBConnection.getConnection();
                 Statement stmt = conn.createStatement()) {
                String sql = String.format(
                    "INSERT INTO users (username, email, password, full_name, phone, address, profile_picture, admin, usertype, status) VALUES ('%s','%s','%s','%s','%s','%s','%s','%s','%s','%s')",
                    username.getText(), email.getText(), hashPassword(password.getText()), fullName.getText(), phone.getText(), address.getText(),
                    profilePicture.getText(), admin.getSelectedItem(), usertype.getSelectedItem(), status.getSelectedItem()
                );
                stmt.executeUpdate(sql);
                JOptionPane.showMessageDialog(this, "User added successfully!");
                refreshTable(model);
            } catch (Exception ex) {
                ex.printStackTrace();
                JOptionPane.showMessageDialog(this, "Error adding user: " + ex.getMessage());
            }
        }
    }

    private void showUpdateUserDialog(DefaultTableModel model, JTable table) {
        int row = table.getSelectedRow();
        if (row == -1 || table.getSelectedRows().length > 1) {
            JOptionPane.showMessageDialog(this, "Please select exactly one user to update.");
            return;
        }
        // Get current values
        Object[] data = new Object[table.getColumnCount()];
        for (int i = 0; i < data.length; i++) data[i] = table.getValueAt(row, i);

        JPanel panel = new JPanel(new GridLayout(0, 2, 8, 8));
        JTextField username = new JTextField(data[1] != null ? data[1].toString() : "");
        JTextField email = new JTextField(data[2] != null ? data[2].toString() : "");
        JTextField password = new JTextField(data[3] != null ? data[3].toString() : "");
        JTextField fullName = new JTextField(data[4] != null ? data[4].toString() : "");
        JTextField phone = new JTextField(data[5] != null ? data[5].toString() : "");
        JTextField address = new JTextField(data[6] != null ? data[6].toString() : "");
        JComboBox<String> admin = new JComboBox<>(new String[]{"yes", "no"});
        admin.setSelectedItem(data[7] != null ? data[7].toString() : "no");
        JComboBox<String> usertype = new JComboBox<>(new String[]{"admin", "user", "provider"});
        usertype.setSelectedItem(data[8] != null ? data[8].toString() : "user");
        JComboBox<String> status = new JComboBox<>(new String[]{"active", "inactive", "banned"});
        status.setSelectedItem(data[11] != null ? data[11].toString() : "active");

        panel.add(new JLabel("Username:")); panel.add(username);
        panel.add(new JLabel("Email:")); panel.add(email);
        panel.add(new JLabel("Password:")); panel.add(password);
        panel.add(new JLabel("Full Name:")); panel.add(fullName);
        panel.add(new JLabel("Phone:")); panel.add(phone);
        panel.add(new JLabel("Address:")); panel.add(address);
        panel.add(new JLabel("Admin:")); panel.add(admin);
        panel.add(new JLabel("Usertype:")); panel.add(usertype);
        panel.add(new JLabel("Status:")); panel.add(status);

        int result = JOptionPane.showConfirmDialog(this, panel, "Update User", JOptionPane.OK_CANCEL_OPTION, JOptionPane.PLAIN_MESSAGE);
        if (result == JOptionPane.OK_OPTION) {
            try (Connection conn = dehari.database.DBConnection.getConnection();
                 Statement stmt = conn.createStatement()) {
                String sql = "UPDATE users SET "
                    + "username=" + toSqlString(username.getText()) + ", "
                    + "email=" + toSqlString(email.getText()) + ", "
                    + "password=" + toSqlString(hashPassword(password.getText())) + ", "
                    + "full_name=" + toSqlString(fullName.getText()) + ", "
                    + "phone=" + toSqlString(phone.getText()) + ", "
                    + "address=" + toSqlString(address.getText()) + ", "
                    + "admin=" + toSqlString((String) admin.getSelectedItem()) + ", "
                    + "usertype=" + toSqlString((String) usertype.getSelectedItem()) + ", "
                    + "status=" + toSqlString((String) status.getSelectedItem())
                    + " WHERE id=" + data[0];
                stmt.executeUpdate(sql);
                JOptionPane.showMessageDialog(this, "User updated successfully!");
                refreshTable(model);
            } catch (Exception ex) {
                ex.printStackTrace();
                JOptionPane.showMessageDialog(this, "Error updating user: " + ex.getMessage());
            }
        }
    }

    private void deleteSelectedUsers(DefaultTableModel model, JTable table) {
        int[] rows = table.getSelectedRows();
        if (rows.length == 0) {
            JOptionPane.showMessageDialog(this, "Please select at least one user to delete.");
            return;
        }
        int confirm = JOptionPane.showConfirmDialog(this, "Are you sure you want to delete the selected user(s)?", "Confirm Delete", JOptionPane.YES_NO_OPTION);
        if (confirm != JOptionPane.YES_OPTION) return;

        try (Connection conn = dehari.database.DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {
            for (int row : rows) {
                Object id = table.getValueAt(row, 0);
                stmt.executeUpdate("DELETE FROM users WHERE id=" + id);
            }
            JOptionPane.showMessageDialog(this, "User(s) deleted successfully!");
            refreshTable(model);
        } catch (Exception ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error deleting user(s): " + ex.getMessage());
        }
    }

    private void refreshTable(DefaultTableModel model) {
        model.setRowCount(0);
        try (Connection conn = dehari.database.DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT id, username, email, full_name, phone, address, profile_picture, admin, usertype, created_at, updated_at, status FROM users")) {
            while (rs.next()) {
                model.addRow(new Object[]{
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("email"),
                    rs.getString("full_name"),
                    rs.getString("phone"),
                    rs.getString("address"),
                    rs.getString("profile_picture"),
                    rs.getString("admin"),
                    rs.getString("usertype"),
                    rs.getString("created_at"),
                    rs.getString("updated_at"),
                    rs.getString("status")
                });
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    private String toSqlString(String value) {
        if (value == null || value.trim().isEmpty() || value.equalsIgnoreCase("null")) {
            return "NULL";
        } else {
            return "'" + value.replace("'", "''") + "'";
        }
    }

    private String hashPassword(String password) {
        try {
            java.security.MessageDigest md = java.security.MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes(java.nio.charset.StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (Exception ex) {
            ex.printStackTrace();
            return password; // fallback (not secure)
        }
    }
}
