# Flutter Clean Code Architecture with Sqflite

This repository demonstrates the implementation of **Flutter Clean Code Architecture** with the following features:

- CRUD operations using **Sqflite** Local Database.
- Offline data storage in the local database.
- Automatic synchronization of offline data when online.
- Dependency Injection using **get_it**.
- State management using **GetX**.
- Centralized error handling.

## Project Structure

The project follows **Clean Code Architecture** principles, dividing the codebase into the following layers:

### 1. **Presentation Layer**

- Handles the UI using **GetX** for state management.
- Widgets and screens are located in the `presentation` directory.

### 2. **Domain Layer**

- Contains business logic, use cases, and entities.
- Provides abstraction using interfaces for interacting with the data layer.

### 3. **Data Layer**

- Responsible for data access, including local database (Sqflite) and API calls.
- Implements the repository pattern to manage data sources.

### 4. **Core Layer**

- Contains reusable components, such as constants, dependency injection setup, and error handling.

## Features

### **1. CRUD Operations**

- Local database implementation using **Sqflite**.
- Create, Read, Update, and Delete operations are supported.

### **2. Offline Data Storage**

- Data is stored in the local database for offline access.
- The app ensures a smooth user experience even without internet connectivity.

### **3. Sync When Online**

- Data created or updated offline is synchronized with the remote server when the app detects an internet connection.

### **4. Dependency Injection**

- Dependency injection is managed using **get_it**, ensuring loose coupling and better testability.

### **5. State Management**

- **GetX** is used for reactive state management, making the application highly responsive and easy to maintain.

### **6. Centralized Error Handling**

- Errors are handled centrally to provide consistent feedback to the user.
- Ensures smooth operation and better debugging.

## Setup Instructions

1. Clone the repository:

   ```bash
   git clone <repository-url>
   ```

2. Navigate to the project directory:

   ```bash
   cd Flutter-Clean-Code-Architecture-with-Sqflite-Local-DB
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the app:

   ```bash
   flutter run
   ```

## Usage

### Creating and Updating Data

- Fill out the form and submit to create or update data in the local database.

### Sync Data

- Data created or updated offline is automatically synced to the server when the app detects an internet connection.

## Key Packages Used

| Package     | Purpose                              |
| ----------- | ------------------------------------ |
| **Sqflite** | Local database for CRUD operations.  |
| **GetX**    | State management and navigation.     |
| **get_it**  | Dependency injection.                |
| **Dio**     | HTTP requests for API communication. |

## Project Highlights

- **Clean Code Architecture**: Ensures maintainability, scalability, and testability.
- **Offline-First Approach**: Seamless offline functionality with automatic sync.
- **Reactive UI**: Built using **GetX** for highly responsive state management.
- **Loose Coupling**: Dependency injection for better code organization.

## Folder Structure

```
lib/
├── core/                   # Core utilities and error handling
├── data/                   # Data layer (repositories, models, and database)
├── domain/                 # Business logic and use cases
├── presentation/           # UI components and GetX controllers
├── main.dart               # Entry point of the application
```

## Contributions

Contributions are welcome! Feel free to submit issues, fork the repository, and open pull requests to improve the project.

## License

This project is licensed under the [MIT License](LICENSE).

---

Sheikh Md. Razibul Hasan Raj  
[rajrazibul4@gmail.com](mailto:rajrazibul4@gmail.com)  
Support me by sending a coffee! ☕


