# Configuration Management

This document explains how to configure the Zylu Employee Manager app for different environments.

## Environment Variables

The app uses compile-time environment variables to configure different settings. These can be set during build time using Flutter's `--dart-define` flags.

### Available Configuration Options

| Variable | Default Value | Description |
|----------|---------------|-------------|
| `API_BASE_URL` | `http://10.25.5.137:5000/api` | Backend API base URL |
| `APP_NAME` | `Zylu Employee Manager` | Application display name |
| `ENVIRONMENT` | `development` | Current environment (development/staging/production) |
| `DEBUG_MODE` | `true` | Enable debug features |
| `API_TIMEOUT` | `30` | API request timeout in seconds |
| `BUILD_NUMBER` | `1.0.0` | Application build version |
| `ENABLE_ANALYTICS` | `false` | Enable analytics tracking |
| `ENABLE_CRASH_REPORTING` | `false` | Enable crash reporting |

## Setup Instructions

### 1. Copy Environment Template

```bash
cp .env.example .env
```

### 2. Edit Configuration

Update the `.env` file with your specific values:

```bash
# Development
API_BASE_URL=http://localhost:5000/api
ENVIRONMENT=development
DEBUG_MODE=true

# Production
API_BASE_URL=https://api.zylu.com/api
ENVIRONMENT=production
DEBUG_MODE=false
ENABLE_ANALYTICS=true
```

### 3. Build with Environment Variables

#### Development Build
```bash
flutter run --dart-define-from-file=.env
```

#### Production Build
```bash
flutter build apk --release --dart-define-from-file=.env
```

#### iOS Build
```bash
flutter build ios --release --dart-define-from-file=.env
```

## Configuration Classes

### Config Class (`lib/config.dart`)
- Contains all environment variable definitions
- Uses `String.fromEnvironment()` and `bool.fromEnvironment()` for compile-time constants
- Provides default values for all settings

### ApiConfig Class (`lib/app_constants.dart`)
- References the Config class for API-specific settings
- Provides computed properties for API endpoints and headers
- Centralizes API configuration management

## Security Best Practices

1. **Never commit `.env` files** - They are added to `.gitignore`
2. **Use different configurations** for each environment
3. **Store sensitive data securely** - Consider using platform-specific secure storage for sensitive runtime data
4. **Validate configurations** at startup if needed

## Example Usage in Code

```dart
import 'package:zylu_emp/config.dart';

// Access configuration values
String apiUrl = Config.apiBaseUrl;
bool isProduction = Config.environment == 'production';

// Use in API service
final response = await http.get(
  Uri.parse('${ApiConfig.baseUrl}${ApiConfig.employeesEndpoint}'),
  headers: ApiConfig.jsonHeaders,
);
```

## Environment-Specific Builds

You can create different build flavors:

```bash
# Development
flutter build apk --flavor development --dart-define-from-file=.env.dev

# Staging
flutter build apk --flavor staging --dart-define-from-file=.env.staging

# Production
flutter build apk --flavor production --dart-define-from-file=.env.prod
```

This setup ensures sensitive information is properly managed and can be easily changed for different deployment environments.