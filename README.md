# Demo Flutter App

A Flutter demo application showcasing modern mobile app development practices including clean architecture, BLoC pattern, API integration, and local storage.

## 📱 Features

- **Authentication**: Login & Signup with form validation and encrypted password storage
- **Home Screen**: Movie carousel slider and grid view with infinite scroll pagination
- **Favourites**: Save movies locally using SharedPreferences
- **Account**: User profile and logout functionality
- **Internationalization**: All strings externalized using Flutter's intl package

## 🏗️ Architecture

```
lib/
├── bloc/                 # State management (Cubit + Freezed)
├── core/
│   ├── constants/        # App spacing, theme constants
│   ├── network/          # API service, Dio client
│   └── widgets/          # Reusable UI components
├── data/local/           # SharedPreferences storage
├── l10n/                 # Localization (ARB files)
├── models/               # Data models (Freezed + JSON)
├── router/               # Go Router navigation
└── screens/              # UI screens organized by feature
```

## 🛠️ Tech Stack

| Category | Technology |
|----------|------------|
| State Management | `flutter_bloc` (Cubit) |
| Data Classes | `freezed`, `json_serializable` |
| Navigation | `go_router` |
| HTTP Client | `dio` |
| Error Handling | `dartz` (Either type) |
| Local Storage | `shared_preferences` |
| Image Loading | `cached_network_image` |
| UI Components | `carousel_slider` |
| Localization | `intl`, `flutter_localizations` |

## 🚀 Setup Instructions

### Prerequisites

- Flutter SDK (>=3.10.0)
- Dart SDK (>=3.0.0)

### 1. Clone the repository

```bash
git clone https://github.com/yourusername/Demo-Flutter.git
cd Demo-Flutter
```

### 2. Configure TMDB API Key

This app uses [The Movie Database (TMDB)](https://www.themoviedb.org/) API.

1. Get your free API key from [TMDB Settings](https://www.themoviedb.org/settings/api)
2. Copy the sample config file:
   ```bash
   cp lib/core/network/api_constants.sample.dart lib/core/network/api_constants.dart
   ```
3. Open `lib/core/network/api_constants.dart` and replace the placeholders:
   ```dart
   static const String apiKey = 'YOUR_TMDB_API_KEY_HERE';
   static const String bearerToken = 'YOUR_TMDB_BEARER_TOKEN_HERE';
   ```

### 3. Install dependencies

```bash
flutter pub get
```

### 4. Generate code (Freezed models)

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 5. Run the app

```bash
flutter run
```

## 📸 Screenshots

| Splash | Login | Signup |
|--------|-------|--------|
| ![Splash](screenshots/splash.png) | ![Login](screenshots/login.png) | ![Signup](screenshots/signup.png) |

| Home | Favourites | Account |
|------|------------|---------|
| ![Home](screenshots/home.png) | ![Favourites](screenshots/favourites.png) | ![Account](screenshots/account.png) |

## 📁 Project Structure Details

### State Management (BLoC/Cubit)
- `AuthCubit` - Handles login, signup, logout
- `MovieCubit` - Manages movie fetching and pagination

### API Layer
- `ApiService` - Dio-based HTTP client with error handling
- `MovieRepository` - Abstract interface + implementation
- Uses `Either<ApiException, T>` for functional error handling

### Local Storage
- `AuthLocalStorage` - User data & login state with encrypted passwords
- `FavoritesLocalStorage` - Favorite movie IDs and data

### Localization
- All strings in `lib/l10n/app_en.arb`
- Access via `AppLocalizations.of(context).stringKey`

## 🔐 Security

- API keys are **not** committed to version control
- Passwords are encrypted using the `encrypt` package before storage
- Sample config file provided for easy setup

## 📄 License

This project is for demonstration purposes.

## 👤 Author

Rahul Kumawat
