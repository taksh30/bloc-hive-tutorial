# bloc_hive_tutorial

This project is a Todo application built using Flutter with Bloc for state management and Hive for local storage. It demonstrates how to efficiently manage application state and data persistence in a clean and scalable way.

Project Structure
The codebase is organized with a clear separation of concerns, following Clean Architecture principles. Here’s an overview:
Features: Contains all business logic and UI related to the Todo feature.
Data Layer: Implements the Hive repository for CRUD operations on todo items.
Domain Layer: Contains entities and repository interfaces, making the app easily extensible.
Presentation Layer: Manages the user interface and state using Bloc and Cubit.

Key Technologies
Bloc: A predictable state management library that helps to implement the Business Logic Component (BLoC) pattern. The app's state flows between different states (initial, loading, loaded, error), making it easy to manage and test.
Hive: A lightweight, NoSQL, key-value database solution, ideal for local storage on Flutter. Here, Hive handles the persistent storage of todo items and offers quick read/write capabilities.

![project_structure](https://github.com/user-attachments/assets/92164ce6-27e9-4ce1-831c-02139af1890b)
![cubit](https://github.com/user-attachments/assets/fd758744-bdd0-4017-8e18-abde5c282722)
![hive](https://github.com/user-attachments/assets/df3e771c-01da-487f-ac4c-d743acda5291)




## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
