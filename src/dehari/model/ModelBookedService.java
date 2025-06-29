package dehari.model;

import java.sql.Timestamp;

public class ModelBookedService {
    private final int userId;
    private final String userName;
    private final int serviceProviderId;
    private final String serviceProviderName;
    private final String serviceName;
    private final double price;
    private final Timestamp bookingDate;

    // Constructor for new bookings (sets bookingDate to now)
    public ModelBookedService(int userId, String userName, int serviceProviderId,
                              String serviceProviderName, String serviceName, double price) {
        this.userId = userId;
        this.userName = userName;
        this.serviceProviderId = serviceProviderId;
        this.serviceProviderName = serviceProviderName;
        this.serviceName = serviceName;
        this.price = price;
        this.bookingDate = new Timestamp(System.currentTimeMillis());
    }

    // Constructor for loading from DB (uses actual bookingDate)
    public ModelBookedService(int userId, String userName, int serviceProviderId,
                              String serviceProviderName, String serviceName, double price, Timestamp bookingDate) {
        this.userId = userId;
        this.userName = userName;
        this.serviceProviderId = serviceProviderId;
        this.serviceProviderName = serviceProviderName;
        this.serviceName = serviceName;
        this.price = price;
        this.bookingDate = bookingDate;
    }

    public int getUserId() { return userId; }
    public String getUserName() { return userName; }
    public int getServiceProviderId() { return serviceProviderId; }
    public String getServiceProviderName() { return serviceProviderName; }
    public String getServiceName() { return serviceName; }
    public double getPrice() { return price; }
    public Timestamp getBookingDate() { return bookingDate; }
}
