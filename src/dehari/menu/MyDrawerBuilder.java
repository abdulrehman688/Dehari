package dehari.menu;

import com.formdev.flatlaf.FlatClientProperties;
import com.formdev.flatlaf.extras.FlatSVGIcon;
import dehari.forms.Checking;
import java.awt.Color;
import java.awt.Component;
import javax.swing.Icon;
import javax.swing.JButton;
import javax.swing.JComponent;
import javax.swing.JLabel;
import raven.drawer.component.DrawerPanel;
import raven.drawer.component.SimpleDrawerBuilder;
import raven.drawer.component.footer.SimpleFooterData;
import raven.drawer.component.header.SimpleHeaderData;
import raven.drawer.component.header.SimpleHeaderStyle;
import raven.drawer.component.menu.MenuAction;
import raven.drawer.component.menu.MenuEvent;
import raven.drawer.component.menu.MenuValidation;
import raven.drawer.component.menu.SimpleMenuOption;
import raven.drawer.component.menu.SimpleMenuStyle;
import raven.drawer.component.menu.data.Item;
import raven.drawer.component.menu.data.MenuItem;
import dehari.forms.DashboardForm;
import dehari.forms.InboxForm;
import dehari.forms.ManageBookedServices;
import dehari.forms.ManageServiceProviders;
import dehari.forms.ReadForm;
import dehari.model.ModelUser;
import dehari.pages.EditProfileForm;
import dehari.pages.Home;
import dehari.pages.MyOrders;
import java.io.File;
import java.net.URL;
import raven.swing.AvatarIcon;

/**
 *
 * @author Raven
 */
public class MyDrawerBuilder extends SimpleDrawerBuilder {

    private ModelUser user;
    private final ThemesChange themesChange;

    public void setUser(ModelUser user) {
        this.user = user;
        SimpleHeaderData headerData = header.getSimpleHeaderData();
        headerData.setTitle(user.getUserName());
        header.setSimpleHeaderData(headerData);
        rebuildMenu();
    }

    public MyDrawerBuilder() {
        themesChange = new ThemesChange();
    }

    @Override
    public Component getFooter() {
        return themesChange;
    }

