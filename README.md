# Dehari – Home Based Services Booking App

Dehari is a Java-based desktop application that connects users with local home service providers such as electricians, plumbers, cleaners, and more. It simplifies the process of finding trusted professionals by allowing users to book services directly through the app.

---

## 🛠️ Technologies Used

- **Java** (Core Java, OOP)
- **Java Swing** (GUI)
- **MySQL** (Database)
- **FlatLaf** (Modern UI Look and Feel)
- **NetBeans** (IDE)

---

## 📦 Features

### ✅ User Features
- Browse available services and view provider profiles
- Book home services instantly
- View booking history (Orders Page)
- Register and log in securely
- Update personal info and address

### ✅ Service Provider Features
- Register as a service provider
- Add skillset, services, experience, and profile info
- View incoming bookings from users
- Update personal and service info

### ✅ Admin Features
- Login with admin credentials
- Manage (CRUD) Users, Providers, and Bookings
- Dashboard with:
  - Total Users
  - Total Booked Services
  - Total Profits Earned
- Charges:
  - 500 PKR per service from users
  - 30% commission (150 PKR) taken from service provider

---

## 🧩 System Modules

- `Login/Register Module`
- `Service Booking Module`
- `Admin Dashboard Module`
- `User & Provider Profile Management`
- `Database Connection Layer`

---

## 🧪 How to Run the Project

1. Clone the project folder or import it in **NetBeans**.
2. Make sure **MySQL server** is running.
3. Create the database using the provided SQL dump (optional).
4. Update DB credentials inside the connection/config file.
5. Run `Main.java` or the launcher class.
6. Use sample login:
   - **Admin**: `admin@dehari.com` / `admin123`
   - **User**: `user@gmail.com` / `user123`

---

## 📊 Database Tables

- `users`
- `service_providers`
- `booked_services`

Each table stores all necessary information like login, service details, user profiles, and booking records.

---

## 📁 Folder Structure

📦 src
┣ 📂 models
┣ 📂 views
┣ 📂 controllers
┣ 📂 utils
┣ Main.java
┗ db_config.properties

## 🔐 Login Roles

| Role   | Access                                |
|--------|----------------------------------------|
| Admin  | Full access to manage users & services |
| User   | Book services, view bookings           |
| Provider | Register and update service info     |

---

## 🔒 Security

- Passwords are hashed (if implemented)
- Access control based on user type
- Restricted admin features to admins only

---

## 📈 Future Improvements

- Add OTP or email verification during sign up
- Add payment gateway integration
- Notification system for booking updates
- Add rating & review system
- Export booking history as PDF

---

## 👨‍💻 Developer

**Abdul Rehman**  
📧 [rehmanabdul1445@gmail.com]  
🎓 ITSE - 2nd Semester Project

---

## 📄 License

This project is for academic purposes only. No commercial use intended.
