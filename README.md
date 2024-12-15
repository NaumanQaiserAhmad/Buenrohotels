# Project Name: Buenrohotels

## Features

### Bottom Navigation Bar
- Navigate between four tabs:
  - **Overview**
  - **Hotels**
  - **Favorites**
  - **Account**
<img width="993" alt="Screenshot 2024-12-15 at 06 25 05" src="https://github.com/user-attachments/assets/526e70e7-35fd-450d-85b9-6e8134bacc2b" />



### Hotels Tab
- Fetch and display a list of hotels using a serpAPI.
- Show hotel details such as:
  - Hotel name
  - Price
  - Description
  - Option to mark as favorite.

### Favorites Tab
- Display the list of favorited hotels stored locally.
- Allow users to remove hotels from favorites.

### Error Handling
- Display error messages when API calls fail.

## Architecture
The app follows the **Clean Architecture** pattern and is divided into three main layers:

### 1. Presentation Layer
- Contains UI components (screens and widgets).
- Uses **BLoC (Business Logic Component)** for state management.

### 2. Domain Layer
- Contains business logic and abstract interfaces, including:
  - Use cases
  - Entities
  - Repositories

### 3. Data Layer
- Handles data operations such as API calls and local storage.
- Converts raw data into domain entities.

<img width="373" alt="Screenshot 2024-12-15 at 03 14 43" src="https://github.com/user-attachments/assets/1c45f2d7-e06e-4104-a552-0930708b1587" />



### Work Yet to Done - Edge cases
- Show error for internet connections
- other edge cases





