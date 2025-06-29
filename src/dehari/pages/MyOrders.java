package dehari.pages;

import dehari.components.SimpleForm;
import dehari.model.ModelBookedService;
import dehari.model.ModelUser;
import net.miginfocom.swing.MigLayout;

import javax.swing.*;
import java.awt.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MyOrders extends SimpleForm {

    private final ModelUser currentUser;

    public MyOrders(ModelUser currentUser) {
        this.currentUser = currentUser;
        init();
    }

    private void init() {
        setLayout(new MigLayout("fill,insets 20", "[center]", "[top]"));

        int userId = currentUser.getId();
        List<ModelBookedService> orders = fetchOrdersForUser(userId);

        JPanel cardsPanel = new JPanel(new MigLayout("wrap 1, gap 15", "[grow,fill]", ""));
        for (ModelBookedService order : orders) {
            cardsPanel.add(createOrderCard(order), "growx");
        }
        add(new JScrollPane(cardsPanel), "grow, push");
    }

    private List<ModelBookedService> fetchOrdersForUser(int userId) {
        List<ModelBookedService> orders = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dehari_app?useSSL=false&serverTimezone=UTC", "root", "");
             PreparedStatement ps = conn.prepareStatement(
                 "SELECT * FROM booked_services WHERE user_id = ? ORDER BY booking_date DESC")) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                orders.add(new ModelBookedService(
                    rs.getInt("user_id"),
                    rs.getString("user_name"),
                    rs.getInt("service_provider_id"),
                    rs.getString("service_provider_name"),
                    rs.getString("service_name"),
                    rs.getDouble("price"),
                    rs.getTimestamp("booking_date") // Pass the actual booking date
                ));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return orders;
    }

    private JPanel createOrderCard(ModelBookedService order) {
        JPanel card = new JPanel();
        card.setLayout(new BorderLayout());
        card.setBackground(UIManager.getColor("Panel.background"));
        card.setBorder(BorderFactory.createCompoundBorder(
            BorderFactory.createLineBorder(new Color(0xE0E0E0), 1, true),
            BorderFactory.createEmptyBorder(12, 16, 12, 16)
        ));

        // Header
        JLabel header = new JLabel("Booked Order", SwingConstants.CENTER);
        header.setOpaque(true);
        header.setBackground(new Color(0x1976D2)); // FlatLaf primary blue
        header.setForeground(Color.WHITE);
        header.setFont(header.getFont().deriveFont(Font.BOLD, 14f));
        header.setBorder(BorderFactory.createEmptyBorder(8, 0, 8, 0));
        card.add(header, BorderLayout.NORTH);

        // Body
        JPanel body = new JPanel();
        body.setOpaque(false);
        body.setLayout(new BoxLayout(body, BoxLayout.Y_AXIS));
        body.setBorder(BorderFactory.createEmptyBorder(16, 0, 16, 0));

        JLabel title = new JLabel(order.getServiceName(), SwingConstants.CENTER);
        title.setFont(title.getFont().deriveFont(Font.BOLD, 16f));
        title.setAlignmentX(Component.CENTER_ALIGNMENT);

        JLabel text = new JLabel(
            "<html>Provider: <b>" + order.getServiceProviderName() + "</b><br>" +
            "Price: <b>RS " + order.getPrice() + "</b><br>" +
            "Booked by: <b>" + order.getUserName() + "</b></html>",
            SwingConstants.CENTER
        );
        text.setFont(text.getFont().deriveFont(Font.PLAIN, 13f));
        text.setAlignmentX(Component.CENTER_ALIGNMENT);

//        JButton btn = new JButton("Go somewhere");
//        btn.setAlignmentX(Component.CENTER_ALIGNMENT);
//        btn.putClientProperty("JButton.buttonType", "primary"); // FlatLaf style

        body.add(title);
        body.add(Box.createVerticalStrut(8));
        body.add(text);
        body.add(Box.createVerticalStrut(16));
//        body.add(btn);

        card.add(body, BorderLayout.CENTER);

        // Footer
        JLabel footer = new JLabel(
            order.getBookingDate().toString(),
            SwingConstants.CENTER
        );
        footer.setOpaque(true);
        footer.setBackground(new Color(0xF5F5F5));
        footer.setForeground(new Color(0x757575));
        footer.setFont(footer.getFont().deriveFont(Font.ITALIC, 12f));
        footer.setBorder(BorderFactory.createEmptyBorder(8, 0, 8, 0));
        card.add(footer, BorderLayout.SOUTH);

        return card;
    }
}