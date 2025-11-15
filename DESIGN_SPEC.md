# DumpMate Design Specification

## 🎨 Design System

### Color Palette

| Token | Hex Code | Usage |
|-------|----------|-------|
| Background | `#F5F5F5` | App canvas, screen backgrounds |
| Primary Black | `#0B0B0B` | Headlines, CTAs, primary actions |
| Accent Lime | `#A3E635` | Brand color, selected states, highlights |
| Card Background | `#FFFFFF` | Card surfaces, modals |
| Muted Text | `#4A4A4A` | Secondary text, labels |
| Subtle Border | `rgba(10,10,10,0.04)` | Card shadows, dividers |

### Typography Scale

| Name | Size | Weight | Line Height | Usage |
|------|------|--------|-------------|-------|
| H1 | 34px | Bold (700) | 1.2 | Page titles |
| H2 | 24px | Bold (700) | 1.3 | Section headers |
| H3 | 20px | SemiBold (600) | 1.4 | Subsection headers |
| Body | 16px | Regular (400) | 1.5 | Body text, descriptions |
| Small | 13px | Medium (500) | 1.4 | Labels, captions |

**Font Family**: Inter (fallback to system default)

### Border Radius

| Component | Radius |
|-----------|--------|
| Cards | 16px |
| Buttons | 10px |
| Pills/Chips | 8px |

### Spacing Scale

| Token | Value | Usage |
|-------|-------|-------|
| XS | 4px | Tight spacing |
| SM | 8px | Small gaps |
| MD | 16px | Standard spacing |
| LG | 24px | Large gaps |
| XL | 32px | Extra large spacing |

## 📱 Components

### DumpCard

**Variants**: Standard, Compact

**Structure**:
- Left: Thumbnail (80x80 or 60x60)
- Right: Content
  - Title (2 lines max)
  - OCR snippet (2 lines max, compact mode hides)
  - Category pill (lime accent)
  - Additional tags (up to 2 visible)
  - Provider badges (bottom row)
- Top-right: Quick actions (pin, reminder icons)

**States**:
- Default
- Pressed (elevation lift)
- Pinned (lime pin icon)

### SuggestionCard

**Variants**: Anime, Shopping, Study

**Common Structure**:
- Width: 200-220px
- Top: Image/poster (120px height)
- Body: Title, metadata, rating/price
- Bottom: CTA button

**Anime Variant**:
- Rating badge (star + number)
- Status chip (Airing/Completed)
- "Add to Watchlist" CTA

**Shopping Variant**:
- Best price badge (lime background)
- Merchant count
- "Compare Prices" CTA

**Study Variant**:
- Resource type pill (Article/Video/Tutorial)
- Duration indicator
- "View Resource" CTA

### Buttons

**Primary Button**:
- Background: Primary Black (`#0B0B0B`)
- Text: White
- Height: 52px
- Border radius: 10px
- Full width or intrinsic

**Secondary Button**:
- Background: Transparent
- Border: 1.5px Primary Black
- Text: Primary Black
- Height: 52px

**States**:
- Default
- Hover (slight darkening)
- Pressed (scale 0.98)
- Disabled (gray background)
- Loading (spinner)

### Floating Dump Button

- Size: 64x64px
- Background: Primary Black
- Icon: White plus sign (28px)
- Position: Bottom center, 16px from bottom
- Shadow: 0px 4px 12px rgba(0,0,0,0.15)
- Animation: Scale to 0.92 on press

### Pills/Chips

**Structure**:
- Horizontal padding: 10px
- Vertical padding: 5px
- Border radius: 8px
- Optional icon (left side)

**Variants**:
- Default: Card background, primary text
- Category: Lime background (20% opacity), primary text
- Selected: Lime outline (2px), lime background (20% opacity)

### CountdownChip

**Structure**:
- Clock icon (14px)
- Days left text
- Border: 1px with color matching urgency

**Color Logic**:
- ≤7 days: Red
- ≤14 days: Orange
- >14 days: Muted gray

## 🎭 Screens Layout

### Home Screen

**Header**:
- Logo (left): Lime circle with 'D'
- Title: "DumpMate" (center-left)
- Settings icon (right)

**Search Bar**:
- Full width, 52px height
- Search icon (left), mic icon (right)
- Placeholder: "Search dumps, tags, text…"

**Filter Chips**:
- Horizontal scroll
- Chips: All, New, Study, Watchlist, Shopping, Misc
- Selected state: Lime outline + bold text

**New Items Banner** (conditional):
- Lime border + light lime background
- Text: "X new items — Review"
- Right arrow icon

**Main Feed**:
- Vertical scroll
- 12px gap between cards
- Empty state: Inbox icon + message

**Bottom Nav**:
- 4 items: Home, Cart, Reminders, Trash
- Selected color: Lime
- Unselected: Muted gray

### Dump Details Screen

**Layout**:
1. Hero image (300px height, full width)
2. Content area (scrollable):
   - Title (H2)
   - Tags (category + subcategory + custom tags)
   - Extracted Text section
     - Toggle: Show/Hide bounding boxes
     - Text in monospace, gray background
   - Suggestions carousel (horizontal scroll, 280px height)
   - Reminders widget
3. Bottom action bar:
   - Add to Cart button (if shopping)
   - Pin icon
   - Trash icon

### Quick Dump Modal

