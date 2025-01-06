# BankJoy iOS Assessment Project

<div style="display: flex; flex-wrap: nowrap; justify-content: space-between; align-items: center;">
    <img src="https://github.com/user-attachments/assets/697a81a0-fcb8-41f4-9222-dd1f6822d072" alt="Screenshot 1" style="width: 20%; margin-right: 10px;" />
    <img src="https://github.com/user-attachments/assets/85fdb30d-a7b8-43f8-a960-a0269f01f1ad" alt="Screenshot 2" style="width: 20%; margin-right: 10px;" />
    <img src="https://github.com/user-attachments/assets/66aba475-803c-4b87-830d-99ca1cf8d5c7" alt="Screenshot 4" style="width: 20%; margin-right: 10px;" />
    <img src="https://github.com/user-attachments/assets/3077eaf4-a0a3-4756-b9b3-5a33900a0c45" alt="Screenshot 5" style="width: 20%;" />
</div>

## Overview

This project demonstrates the implementation of an iOS application using the MVVM (Model-View-ViewModel) pattern combined with Combine framework and Unit Tests.

## Architecture

### MVVM (Model-View-ViewModel)

- **Model**: Responsible for the data and business logic of the application. It represents the data structures and handles data manipulation.
- **View**: Responsible for the UI components. It displays the data from the ViewModel and handles user interactions.
- **ViewModel**: Acts as a bridge between the Model and the View. It handles the presentation logic and data transformations required for the View. It uses Combine to bind data between the Model and the View.

### Combine Framework

The Combine framework is used for handling asynchronous events by combining reactive programming and declarative syntax. It is used to bind data between the Model and the ViewModel and update the View based on changes in data.

### Unit Tests

Unit Tests are implemented to ensure the correctness of the application. They validate the logic in the ViewModel and ensure the data binding between the ViewModel and the View.

## Features

- **User Authentication**: Users can enter their username and password to log in. The credentials are validated using a set of rules implemented in the ViewModel.
- **Real-time Validation**: The username and password fields are validated in real-time, and appropriate error messages and UI updates are displayed.

## Implementation Details

### ViewModel

- **UserViewModel**: Handles user input validation for username and password, and provides error messages to the view.

### ViewController

- **LoginViewController**: Displays the login interface, binds to the ViewModel, and updates the UI based on validation results.

### Validation Service

- **ValidationService**: Provides validation logic for username and password using regular expressions and predefined rules.

### Testing

- **Unit Tests**: Comprehensive unit tests for the ViewModel to ensure correctness of the validation logic and data binding.

- <img width="984" alt="Screenshot 2025-01-06 at 2 03 27 AM" src="https://github.com/user-attachments/assets/9ab696ae-ca85-429a-9678-8349a045089e" />


## How to Run

1. Clone the repository.
2. Open the project in Xcode.
3. Build and run the project on the iOS Simulator or a physical device.

## Unit Testing

To run the unit tests:

1. Open the project in Xcode.
2. Press `Command + U` to execute all unit tests.
3. Verify that all tests pass successfully.

