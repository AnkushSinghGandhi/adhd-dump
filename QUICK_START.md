# DumpMate - Quick Start Guide

## 🚀 Get Running in 2 Minutes

### Step 1: Install Dependencies
```bash
cd /app
flutter pub get
```

### Step 2: Run the App
```bash
# iOS Simulator
flutter run -d ios

# Android Emulator  
flutter run -d android

# Or just
flutter run
```

That's it! The app will launch with pre-loaded mock data.

## 🎯 What You'll See

1. **Onboarding Screen** → Tap "Get Started"
2. **Home Feed** → 20 mock dumps loaded
3. **Bottom Nav** → Explore Cart, Reminders, Trash
4. **Floating + Button** → Create quick dump
5. **Tap any dump** → View details with suggestions

## 📱 Key Interactions to Try

### Home Screen
- **Search bar** → Type to filter dumps
- **Filter chips** → Tap Study, Watchlist, Shopping
- **New items banner** → Review recent dumps
- **Dump card** → Tap to view details
- **Pin icon** → Pin/unpin dumps
- **+ Button** → Open quick dump modal

### Dump Details
- **Hero animation** → Smooth image transition
- **Suggestions carousel** → Scroll horizontally
- **Add to Cart** → (Shopping items only)
- **Trash icon** → Move to trash

### Quick Dump Modal
- **Category chips** → Select category
- **Reminder presets** → Quick reminder setup
- **Save** → Creates mock dump (UI only)

### Trash
- **Countdown chip** → Days left (color-coded)
- **Restore** → Move back to main feed
- **Delete** → Permanent deletion (with confirmation)

### Cart
- **Product cards** → Tap to view dump
- **Remove** → Delete from cart

### Reminders
- **3 Tabs** → Upcoming / Missed / Done
- **Snooze** → Select duration (10/30/60 min)
- **Complete** → Mark as done

### Settings
- **Toggles** → Auto-scan, Local-only, Notifications
- **Reduced Motion** → Accessibility option
- **Clear Cache** → Storage management
- **Seed Data** → Reload mock data

## 🎨 Design Features

- **Color Scheme**: Light gray bg + black text + lime accents
- **Typography**: Clean hierarchy (34/24/20/16/13)
- **Animations**: Hero, scale, ripple effects
- **Accessibility**: 48dp touch targets, semantic labels

## 📊 Mock Data Overview

| Category | Count | Examples |
|----------|-------|----------|
| **Study** | 6 | Python, React, Docker, Git, CSS, SQL |
| **Anime** | 5 | Demon Slayer, One Piece, AOT, Frieren, JJK |
| **Shopping** | 5 | MacBook, iPhone, Headphones, Switch, AirPods |
| **Recipes** | 3 | Butter Chicken, Pasta, Thai Curry |
| **Misc** | 1 | Work reminder |

## 🔧 Customization

### Change Theme Colors
Edit `/app/lib/theme/app_theme.dart`:
```dart
static const Color accentLime = Color(0xFFA3E635); // Change this
```

### Add More Mock Data
Edit `/app/assets/fixtures/dumps.json`:
```json
{
  "id": "dump_021",
  "title": "Your Title",
  "category": "Study",
  ...
}
```

### Modify Screens
All screens in `/app/lib/screens/`:
- `home_screen.dart` - Main feed
- `dump_details_screen.dart` - Detail view
- etc.

## 📁 Project Structure Quick Reference

```
/app
├── lib/
│   ├── main.dart              ← Entry point
│   ├── theme/                 ← Design tokens
│   ├── models/                ← Data classes
│   ├── providers/             ← State management
│   ├── screens/               ← 8 main screens
│   ├── widgets/               ← Reusable components
│   ├── routes/                ← Navigation config
│   └── utils/                 ← Helpers
├── assets/
│   └── fixtures/              ← Mock JSON data
├── pubspec.yaml               ← Dependencies
└── README.md                  ← Full documentation
```

## ⚠️ Known Limitations (By Design)

This is a **UI-only implementation**:
- ✅ All screens functional with mock data
- ✅ State management works locally
- ❌ No backend API (all data is mocked)
- ❌ No real OCR processing
- ❌ No gallery access
- ❌ No push notifications

## 🐛 Troubleshooting

### "Packages not found"
```bash
flutter pub get
```

### "Font not found" warning
This is expected. See `FONTS_NOTE.md` or ignore (system font will be used).

### Simulator not starting
```bash
# iOS
open -a Simulator

# Android
emulator -avd <your_avd_name>
```

### Hot reload not working
```bash
# Press 'r' in terminal for hot reload
# Press 'R' for full restart
```

## 📚 Full Documentation

- **README.md** - Complete features & setup
- **DESIGN_SPEC.md** - Design system details
- **PROJECT_SUMMARY.md** - Implementation overview
- **FONTS_NOTE.md** - Font installation

## 💡 Pro Tips

1. **Use filters** - Quickly find Study/Anime/Shopping dumps
2. **Pin important items** - Keeps them at top
3. **Try animations** - Tap dumps to see Hero transition
4. **Test empty states** - Navigate to Trash when empty
5. **Explore modals** - Bottom sheets are interactive

## 🎯 Next Steps

1. ✅ Run the app and explore
2. ✅ Check out all 8 screens
3. ✅ Review the code structure
4. ✅ Customize colors/data if desired
5. 📖 Read full docs for deeper understanding

---

**Questions?** Check README.md or DESIGN_SPEC.md for detailed info.

**Ready to build?** All UI components are modular and ready for backend integration!

---

**Enjoy exploring DumpMate! 🎉**