**Bottom Sheet**:
- Rounded top corners (16px)
- Handle bar (top center)
- Image preview placeholder (80px height)
- Text input (3 lines)
- Category chips (Study, Watchlist, Shopping, Misc)
- Reminder presets (30m, Tonight 9 PM, Tomorrow 9 AM, Custom)
- Actions: Discard (outlined), Save Dump (primary)

### Trash Screen

**Structure**:
- AppBar with back button
- List of trashed items
- Each item:
  - Title + countdown chip (right)
  - Snippet (2 lines)
  - Actions: Restore (lime), Delete (red)
- Empty state: Trash icon + message

### Cart Screen

**Structure**:
- List of cart items
- Each item:
  - Thumbnail (80x80)
  - Product name, price pill, merchant
  - Added date
  - Open icon, Remove icon
- Empty state: Cart icon + message

### Reminders Screen

**Tabs**: Upcoming, Missed, Done

**Upcoming Tab**:
- List of reminder cards
- Each card:
  - Priority indicator (left colored bar)
  - Title + time
  - Priority badge
  - Recurrence indicator (if applicable)
  - Actions: Snooze, Complete

**Missed/Done Tabs**:
- Simpler list view
- Title + time
- Done items: Strikethrough text, green check icon

### Settings Screen

**Sections**:
1. General (Auto-scan, Local-only, Notifications)
2. OCR Settings (Languages)
3. Appearance (Theme, Reduced Motion)
4. Storage (Clear Cache)
5. Developer (Seed Data, Reset App)
6. About (Version, Privacy, Terms)

Each section uses `Card` with `ListTile` or `SwitchListTile`.

### Onboarding Screen

**Layout**:
- Logo (centered, 80x80)
- Title + subtitle
- Feature list (4 items, icon + text)
- Options card (2 switches)
- Primary CTA: "Get Started"
- Secondary: "Skip"

## 🎬 Animations & Transitions

### Micro-interactions

| Element | Animation | Duration | Curve |
|---------|-----------|----------|-------|
| Dump Card tap | Elevation lift | 150ms | easeOut |
| Floating button press | Scale 1.0 → 0.92 | 150ms | easeInOut |
| Chip selection | Background fade | 200ms | easeOut |

### Page Transitions

- **Shared Axis**: Between main tabs
- **Hero**: Dump thumbnail → Details full image
- **Slide Up**: Modal bottom sheets
- **Fade**: Settings changes, toggles

### Loading States

- **Skeleton**: Card content (shimmer effect)
- **Spinner**: Button loading (white, 20px)
- **Placeholder**: Image loading (gray background)

### Reduced Motion

When enabled:
- Disable Hero transitions
- Disable floating button scale
- Use instant transitions instead of animations

## ♿ Accessibility Guidelines

### Touch Targets

- Minimum: 48x48 dp
- All buttons, chips, list items meet this requirement
- Icon buttons: 48x48 with centered icon

### Semantic Labels

Required for:
- All buttons (e.g., "Create new dump")
- Cards ("Dump card: {title}")
- Icons (tooltip equivalents)
- Text fields (clear placeholders)

### Color Contrast

- Primary text on background: 14.8:1 (AAA)
- Muted text on background: 4.5:1 (AA)
- White text on Primary Black: 18.3:1 (AAA)

### Font Scaling

- Support system font scaling up to 200%
- Text reflows without truncation
- Minimum 16px for body text at 100% scale

## 📐 Responsive Breakpoints

| Device | Width | Adjustments |
|--------|-------|-------------|
| Narrow phone | <360px | Compact card layout, reduce padding |
| Standard phone | 360-414px | Default layout |
| Large phone | 414-600px | Increase card content width |
| Tablet | >600px | Multi-column layout (future) |

Current implementation optimized for 360-414px phones.

## 🖼️ Asset Guidelines

### Images

- Format: JPEG/PNG for photos, SVG for icons
- Thumbnail size: 80x80 or 60x60 (compact)
- Full image: Max 1920px width
- Use `cached_network_image` with placeholders

### Icons

- Source: Material Design Icons
- Size: 18px (small), 20-24px (standard), 28px (large)
- Color: Primary Black or Muted Gray
- Accent icons: Lime

### Empty States

- Icon: 80x80, muted gray
- Text: H3 + Body
- Optional CTA button below

## 🧩 Component Hierarchy

```
App
├── MaterialApp.router
│   ├── ThemeData (DumpMateTheme)
│   └── GoRouter
│       ├── OnboardingScreen
│       └── HomeScreen
│           ├── AppBar
│           ├── SearchBar
│           ├── FilterChips
│           ├── Feed (ListView)
│           │   └── DumpCard (repeated)
│           ├── FloatingDumpButton
│           └── BottomNavigationBar
```

## 🎯 Design Principles

1. **Minimal Friction**: 1-2 taps to add a dump
2. **Forgiving**: Easy undo, 60-day trash
3. **Clear Hierarchy**: Visual weight guides attention
4. **Consistent**: Reuse patterns across screens
5. **Fast**: Instant feedback, optimistic updates
6. **Accessible**: WCAG AA minimum, semantic HTML
7. **Responsive**: Adapts to different screen sizes

---

This specification serves as the source of truth for implementing and maintaining the DumpMate UI. All components should adhere to these guidelines for visual and behavioral consistency.
