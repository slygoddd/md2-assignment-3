# Flutter Notes App with Firebase (Assignment 3)

A cross-platform mobile application for managing personal notes, built as part of the MD2 course. The app integrates **Firebase Authentication** for secure user management and **Cloud Firestore** for real-time data persistence.

## 🚀 Key Features

### 1. Authentication (Auth)
* **User Accounts**: Registration and Login functionality.
* **Route Guarding**: Protected routes using `GoRouter`. Unauthenticated users are automatically redirected to the login page.
* **Secure Logout**: Option to sign out and clear the session.

### 2. Notes Management (CRUD)
* **Create**: Add new notes with a title and body via a pop-up dialog.
* **Read**: View a real-time list of your notes synced from Firestore.
* **Update**: Edit existing notes instantly.
* **Delete**: Remove notes from the database with a single click.

## 🛠 Tech Stack
* **Framework**: Flutter
* **State Management**: Riverpod
* **Navigation**: GoRouter
* **Backend**: Firebase Auth & Cloud Firestore

## 📁 Project Structure
The project follows a feature-first folder structure for better scalability:
- `lib/features/auth/` – Authentication logic, providers, and UI screens.
- `lib/features/notes/` – CRUD operations and the main notes list interface.
- `lib/routing.dart` – Centralized routing configuration and navigation guards.

## 👨‍💻 Author
**Developed by:** [Alikhan]