    @Override
    public SimpleHeaderData getSimpleHeaderData() {
        AvatarIcon icon = null;

        try {
            if (user != null && user.getProfileImagePath() != null && !user.getProfileImagePath().isEmpty()) {
                String path = user.getProfileImagePath();

                if (path.startsWith("/")) {
                    // load from resource
                    java.net.URL imageUrl = getClass().getResource(path);
                    System.out.println("Loading user image resource: " + path + " -> URL: " + imageUrl);
                    if (imageUrl != null) {
                        icon = new AvatarIcon(imageUrl, 60, 60, 999);
                    }
                } else {
                    // treat as file system path
                    File file = new File(path);
                    System.out.println("Loading user image file: " + file.getAbsolutePath());
                    if (file.exists()) {
                        URL fileUrl = file.toURI().toURL();
                        icon = new AvatarIcon(fileUrl, 60, 60, 999);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (icon == null) {
            System.out.println("Loading default profile image.");
            java.net.URL defaultImageUrl = getClass().getResource("/dehari/resources/image/profile.png");
            if (defaultImageUrl != null) {
                icon = new AvatarIcon(defaultImageUrl, 60, 60, 999);
            }
        }

        icon.setBorder(2);

        String title = (user != null && user.getUserName() != null) ? user.getUserName() : "USER";

        return new SimpleHeaderData()
                .setIcon(icon)
                .setTitle(title)
                .setHeaderStyle(new SimpleHeaderStyle() {
                    @Override
                    public void styleTitle(JLabel label) {
                        label.putClientProperty(FlatClientProperties.STYLE, "[light]foreground:#FAFAFA");
                    }

                    @Override
                    public void styleDescription(JLabel label) {
                        label.putClientProperty(FlatClientProperties.STYLE, "[light]foreground:#E1E1E1");
                    }
                });
    }

    @Override
    public SimpleFooterData getSimpleFooterData() {
        return new SimpleFooterData();
    }

    @Override
    public SimpleMenuOption getSimpleMenuOption() {
        MenuItem[] items = new MenuItem[]{
            new Item("Home", "dashboard.svg"),
            new Item("Edit Profile", "ui.svg"),
            new Item("My Orders", "forms.svg"),
//            new Item("Dashboard", "dashboard.svg"),
            new Item("Dashboard", "dashboard.svg"),            
            new Item("Manage Service Providers", "forms.svg"),            
            new Item("Manage Booked Services", "forms.svg"),

            new Item("Logout", "logout.svg")
        };

        SimpleMenuOption simpleMenuOption = new SimpleMenuOption() {
            @Override
            public Icon buildMenuIcon(String path, float scale) {
                FlatSVGIcon icon = new FlatSVGIcon(path, scale);
                FlatSVGIcon.ColorFilter colorFilter = new FlatSVGIcon.ColorFilter();
                if (com.formdev.flatlaf.FlatLaf.isLafDark()) {
                    colorFilter.add(Color.decode("#969696"), Color.decode("#FAFAFA"), Color.decode("#FAFAFA"));
                } else {
                    colorFilter.add(Color.decode("#969696"), Color.decode("#222222"), Color.decode("#222222"));
                }
                icon.setColorFilter(colorFilter);
                return icon;
            }
        };

        simpleMenuOption.setMenuStyle(new SimpleMenuStyle() {
            @Override
            public void styleMenuItem(JButton menu, int[] index) {
                menu.putClientProperty(FlatClientProperties.STYLE, ""
                    + "[light]foreground:#222222;" // dark text for light theme
                    + "[dark]foreground:#FAFAFA;"  // white text for dark theme
                    + "arc:10");
            }

            @Override
            public void styleMenu(JComponent component) {
                component.putClientProperty(FlatClientProperties.STYLE, ""
                    + "[light]background:#F5F5F5;" // subtle gray for light
                    + "[dark]background:$Drawer.background;");
            }

            @Override
            public void styleLabel(JLabel label) {
                label.putClientProperty(FlatClientProperties.STYLE, ""
                        + "[light]foreground:darken(#FAFAFA,15%);"
                        + "[dark]foreground:darken($Label.foreground,30%)");
            }
        });

        simpleMenuOption.addMenuEvent(new MenuEvent() {
            @Override
            public void selected(MenuAction action, int[] index) {
                if (index.length == 1) {
                    switch (index[0]) {
                        case 0:
                            FormManager.showForm(new Home());
                            break;
                        case 1:
                            if (user != null) {
                                FormManager.showForm(new EditProfileForm(user.getId()));
                            }
                            break;
                        case 2:
                            if (user != null) {
                                FormManager.showForm(new MyOrders(user));
                            }
                            break;
//                        case 3:
//                            FormManager.showForm(new DashboardForm());
//                            break;
                        case 3:
                            FormManager.showForm(new Checking(FormManager.getCurrentUser()));
                            break;
                        case 4:
                            FormManager.showForm(new ManageServiceProviders(FormManager.getCurrentUser()));
                            break;                        
                        case 5:
                            FormManager.showForm(new ManageBookedServices(FormManager.getCurrentUser()));
                            break;
                        case 6:
                            FormManager.logout();
                            break;
                    }
                }
            }
        });

        simpleMenuOption.setMenus(items)
                .setBaseIconPath("dehari/resources/menu")
                .setIconScale(0.45f);
        return simpleMenuOption;
    }

    @Override

    public void build(DrawerPanel drawerPanel) {
        drawerPanel.putClientProperty(FlatClientProperties.STYLE, "background:$Panel.background");

    }

    @Override
    public int getDrawerWidth() {
        return 270;
    }
}
