# DumpMate - ADHD-Friendly Dumps App

A Flutter mobile application for managing screenshots and thoughts with AI-powered suggestions, reminders, and smart organization.

## 🎨 Design System

### Color Tokens
- **Background**: `#F5F5F5` (light gray)
- **Primary Black**: `#0B0B0B` (headlines, CTAs)
- **Accent Lime**: `#A3E635` (brand color, selected states)
- **Card Background**: `#FFFFFF` (white)
- **Muted Text**: `#4A4A4A` (secondary text)

### Typography
- **Font Family**: Inter
- **Sizes**: H1 (34), H2 (24), H3 (20), Body (16), Small (13)
- **Radius**: Cards (16px), Buttons (10px), Pills (8px)

## 🚀 Features

### Core Screens
1. **Home Screen** - Main feed with search, filters, and quick dump button
2. **Dump Details** - Full view with OCR text, suggestions carousel, and actions
3. **Quick Dump Modal** - Fast capture with category and reminder presets
4. **Trash** - 60-day countdown with restore/delete permanently
5. **Cart** - Shopping items with price comparison
6. **Reminders** - Tabbed view (Upcoming/Missed/Done) with snooze
7. **Settings** - App configuration and preferences
8. **Onboarding** - Welcome flow with permissions

### UI Components
- `DumpCard` - List & compact variants
- `SuggestionCard` - Anime, Shopping, Study variants
- `RoundedPill` - Tag/chip component
- `PrimaryButton` / `SecondaryButton`
- `FloatingDumpButton` - Animated FAB
- `CountdownChip` - Trash countdown display

## 📦 Dependencies

```yaml
flutter_riverpod: ^2.4.9      # State management
go_router: ^13.0.0             # Navigation
flutter_svg: ^2.0.9            # SVG support
cached_network_image: ^3.3.0   # Image caching
animations: ^2.0.11            # Transitions
intl: ^0.19.0                  # Date formatting
```

## 🗂️ Project Structure

```
lib/
├── main.dart                  # App entry point
├── theme/
│   └── app_theme.dart        # Design tokens & theme
├── models/
│   ├── dump.dart
│   ├── reminder.dart
│   ├── cart_item.dart
│   └── suggestion.dart
├── providers/
│   ├── dump_provider.dart
│   ├── reminder_provider.dart
│   ├── cart_provider.dart
│   ├── suggestion_provider.dart
│   └── app_state_provider.dart
├── screens/
│   ├── onboarding_screen.dart
│   ├── home_screen.dart
│   ├── dump_details_screen.dart
│   ├── trash_screen.dart
│   ├── cart_screen.dart
│   ├── reminders_screen.dart
│   └── settings_screen.dart
├── widgets/
│   ├── dump_card.dart
│   ├── suggestion_card.dart
│   ├── rounded_pill.dart
│   ├── primary_button.dart
│   ├── floating_dump_button.dart
│   └── countdown_chip.dart
├── routes/
│   └── app_router.dart
└── utils/
    └── data_loader.dart

assets/
├── fixtures/
│   ├── dumps.json             # 20 diverse mock dumps
│   ├── suggestions.json       # Anime, shopping, study suggestions
│   ├── reminders.json         # Sample reminders
│   └── cart_items.json        # Sample cart items
├── images/                    # App images
├── icons/                     # App icons
└── fonts/                     # Inter font family
```

## 📊 Mock Data

The app includes realistic mock data:
- **20 Dumps**: Study (Python, React, Docker, Git, CSS, SQL), Anime (Demon Slayer, One Piece, Attack on Titan, Frieren, JJK), Shopping (MacBook, iPhone, Sony headphones, Nintendo Switch, AirPods), Recipes (Butter Chicken, Pasta, Thai Curry), Work reminders
- **Suggestions**: Provider-specific (ANIME, SHOP, STUDY)
- **6 Reminders**: Various priorities and recurrence patterns
- **5 Cart Items**: Electronics and audio products

## 🎯 Getting Started

### Prerequisites
- Flutter SDK (stable channel)
- iOS/Android development environment

### Installation

```bash
# Get dependencies
flutter pub get

# Run on iOS simulator
flutter run -d ios

# Run on Android emulator
flutter run -d android

# Build release
flutter build apk  # Android
flutter build ios  # iOS
```

### Seed Data Toggle

The app automatically loads mock data from JSON fixtures. To reset:
1. Go to **Settings**
2. Tap **Seed Sample Data** under Developer section

## ♿ Accessibility

- All interactive elements have **48x48 dp** minimum touch targets
- Semantic labels for screen readers on all buttons and cards
- High contrast text (WCAG AA compliant)
- Supports dynamic font scaling
- Reduced motion option in Settings

## 🎬 Animations

- **Hero transitions**: Thumbnail → Full image in Dump Details
- **Scale animation**: Floating Dump Button press
- **Shared axis**: Tab transitions
- **Ripple effects**: Card taps

All animations respect reduced-motion preference.

## 🧪 Testing

```bash
# Run unit tests
flutter test

# Run widget tests
flutter test test/widgets/

# Run with coverage
flutter test --coverage
```

## 📱 Platform Support

- ✅ Android (API 21+)
- ✅ iOS (13.0+)
- ⏳ Web (not optimized)
- ⏳ Desktop (not optimized)

## 🔮 Future Enhancements (Not Implemented)

- Backend integration for OCR processing
- Real provider APIs (anime databases, shopping aggregators)
- Cloud sync functionality
- Push notifications for reminders
- Image editing tools
- Bulk operations (select multiple dumps)
- Export/import functionality
- Dark theme

## 📄 License

This is a UI-only prototype for demonstration purposes.

## 🙏 Credits

- **Design Tokens**: Inspired by Finns prompt aesthetic
- **Mock Images**: Unsplash
- **Icons**: Material Design Icons

---

**Note**: This is a **UI-only implementation**. Backend services, OCR processing, and third-party API integrations are mocked with local data.
