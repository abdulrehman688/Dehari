package dehari.forms;

import dehari.components.SimpleForm;
import dehari.model.ModelUser;
import net.miginfocom.swing.MigLayout;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class ManageServiceProviders extends SimpleForm {

    public ManageServiceProviders(ModelUser user) {
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

    private void init() {
        setLayout(new MigLayout("fill,insets 20", "[center]", "[top]"));

        String[] columnNames = {
            "ID", "User ID", "Full Name", "Email", "Password", "Contact Number", "Address", "City", "State",
            "Postal Code", "Country", "Service Type", "Experience Years", "Skills", "Profile Picture",
            "Description", "Created At", "Updated At", "Reviews", "Rating"
        };
        DefaultTableModel model = new DefaultTableModel(null, columnNames) {
            @Override
            public boolean isCellEditable(int row, int column) {
                return false;
            }
        };

        try (Connection conn = dehari.database.DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT id, user_id, full_name, email, password, contact_number, address, city, state, postal_code, country, service_type, experience_years, skills, profile_picture, description, created_at, updated_at, reviews, rating FROM service_providers")) {
            while (rs.next()) {
                model.addRow(new Object[]{
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getString("full_name"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("contact_number"),
                    rs.getString("address"),
                    rs.getString("city"),
                    rs.getString("state"),
                    rs.getString("postal_code"),
                    rs.getString("country"),
                    rs.getString("service_type"),
                    rs.getObject("experience_years"),
                    rs.getString("skills"),
                    rs.getString("profile_picture"),
                    rs.getString("description"),
                    rs.getString("created_at"),
                    rs.getString("updated_at"),
                    rs.getString("reviews"),
                    rs.getObject("rating")
                });
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        JTable table = new JTable(model);
        table.setSelectionMode(ListSelectionModel.MULTIPLE_INTERVAL_SELECTION);
        JScrollPane scrollPane = new JScrollPane(table);

        JPanel buttonPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        JButton addButton = new JButton("Add");
        JButton updateButton = new JButton("Update");
        JButton deleteButton = new JButton("Delete");
        buttonPanel.add(addButton);
        buttonPanel.add(updateButton);
        buttonPanel.add(deleteButton);
        add(buttonPanel, "wrap"); // Add buttons first

        add(scrollPane, "grow, wrap"); // Then add the table

        // Button actions
        addButton.addActionListener(e -> showAddProviderDialog(model));
        updateButton.addActionListener(e -> showUpdateProviderDialog(model, table));
        deleteButton.addActionListener(e -> deleteSelectedProviders(model, table));
    }

    private void showAddProviderDialog(DefaultTableModel model) {
        JPanel panel = new JPanel(new GridLayout(0, 2, 8, 8));
        JTextField userId = new JTextField();
        JTextField fullName = new JTextField();
        JTextField email = new JTextField();
        JTextField password = new JTextField();
        JTextField contactNumber = new JTextField();
        JTextField address = new JTextField();
        JTextField city = new JTextField();
        JTextField state = new JTextField();
        JTextField postalCode = new JTextField();
        JTextField country = new JTextField();
        JTextField serviceType = new JTextField();
        JTextField experienceYears = new JTextField();
        JTextField skills = new JTextField();
        JTextField profilePicture = new JTextField();
        JTextField description = new JTextField();
        JTextField reviews = new JTextField();
        JTextField rating = new JTextField();

        panel.add(new JLabel("User ID:")); panel.add(userId);
        panel.add(new JLabel("Full Name:")); panel.add(fullName);
        panel.add(new JLabel("Email:")); panel.add(email);
        panel.add(new JLabel("Password:")); panel.add(password);
        panel.add(new JLabel("Contact Number:")); panel.add(contactNumber);
        panel.add(new JLabel("Address:")); panel.add(address);
        panel.add(new JLabel("City:")); panel.add(city);
        panel.add(new JLabel("State:")); panel.add(state);
        panel.add(new JLabel("Postal Code:")); panel.add(postalCode);
        panel.add(new JLabel("Country:")); panel.add(country);
        panel.add(new JLabel("Service Type:")); panel.add(serviceType);
        panel.add(new JLabel("Experience Years:")); panel.add(experienceYears);
        panel.add(new JLabel("Skills:")); panel.add(skills);
        panel.add(new JLabel("Profile Picture:")); panel.add(profilePicture);
        panel.add(new JLabel("Description:")); panel.add(description);
        panel.add(new JLabel("Reviews:")); panel.add(reviews);
        panel.add(new JLabel("Rating:")); panel.add(rating);

        int result = JOptionPane.showConfirmDialog(this, panel, "Add Service Provider", JOptionPane.OK_CANCEL_OPTION, JOptionPane.PLAIN_MESSAGE);
        if (result == JOptionPane.OK_OPTION) {
            try (Connection conn = dehari.database.DBConnection.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(
                    "INSERT INTO service_providers (user_id, full_name, email, password, contact_number, address, city, state, postal_code, country, service_type, experience_years, skills, profile_picture, description, reviews, rating) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")) {

                // Required fields (no null allowed)
                stmt.setInt(1, Integer.parseInt(userId.getText()));
                stmt.setString(2, fullName.getText());
                stmt.setString(3, email.getText());
                stmt.setString(4, hashPassword(password.getText()));

                // Nullable fields
                setNullableString(stmt, 5, contactNumber.getText());
                setNullableString(stmt, 6, address.getText());
                setNullableString(stmt, 7, city.getText());
                setNullableString(stmt, 8, state.getText());
                setNullableString(stmt, 9, postalCode.getText());
                setNullableString(stmt, 10, country.getText());
                setNullableString(stmt, 11, serviceType.getText());
                setNullableInt(stmt, 12, experienceYears.getText());
                setNullableString(stmt, 13, skills.getText());
                setNullableString(stmt, 14, profilePicture.getText());
                setNullableString(stmt, 15, description.getText());
                setNullableString(stmt, 16, reviews.getText());
                setNullableBigDecimal(stmt, 17, rating.getText()); // for reviews = 16, rating = 17

                stmt.executeUpdate();
                JOptionPane.showMessageDialog(this, "Service provider added!");
                refreshProviderTable(model);
            } catch (Exception ex) {
                ex.printStackTrace();
                JOptionPane.showMessageDialog(this, "Error: " + ex.getMessage());
            }
        }
    }

    // Helper methods for nullable fields
    private void setNullableString(PreparedStatement stmt, int idx, String value) throws Exception {
        if (value == null || value.trim().isEmpty()) {
            stmt.setNull(idx, java.sql.Types.VARCHAR);
        } else {
            stmt.setString(idx, value);
        }
    }

    private void setNullableInt(PreparedStatement stmt, int idx, String value) throws Exception {
        if (value == null || value.trim().isEmpty()) {
            stmt.setNull(idx, java.sql.Types.INTEGER);
        } else {
            stmt.setInt(idx, Integer.parseInt(value));
        }
    }

    private void setNullableBigDecimal(PreparedStatement stmt, int idx, String value) throws Exception {
        if (value == null || value.trim().isEmpty()) {
            stmt.setNull(idx, java.sql.Types.DECIMAL);
        } else {
            stmt.setBigDecimal(idx, new java.math.BigDecimal(value));
        }
    }

    private void showUpdateProviderDialog(DefaultTableModel model, JTable table) {
        int row = table.getSelectedRow();
        if (row == -1 || table.getSelectedRows().length > 1) {
            JOptionPane.showMessageDialog(this, "Select exactly one provider to update.");
            return;
        }
        Object[] data = new Object[table.getColumnCount()];
        for (int i = 0; i < data.length; i++) data[i] = table.getValueAt(row, i);

        JPanel panel = new JPanel(new GridLayout(0, 2, 8, 8));
        JTextField userId = new JTextField(data[1] != null ? data[1].toString() : "");
        JTextField fullName = new JTextField(data[2] != null ? data[2].toString() : "");
        JTextField email = new JTextField(data[3] != null ? data[3].toString() : "");
        JTextField password = new JTextField(); // Leave blank to keep old password
        JTextField contactNumber = new JTextField(data[5] != null ? data[5].toString() : "");
        JTextField address = new JTextField(data[6] != null ? data[6].toString() : "");
        JTextField city = new JTextField(data[7] != null ? data[7].toString() : "");
        JTextField state = new JTextField(data[8] != null ? data[8].toString() : "");
        JTextField postalCode = new JTextField(data[9] != null ? data[9].toString() : "");
        JTextField country = new JTextField(data[10] != null ? data[10].toString() : "");
        JTextField serviceType = new JTextField(data[11] != null ? data[11].toString() : "");
        JTextField experienceYears = new JTextField(data[12] != null ? data[12].toString() : "");
        JTextField skills = new JTextField(data[13] != null ? data[13].toString() : "");
        JTextField profilePicture = new JTextField(data[14] != null ? data[14].toString() : "");
        JTextField description = new JTextField(data[15] != null ? data[15].toString() : "");
        JTextField reviews = new JTextField(data[18] != null ? data[18].toString() : "");
        JTextField rating = new JTextField(data[19] != null ? data[19].toString() : "");

        panel.add(new JLabel("User ID:")); panel.add(userId);
        panel.add(new JLabel("Full Name:")); panel.add(fullName);
        panel.add(new JLabel("Email:")); panel.add(email);
        panel.add(new JLabel("Password (leave blank to keep):")); panel.add(password);
        panel.add(new JLabel("Contact Number:")); panel.add(contactNumber);
        panel.add(new JLabel("Address:")); panel.add(address);
        panel.add(new JLabel("City:")); panel.add(city);
        panel.add(new JLabel("State:")); panel.add(state);
        panel.add(new JLabel("Postal Code:")); panel.add(postalCode);
        panel.add(new JLabel("Country:")); panel.add(country);
        panel.add(new JLabel("Service Type:")); panel.add(serviceType);
        panel.add(new JLabel("Experience Years:")); panel.add(experienceYears);
        panel.add(new JLabel("Skills:")); panel.add(skills);
        panel.add(new JLabel("Profile Picture:")); panel.add(profilePicture);
        panel.add(new JLabel("Description:")); panel.add(description);
        panel.add(new JLabel("Reviews:")); panel.add(reviews);
        panel.add(new JLabel("Rating:")); panel.add(rating);

        int result = JOptionPane.showConfirmDialog(this, panel, "Update Service Provider", JOptionPane.OK_CANCEL_OPTION, JOptionPane.PLAIN_MESSAGE);
        if (result == JOptionPane.OK_OPTION) {
            try (Connection conn = dehari.database.DBConnection.getConnection()) {
                StringBuilder sql = new StringBuilder("UPDATE service_providers SET ");
                sql.append("user_id=?, full_name=?, email=?, ");
                if (!password.getText().isEmpty()) {
                    sql.append("password=?, ");
                }
                sql.append("contact_number=?, address=?, city=?, state=?, postal_code=?, country=?, service_type=?, experience_years=?, skills=?, profile_picture=?, description=?, reviews=?, rating=? WHERE id=?");
                PreparedStatement stmt = conn.prepareStatement(sql.toString());

                int idx = 1;
                stmt.setInt(idx++, Integer.parseInt(userId.getText()));
                stmt.setString(idx++, fullName.getText());
                stmt.setString(idx++, email.getText());
                if (!password.getText().isEmpty()) {
                    stmt.setString(idx++, hashPassword(password.getText()));
                }
                stmt.setString(idx++, contactNumber.getText());
                stmt.setString(idx++, address.getText());
                stmt.setString(idx++, city.getText());
                stmt.setString(idx++, state.getText());
                stmt.setString(idx++, postalCode.getText());
                stmt.setString(idx++, country.getText());
                stmt.setString(idx++, serviceType.getText());
                stmt.setObject(idx++, experienceYears.getText().isEmpty() ? null : Integer.parseInt(experienceYears.getText()));
                stmt.setString(idx++, skills.getText());
                stmt.setString(idx++, profilePicture.getText());
                stmt.setString(idx++, description.getText());
                stmt.setString(idx++, reviews.getText());
                stmt.setObject(idx++, rating.getText().isEmpty() ? null : new java.math.BigDecimal(rating.getText()));
                stmt.setInt(idx, (Integer) data[0]);
                stmt.executeUpdate();
                JOptionPane.showMessageDialog(this, "Service provider updated!");
                refreshProviderTable(model);
            } catch (Exception ex) {
                ex.printStackTrace();
                JOptionPane.showMessageDialog(this, "Error: " + ex.getMessage());
            }
        }
    }

    private void deleteSelectedProviders(DefaultTableModel model, JTable table) {
        int[] rows = table.getSelectedRows();
        if (rows.length == 0) {
            JOptionPane.showMessageDialog(this, "Select at least one provider to delete.");
            return;
        }
        int confirm = JOptionPane.showConfirmDialog(this, "Delete selected provider(s)?", "Confirm Delete", JOptionPane.YES_NO_OPTION);
        if (confirm != JOptionPane.YES_OPTION) return;

        try (Connection conn = dehari.database.DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {
            for (int row : rows) {
                Object id = table.getValueAt(row, 0);
                stmt.executeUpdate("DELETE FROM service_providers WHERE id=" + id);
            }
            JOptionPane.showMessageDialog(this, "Deleted!");
            refreshProviderTable(model);
        } catch (Exception ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error: " + ex.getMessage());
        }
    }

    private void refreshProviderTable(DefaultTableModel model) {
        model.setRowCount(0);
        try (Connection conn = dehari.database.DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT id, user_id, full_name, email, password, contact_number, address, city, state, postal_code, country, service_type, experience_years, skills, profile_picture, description, created_at, updated_at, reviews, rating FROM service_providers")) {
            while (rs.next()) {
                model.addRow(new Object[]{
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getString("full_name"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("contact_number"),
                    rs.getString("address"),
                    rs.getString("city"),
                    rs.getString("state"),
                    rs.getString("postal_code"),
                    rs.getString("country"),
                    rs.getString("service_type"),
                    rs.getObject("experience_years"),
                    rs.getString("skills"),
                    rs.getString("profile_picture"),
                    rs.getString("description"),
                    rs.getString("created_at"),
                    rs.getString("updated_at"),
                    rs.getString("reviews"),
                    rs.getObject("rating")
                });
            }
        } catch (Exception ex) {
            ex.printStackTrace();
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
            return password;
        }
    }
}