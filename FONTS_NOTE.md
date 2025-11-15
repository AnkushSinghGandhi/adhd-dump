# Font Installation Instructions

## Required Fonts

The DumpMate app uses the **Inter** font family. To complete the setup, you need to add the Inter font files.

### Download Inter Fonts

1. Visit: https://fonts.google.com/specimen/Inter
2. Download the font family
3. Extract the following font files:
   - `Inter-Regular.ttf`
   - `Inter-Medium.ttf` (weight 500)
   - `Inter-SemiBold.ttf` (weight 600)
   - `Inter-Bold.ttf` (weight 700)

### Installation

Place the downloaded `.ttf` files in the following directory:
```
/app/assets/fonts/
```

### Files to Add:
- `/app/assets/fonts/Inter-Regular.ttf`
- `/app/assets/fonts/Inter-Medium.ttf`
- `/app/assets/fonts/Inter-SemiBold.ttf`
- `/app/assets/fonts/Inter-Bold.ttf`

### Note

The font configuration is already set up in `pubspec.yaml`. Once you add the font files to the `assets/fonts/` directory, run:

```bash
flutter pub get
```

### Alternative: Use System Fonts

If you prefer to skip custom fonts for now, you can modify `/app/lib/theme/app_theme.dart`:

1. Open the file
2. Remove or comment out the `fontFamily: 'Inter'` line in the `ThemeData`
3. The app will fall back to the system default font

The app will work without custom fonts, but the design will look slightly different from the intended design system.
