# Zylu Employee Manager 📱

Hello , Im not a creative MAN but did my best on UI

A modern, beautiful Flutter application for managing employee information with a sleek dark theme and intuitive user interface. Built with Flutter and designed for both Android and iOS platforms.

![Flutter](https://img.shields.io/badge/Flutter-3.8.1-blue.svg)
![Dart](https://img.shields.io/badge/Dart-3.8.1-blue.svg)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-green.svg)
![Version](https://img.shields.io/badge/Version-1.0.0-orange.svg)

## ✨ Features

- **Employee Management**: Add, view, and manage employee information
- **Beautiful UI**: Modern dark theme with neumorphic design elements
- **Search Functionality**: Real-time employee search by name or role
- **Experience Tracking**: Display years of experience for each employee
- **Status Indicators**: Visual indicators for active/inactive employees
- **Experience Badges**: Special green highlighting for employees with 5+ years experience
- **Responsive Design**: Optimized for both mobile and tablet devices
- **Offline Support**: Local data persistence with smooth animations
- **API Integration**: RESTful API communication with backend services

## 🛠️ Tech Stack

- **Framework**: Flutter 3.8.1
- **Language**: Dart 3.8.1
- **State Management**: Stateful Widgets with Provider pattern
- **Networking**: HTTP package for API communication
- **UI Components**: Material Design with custom neumorphic styling
- **Fonts**: Google Fonts integration
- **Icons**: Material Icons and custom iconography

### Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
  google_fonts: ^6.1.0
  path_provider: ^2.0.15
  cupertino_icons: ^1.0.8
```
```

## 🏗️ Project Structure

```
lib/
├── main.dart                 # Application entry point
├── app_constants.dart        # App-wide constants and themes
├── config.dart              # Environment configuration
├── models/
│   └── employee.dart        # Employee data model
├── services/
│   └── api_services.dart    # API communication layer
├── screens/
│   ├── employee_list_page.dart    # Main employee list
│   ├── employee_details_page.dart # Employee details view
│   └── add_employee_page.dart     # Add new employee form
└── widgets/
    └── employee_tile.dart   # Employee list item widget
```

## 🔌 API Integration

The app communicates with a RESTful backend API. Key endpoints:

- `GET /api/employees` - Fetch all employees
- `POST /api/employees` - Create new employee

### API Response Format

```json
{
  "employees": [
    {
      "_id": "string",
      "name": "string",
      "role": "string",
      "years": number,
      "isActive": boolean
    }
  ]
}
```