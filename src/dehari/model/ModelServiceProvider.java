package dehari.model;

public class ModelServiceProvider {
    private final int userId;
    private final String fullName;
    private final String email;
    private final String serviceType;
    private final String profilePicture;
    private final String description;  // ✅ New field

    public ModelServiceProvider(int userId, String fullName, String email, String serviceType, String profilePicture, String description) {
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.serviceType = serviceType;
        this.profilePicture = profilePicture;
        this.description = description;  // ✅ Assign new field
    }

    public int getUserId() {
        return userId;
    }

    public String getFullName() {
        return fullName;
    }

    public String getEmail() {
        return email;
    }

    public String getServiceType() {
        return serviceType;
    }

    public String getProfilePicture() {
        return profilePicture;
    }

    public String getDescription() {  // ✅ New getter
        return description;
    }
}
