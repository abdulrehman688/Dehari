package dehari.model;

public class ModelUser {

    private int id;               
    private String fullName;      
    private String userName;
    private String email;
    private String password;
    private boolean admin;
    private String usertype;      
    
    // NEW: profile picture path (e.g. "/dehari/resources/image/user123.png")
    private String profileImagePath;

    // Constructors
    public ModelUser() {
    }

    public ModelUser(int id, String userName, String email, String password, boolean admin, String usertype, String profileImagePath) {
        this.id = id;
        this.userName = userName;
        this.email = email;
        this.password = password;
        this.admin = admin;
        this.usertype = usertype;
        this.profileImagePath = profileImagePath;
    }

    public ModelUser(String userName, boolean admin) {
        this.userName = userName;
        this.admin = admin;
    }

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isAdmin() {
        return admin;
    }

    public void setAdmin(boolean admin) {
        this.admin = admin;
    }

    public String getUsertype() {
        return usertype;
    }

    public void setUsertype(String usertype) {
        this.usertype = usertype;
    }

    // NEW: profileImagePath getter and setter
    public String getProfileImagePath() {
        return profileImagePath;
    }

    public void setProfileImagePath(String profileImagePath) {
        this.profileImagePath = profileImagePath;
    }
}
