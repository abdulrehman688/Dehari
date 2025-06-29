package dehari.forms;

import dehari.components.SimpleForm;
import dehari.model.ModelUser;

import javax.swing.*;

public class ManageBookedServices extends SimpleForm {

    public ManageBookedServices(ModelUser user) {
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
        setLayout(new net.miginfocom.swing.MigLayout("fill,insets 20", "[center]", "[top]"));

        String[] columnNames = {
            "ID", "User ID", "User Name", "Service Provider ID", "Service Provider Name",
            "Service Name", "Price", "Booking Date"
        };
        javax.swing.table.DefaultTableModel model = new javax.swing.table.DefaultTableModel(null, columnNames) {
            @Override
            public boolean isCellEditable(int row, int column) {
                return false;
            }
        };

        try (java.sql.Connection conn = dehari.database.DBConnection.getConnection();
             java.sql.Statement stmt = conn.createStatement();
             java.sql.ResultSet rs = stmt.executeQuery(
                 "SELECT id, user_id, user_name, service_provider_id, service_provider_name, service_name, price, booking_date FROM booked_services")) {
            while (rs.next()) {
                model.addRow(new Object[]{
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getString("user_name"),
                    rs.getInt("service_provider_id"),
                    rs.getString("service_provider_name"),
                    rs.getString("service_name"),
                    rs.getBigDecimal("price"),
                    rs.getTimestamp("booking_date")
                });
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        JTable table = new JTable(model);
        table.setSelectionMode(ListSelectionModel.MULTIPLE_INTERVAL_SELECTION);
        JScrollPane scrollPane = new JScrollPane(table);

        // Buttons panel
        JPanel buttonPanel = new JPanel(new java.awt.FlowLayout(java.awt.FlowLayout.LEFT));
        JButton updateButton = new JButton("Update");
        JButton deleteButton = new JButton("Delete");
        buttonPanel.add(updateButton);
        buttonPanel.add(deleteButton);

        add(buttonPanel, "wrap");
        add(scrollPane, "grow, wrap");

        updateButton.addActionListener(e -> {
            int row = table.getSelectedRow();
            if (row == -1 || table.getSelectedRows().length > 1) {
                JOptionPane.showMessageDialog(this, "Please select exactly one booking to update.");
                return;
            }
            Object[] data = new Object[table.getColumnCount()];
            for (int i = 0; i < data.length; i++) data[i] = table.getValueAt(row, i);

            JPanel panel = new JPanel(new java.awt.GridLayout(0, 2, 8, 8));
            JTextField serviceName = new JTextField(data[5] != null ? data[5].toString() : "");
            JTextField price = new JTextField(data[6] != null ? data[6].toString() : "");

            panel.add(new JLabel("Service Name:")); panel.add(serviceName);
            panel.add(new JLabel("Price:")); panel.add(price);

            int result = JOptionPane.showConfirmDialog(this, panel, "Update Booking", JOptionPane.OK_CANCEL_OPTION, JOptionPane.PLAIN_MESSAGE);
            if (result == JOptionPane.OK_OPTION) {
                try (java.sql.Connection conn = dehari.database.DBConnection.getConnection();
                     java.sql.PreparedStatement stmt = conn.prepareStatement(
                        "UPDATE booked_services SET service_name=?, price=? WHERE id=?")) {
                    stmt.setString(1, serviceName.getText());
                    stmt.setBigDecimal(2, price.getText().isEmpty() ? null : new java.math.BigDecimal(price.getText()));
                    stmt.setInt(3, (Integer) data[0]);
                    stmt.executeUpdate();
                    JOptionPane.showMessageDialog(this, "Booking updated!");
                    refreshBookedServicesTable(model);
                } catch (Exception ex) {
                    ex.printStackTrace();
                    JOptionPane.showMessageDialog(this, "Error: " + ex.getMessage());
                }
            }
        });

        deleteButton.addActionListener(e -> {
            int[] rows = table.getSelectedRows();
            if (rows.length == 0) {
                JOptionPane.showMessageDialog(this, "Please select at least one booking to delete.");
                return;
            }
            int confirm = JOptionPane.showConfirmDialog(this, "Delete selected booking(s)?", "Confirm Delete", JOptionPane.YES_NO_OPTION);
            if (confirm != JOptionPane.YES_OPTION) return;

            try (java.sql.Connection conn = dehari.database.DBConnection.getConnection();
                 java.sql.Statement stmt = conn.createStatement()) {
                for (int row : rows) {
                    Object id = table.getValueAt(row, 0);
                    stmt.executeUpdate("DELETE FROM booked_services WHERE id=" + id);
                }
                JOptionPane.showMessageDialog(this, "Deleted!");
                refreshBookedServicesTable(model);
            } catch (Exception ex) {
                ex.printStackTrace();
                JOptionPane.showMessageDialog(this, "Error: " + ex.getMessage());
            }
        });
    }

    private void refreshBookedServicesTable(javax.swing.table.DefaultTableModel model) {
        model.setRowCount(0);
        try (java.sql.Connection conn = dehari.database.DBConnection.getConnection();
             java.sql.Statement stmt = conn.createStatement();
             java.sql.ResultSet rs = stmt.executeQuery(
                 "SELECT id, user_id, user_name, service_provider_id, service_provider_name, service_name, price, booking_date FROM booked_services")) {
            while (rs.next()) {
                model.addRow(new Object[]{
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getString("user_name"),
                    rs.getInt("service_provider_id"),
                    rs.getString("service_provider_name"),
                    rs.getString("service_name"),
                    rs.getBigDecimal("price"),
                    rs.getTimestamp("booking_date")
                });
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}