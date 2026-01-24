# 🌤️ GlassCast - Your Personal Weather Companion

A beautiful, modern weather application built with Flutter featuring stunning glassmorphism design and real-time weather data.

![Flutter](https://img.shields.io/badge/Flutter-3.7.2-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart)
![License](https://img.shields.io/badge/License-MIT-green)

## ✨ Features

### 🎨 Beautiful UI/UX
- **Glassmorphism Design** - Modern frosted glass aesthetic
- **Gradient Backgrounds** - Stunning blue-to-purple gradients
- **Material Design 3** - Latest design guidelines
- **Smooth Animations** - Fluid user experience
- **Responsive Layout** - Works on all screen sizes

### 🌦️ Weather Features
- **Real-time Weather** - Current weather conditions
- **5-Day Forecast** - Plan ahead with extended forecasts
- **City Search** - Search for any city worldwide
- **Favorites** - Save your favorite cities
- **Weather Details** - Temperature, humidity, wind speed, feels like
- **Temperature Units** - Toggle between Celsius and Fahrenheit

### 👤 User Features
- **User Authentication** - Secure login and registration via Supabase
- **User Profiles** - Personalized experience
- **Settings** - Customize your preferences
- **Persistent Data** - Your favorites are saved

## 📱 Screenshots

### Main Screens
- **Login Screen** - Welcome page with cloud icon and glass form
- **Home Screen** - Weather display with current conditions and forecast
- **Search Screen** - Find cities with beautiful search interface
- **Favorites Screen** - Quick access to saved cities
- **Settings Screen** - User profile and preferences
- **Register Screen** - Create new account

## 🛠️ Tech Stack

### Frontend
- **Flutter** - UI framework
- **Dart** - Programming language
- **Material Design 3** - Design system

### State Management
- **Flutter BLoC** - Business logic component
- **Cubit** - Lightweight state management
- **Equatable** - Value equality

### Backend & Services
- **Supabase** - Authentication and database
- **HTTP** - API requests
- **Weather API** - Real-time weather data

### UI Components
- **Google Fonts** - Inter typography
- **Flutter SVG** - Vector graphics support

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  equatable: ^2.0.5
  flutter_bloc: ^9.1.1
  flutter_svg: ^2.0.9
  google_fonts: ^6.1.0
  http: ^1.1.0
  supabase: ^2.10.2
  supabase_flutter: ^2.12.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / Xcode (for mobile development)
- VS Code or Android Studio with Flutter plugins

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/glasscast.git
cd glasscast
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Set up Supabase**
   - Create a Supabase project at [supabase.com](https://supabase.com)
   - Copy your project URL and anon key
   - Update `lib/main.dart` with your credentials:

```dart
await Supabase.initialize(
  url: 'YOUR_SUPABASE_URL',
  anonKey: 'YOUR_SUPABASE_ANON_KEY',
);
```

4. **Get a Weather API key** (if using external API)
   - Sign up for a weather API service
   - Add your API key to the project

5. **Run the app**
```bash
flutter run
```

## 📁 Project Structure

```
lib/
├── core/
│   ├── routes/
│   │   ├── app_router.dart          # Navigation router
│   │   └── app_routes.dart          # Route constants
│   ├── theme/
│   │   ├── app_colors.dart          # Color palette
│   │   ├── app_fonts.dart           # Font definitions
│   │   ├── app_text_styles.dart     # Text styles
│   │   ├── app_theme.dart           # Theme configuration
│   │   └── README.md                # Theme documentation
│   └── utils/
│       └── screen_utils.dart        # Responsive utilities
├── features/
│   ├── city_search/
│   │   ├── bloc/                    # City search state management
│   │   ├── model/                   # City data models
│   │   ├── repository/              # City data repository
│   │   └── screens/                 # Search UI
│   ├── favorites/
│   │   ├── bloc/                    # Favorites state management
│   │   └── repository/              # Favorites data repository
│   ├── home/
│   │   ├── bloc/                    # Weather state management
│   │   ├── model/                   # Weather data models
│   │   ├── repository/              # Weather API repository
│   │   ├── screens/                 # Home screen UI
│   │   └── widgets/                 # Weather widgets
│   ├── login/
│   │   ├── bloc/                    # Auth state management
│   │   ├── repository/              # Auth repository
│   │   ├── screens/                 # Login/Register UI
│   │   └── widgets/                 # Auth widgets
│   └── settings/
│       ├── bloc/                    # Settings state management
│       ├── screens/                 # Settings UI
│       └── widgets/                 # Settings widgets
├── widgets/
│   ├── glass_button.dart            # Glassmorphism button
│   ├── glass_container.dart         # Glassmorphism container
│   ├── glass_text_field.dart        # Glassmorphism input
│   └── gradient_background.dart     # Gradient background widget
├── app.dart                         # App configuration
└── main.dart                        # Entry point
```

## 🎨 Design System

### Color Palette

**Gradient Colors:**
```dart
gradientStart:  #1E3A8A  // Deep blue
gradientMiddle: #6366F1  // Indigo
gradientEnd:    #8B5CF6  // Purple
```

**Accent Colors:**
```dart
accent:         #7DD3FC  // Light sky blue
accentSecondary: #60A5FA // Sky blue
```

**Glass Effects:**
```dart
glassBackground: rgba(255, 255, 255, 0.15)
glassBorder:     rgba(255, 255, 255, 0.20)
```

### Typography
- **Primary Font:** Inter (via Google Fonts)
- **Font Sizes:** 11px - 72px
- **Font Weights:** 400 (normal) - 700 (bold)

## 🔧 Configuration

### Temperature Units
The app supports both Celsius and Fahrenheit. Users can toggle between units in the Settings screen.

### API Configuration
Weather data is fetched from a weather API. Configure your API endpoint in:
```
lib/features/home/repository/weather_repository.dart
```

## 🧪 Testing

Run tests with:
```bash
flutter test
```

Run widget tests:
```bash
flutter test test/widget_test.dart
```

## 📱 Building for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 🐛 Known Issues

- None currently reported

## 🗺️ Roadmap

- [ ] Weather alerts and notifications
- [ ] Hourly forecast
- [ ] Weather maps and radar
- [ ] Multiple language support
- [ ] Dark/Light theme toggle
- [ ] Weather widgets for home screen
- [ ] Share weather updates
- [ ] Location-based auto-detection

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Tirumala gali**
- Email: thirumalagali000@gmail.com

## 🙏 Acknowledgments

- Weather data provided by [Weather API Provider]
- Icons from Material Design Icons
- Illustrations from [Source]
- Inspired by modern glassmorphism design trends

## 📞 Support

For support, email thirumalagali000@gmail.com or open an issue on GitHub.

## 🌟 Show your support

Give a ⭐️ if this project helped you!

---

**Made with ❤️ using Flutter**

