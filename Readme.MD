# ShortCut Link Flutter Web App ✂🔗

CutLink is a simple and straightforward URL shortener web application built using Flutter Web. This project provides an easy-to-use interface for creating shortened URLs quickly.

## Features
- **Simple Interface**: Clean, no-frills design focused on functionality
- **Fast URL Shortening**: Generate short URLs with minimal clicks
- **Cross-Platform**: Works on all modern web browsers

## Technologies

- **Framework**: Flutter Web
- **Language**: Dart
- **State Management**: GetX
- **HTTP Client**: Dio

## Getting Started

### Prerequisites

Ensure the following tools are installed:

- [Flutter](https://flutter.dev/docs/get-started/install) (latest stable version)
- [Dart](https://dart.dev/get-dart)

### Clone the Repository

```bash
git clone https://github.com/andresilvase/cutlink-app.git
cd cutlink-app
```

### Build and Run the Application

1. Get dependencies:
```bash
flutter pub get
```

2. Run the web app in debug mode:
```bash
flutter run -d chrome
```

3. Build for production:
```bash
flutter build web
```

## Available Commands

- `flutter run -d chrome`: Starts development server
- `flutter build web`: Creates production build
- `flutter test`: Run tests
- `flutter analyze`: Run static analysis

## Main Screens

- **Home Screen**: Single input field for URL with submit button
- **Result View**: Shows shortened URL with copy option

## Deployment

For production deployment, you can host the built web files on:
- **AWS Amplify**
- **AWS S3**

Configuration file example (`.env`):
```env
API_URL=https://api.cutli.ink
```

Remember to update the `web/index.html` with your application details and any required meta tags.

**Note**: This is a web-only Flutter application optimized for URL shortening functionality. The build size has been optimized for web deployment by disabling unnecessary Flutter features.