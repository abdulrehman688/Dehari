package dehari.pages;

import com.formdev.flatlaf.FlatClientProperties;
import dehari.components.SimpleForm;
import dehari.menu.FormManager;
import dehari.model.ModelServiceProvider;
import net.miginfocom.swing.MigLayout;

import javax.swing.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.net.URL;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ServiceProviderList extends SimpleForm {

    private final int PAGE_SIZE = 6;
    private int currentPage = 0;
    private List<ModelServiceProvider> filteredProviders = new ArrayList<>();

    private JPanel providersPanel;
    private JButton btnPrev, btnNext;
    private JLabel lblPage;

    public ServiceProviderList(String serviceType) {
        init();
        if (serviceType == null || serviceType.isEmpty()) {
            // Fallback to a default, e.g. "Carpenter"
            serviceType = "Carpenter";
        }
        filteredProviders = fetchProvidersByServiceType(serviceType);
        updateProvidersPanel();
    }


    private void init() {
        setLayout(new MigLayout("fill, insets 20", "[grow, center]", "[]20[]20[]"));

        // Service Type Cards (clickable)
        JPanel cardsPanel = new JPanel(new MigLayout("insets 0, gap 30, wrap 4"));
        cardsPanel.setOpaque(false);

        // Each card with click listener to filter providers
        cardsPanel.add(createClickableCard("Carpenter", "\uD83C\uDFE0", "#FFECB3"), "w 220!, h 180!");
        cardsPanel.add(createClickableCard("Plumber", "\uD83D\uDD27", "#C8E6C9"), "w 220!, h 180!");
        cardsPanel.add(createClickableCard("Electrician", "\u26A1", "#BBDEFB"), "w 220!, h 180!");
        cardsPanel.add(createClickableCard("Welder", "\uD83D\uDD27", "#FFE082"), "w 220!, h 180!");
        cardsPanel.add(createClickableCard("Roofer", "\uD83C\uDFE0", "#C8E6C9"), "w 220!, h 180!");
        cardsPanel.add(createClickableCard("Mechanic", "\uD83D\uDEE0", "#FFCCBC"), "w 220!, h 180!");
        cardsPanel.add(createClickableCard("Glazier", "\uD83D\uDD33", "#E1BEE7"), "w 220!, h 180!");
        cardsPanel.add(createClickableCard("Tile Setter", "\uD83D\uDFE9", "#FFF9C4"), "w 220!, h 180!");

        add(cardsPanel, "center, wrap");

        // Providers Section with Pagination
        providersPanel = new JPanel(new MigLayout("wrap 3, gap 20", "[grow, fill][grow, fill][grow, fill]", ""));
        providersPanel.setOpaque(false);
        add(providersPanel, "growx, pushx, gapy 30, wrap");

        JPanel paginationPanel = new JPanel(new FlowLayout(FlowLayout.CENTER, 20, 0));
        btnPrev = new JButton("Previous");
        btnNext = new JButton("Next");
        lblPage = new JLabel("Page 0");

        btnPrev.setEnabled(false);
        btnPrev.addActionListener(e -> {
            if (currentPage > 0) {
                currentPage--;
                updateProvidersPanel();
            }
        });

        btnNext.addActionListener(e -> {
            if ((currentPage + 1) * PAGE_SIZE < filteredProviders.size()) {
                currentPage++;
                updateProvidersPanel();
            }
        });

        paginationPanel.add(btnPrev);
        paginationPanel.add(lblPage);
        paginationPanel.add(btnNext);

        add(paginationPanel, "gaptop 10");
    }

    private JPanel createClickableCard(String serviceName, String icon, String bgColorHex) {
        Font emojiFont = new Font("Segoe UI Emoji", Font.PLAIN, 36);
        Font titleFont = new Font("SansSerif", Font.BOLD, 18);
        Color textColor = Color.decode("#212121");

        JLabel lblIcon = new JLabel(icon, SwingConstants.CENTER);
        lblIcon.setFont(emojiFont);
        lblIcon.setForeground(textColor);
        lblIcon.setPreferredSize(new Dimension(60, 50));

        JLabel lblService = new JLabel(serviceName, SwingConstants.CENTER);
        lblService.setFont(titleFont);
        lblService.setForeground(textColor);

        JButton btnSeeMore = new JButton("See Providers");
        btnSeeMore.putClientProperty(FlatClientProperties.STYLE, "arc:15; background:#FFFFFF; foreground:#000000");

        JPanel panel = new JPanel(new MigLayout("wrap, align center", "center", "[]10[]10[]"));
        panel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
        panel.putClientProperty(FlatClientProperties.STYLE, "arc:20; background:" + bgColorHex + ";");

        panel.add(lblIcon, "gapbottom 5");
        panel.add(lblService);
        panel.add(btnSeeMore, "gapy 5, growx");

        btnSeeMore.addActionListener(e -> {
            currentPage = 0;
            filteredProviders = fetchProvidersByServiceType(serviceName);
            updateProvidersPanel();
        });

        return panel;
    }

    private void updateProvidersPanel() {
        providersPanel.removeAll();

        int start = currentPage * PAGE_SIZE;
        int end = Math.min(start + PAGE_SIZE, filteredProviders.size());

        for (int i = start; i < end; i++) {
            ModelServiceProvider sp = filteredProviders.get(i);
            providersPanel.add(createServiceProviderCard(sp, "#8c52ff"));
        }

        btnPrev.setEnabled(currentPage > 0);
        btnNext.setEnabled((currentPage + 1) * PAGE_SIZE < filteredProviders.size());
        lblPage.setText("Page " + (currentPage + 1));

        providersPanel.revalidate();
        providersPanel.repaint();
    }

    private List<ModelServiceProvider> fetchProvidersByServiceType(String serviceType) {
        List<ModelServiceProvider> providers = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dehari_app", "root", "")) {
            String query = "SELECT user_id, full_name, email, service_type, profile_picture, description FROM service_providers WHERE service_type = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, serviceType);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ModelServiceProvider sp = new ModelServiceProvider(
                    rs.getInt("user_id"),
                    rs.getString("full_name"),
                    rs.getString("email"),
                    rs.getString("service_type"),
                    rs.getString("profile_picture"),
                    rs.getString("description")
                );
                providers.add(sp);
            }
            rs.close();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return providers;
    }

    private JPanel createServiceProviderCard(ModelServiceProvider provider, String bgColorHex) {
        String imagePath = provider.getProfilePicture();
        URL imgUrl = getClass().getResource(imagePath);
        ImageIcon icon;
        if (imgUrl != null) {
            Image img = new ImageIcon(imgUrl).getImage();
            img = img.getScaledInstance(300, 150, Image.SCALE_SMOOTH);
            icon = new ImageIcon(img);
        } else {
            System.err.println("Image not found: " + imagePath);
            icon = new ImageIcon(new BufferedImage(300, 150, BufferedImage.TYPE_INT_ARGB));
        }

        JLabel lblImage = new JLabel(icon);
        lblImage.setPreferredSize(new Dimension(300, 150));
        lblImage.setBorder(BorderFactory.createMatteBorder(0, 0, 1, 0, Color.LIGHT_GRAY));

        JLabel lblService = new JLabel(provider.getServiceType());
        lblService.setFont(new Font("SansSerif", Font.BOLD, 18));
        lblService.setForeground(Color.decode("#212121"));

        JLabel lblProvider = new JLabel(provider.getFullName());
        lblProvider.setFont(new Font("SansSerif", Font.PLAIN, 13));
        lblProvider.setForeground(Color.decode("#FFFFFF"));

        JButton btnBookNow = new JButton("Book Now");
        btnBookNow.putClientProperty(FlatClientProperties.STYLE,
            "arc:15; background:#1976D2; foreground:#FFFFFF; padding 8 15");

        btnBookNow.addActionListener(e -> showBookingModal(provider, imagePath, bgColorHex));

        JPanel bodyPanel = new JPanel(new MigLayout("wrap 1, insets 15 20 15 20, gapy 5"));
        bodyPanel.setOpaque(false);
        bodyPanel.add(lblService, "growx");
        bodyPanel.add(lblProvider, "growx");
        bodyPanel.add(btnBookNow, "center, growx");

        JPanel cardPanel = new JPanel(new MigLayout("wrap 1, insets 0", "[grow]", "[]0[]"));
        cardPanel.putClientProperty(FlatClientProperties.STYLE, "arc:20; background:" + bgColorHex + ";");
        cardPanel.add(lblImage);
        cardPanel.add(bodyPanel);
        cardPanel.setPreferredSize(new Dimension(300, 280));

        return cardPanel;
    }

    private void showBookingModal(ModelServiceProvider provider, String imagePath, String bgColorHex) {
        JDialog modal = new JDialog(SwingUtilities.getWindowAncestor(this), "Service Provider Details", Dialog.ModalityType.APPLICATION_MODAL);
        modal.setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
        modal.setSize(600, 750);
        modal.setLocationRelativeTo(this);

        JPanel content = new JPanel(new MigLayout("fillx, wrap 1, insets 25", "[grow]", "[]20[]10[]10[]10[]push[]"));
        content.setBackground(Color.WHITE);

        ImageIcon mainIcon = new ImageIcon(getClass().getResource(imagePath));
        Image mainImg = mainIcon.getImage().getScaledInstance(550, 300, Image.SCALE_SMOOTH);
        JLabel lblMainImage = new JLabel(new ImageIcon(mainImg));
        lblMainImage.setBorder(BorderFactory.createLineBorder(Color.LIGHT_GRAY, 1));
        content.add(lblMainImage, "center");

        JPanel profileRow = new JPanel(new FlowLayout(FlowLayout.LEFT));
        profileRow.setOpaque(false);

        JLabel lblName = new JLabel(provider.getFullName());
        lblName.setFont(new Font("SansSerif", Font.BOLD, 20));
        lblName.setForeground(Color.decode("#212121"));
        profileRow.add(lblName);

        content.add(profileRow);

        JLabel lblService = new JLabel(provider.getServiceType());
        lblService.setFont(new Font("SansSerif", Font.PLAIN, 18));
        lblService.setForeground(Color.decode("#424242"));
        content.add(lblService);

        JLabel lblCharge = new JLabel("Service Charge: PKR 500");
        lblCharge.setFont(new Font("SansSerif", Font.BOLD, 22));
        lblCharge.setForeground(Color.decode("#8c52ff"));
        content.add(lblCharge);

        JTextArea txtDescription = new JTextArea(provider.getDescription());
        txtDescription.setFont(new Font("SansSerif", Font.PLAIN, 16));
        txtDescription.setWrapStyleWord(true);
        txtDescription.setLineWrap(true);
        txtDescription.setEditable(false);
        txtDescription.setOpaque(false);
        txtDescription.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
        txtDescription.setForeground(Color.decode("#424242"));
        content.add(txtDescription, "growx, h 180!");

        JPanel buttonsPanel = new JPanel(new FlowLayout(FlowLayout.CENTER, 15, 0));
        buttonsPanel.setOpaque(false);

        JButton btnConfirm = new JButton("Confirm Booking");
        btnConfirm.putClientProperty(FlatClientProperties.STYLE,
            "arc:20; background:#388E3C; foreground:#FFFFFF; padding:10 20");
        btnConfirm.addActionListener(e -> {
            if (FormManager.currentUser == null) {
                JOptionPane.showMessageDialog(modal, "User not logged in.", "Error", JOptionPane.ERROR_MESSAGE);
                return;
            }

            int userId = FormManager.currentUser.getId();
            String userName = FormManager.currentUser.getFullName();

            int confirm = JOptionPane.showConfirmDialog(modal,
                "Are you sure you want to confirm the booking for PKR 500?",
                "Confirm Booking", JOptionPane.YES_NO_OPTION, JOptionPane.QUESTION_MESSAGE);

            if (confirm == JOptionPane.YES_OPTION) {
                try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dehari_app", "root", "")) {
                    String insert = "INSERT INTO booked_services (user_id, user_name, service_provider_id, service_provider_name, service_name, price) VALUES (?, ?, ?, ?, ?, ?)";
                    PreparedStatement stmt = conn.prepareStatement(insert);
                    stmt.setInt(1, userId);
                    stmt.setString(2, userName);
                    stmt.setInt(3, provider.getUserId());
                    stmt.setString(4, provider.getFullName());
                    stmt.setString(5, provider.getServiceType());
                    stmt.setInt(6, 500);

                    int rows = stmt.executeUpdate();
                    if (rows > 0) {
                        JOptionPane.showMessageDialog(modal, "Booking confirmed!", "Success", JOptionPane.INFORMATION_MESSAGE);
                        modal.dispose();
                    } else {
                        JOptionPane.showMessageDialog(modal, "Booking failed!", "Error", JOptionPane.ERROR_MESSAGE);
                    }
                    stmt.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                    JOptionPane.showMessageDialog(modal, "Database error: " + ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
                }
            }
        });

        JButton btnCancel = new JButton("Cancel");
        btnCancel.putClientProperty(FlatClientProperties.STYLE,
            "arc:20; background:#E53935; foreground:#FFFFFF; padding:10 20");
        btnCancel.addActionListener(e -> modal.dispose());

        buttonsPanel.add(btnConfirm);
        buttonsPanel.add(btnCancel);

        content.add(buttonsPanel, "center, gapy 10");

        modal.setContentPane(content);
        modal.setVisible(true);
    }
}
