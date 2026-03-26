# Spürhund Dark Mode Redesign: Design Document

**Date:** 26/03/2026
**Status:** Approved
**Target:** Pitch Tool for City of Tshwane metro council demo

## 1. Design Direction

Premium dark mode fintech aesthetic. Calm command centre, not alarm system. The dominant emotion on open: "I know exactly where I stand." Urgency conveyed through colour coded status badges only, never through aggressive layout or typography.

**One-sentence pitch:** "Never be surprised by a municipal bill again."

**Primary persona:** Urban Gauteng resident (Tshwane/Joburg), digitally comfortable, managing one municipal account with multiple services from a sectional title unit.

## 2. Colour Palette (Dark Mode First)

| Role | Value |
|------|-------|
| Canvas/Background | #0A0A0A (Void Black) |
| Surface/Cards | #1A1A1A |
| Elevated Surface | #222222 |
| Text Primary | #FFFFFF |
| Text Secondary | #A1A1AA (Zinc 400) |
| Text Tertiary | #52525B (Zinc 600) |
| Dividers/Borders | #2A2A2A or white at 10% opacity |
| Input Background | #1A1A1A with white/10 border |
| Floating Nav | black/80 + backdrop blur + white/5 border |
| Glassmorphic Overlays | white/5 or white/10 + blur |
| Status Badge Backgrounds | status colour at 15% opacity |
| Primary Accent | #8529E2 (Spürhund Purple) |
| Deep Violet | #6B1FB8 |
| Soft Lavender | #B07AEF |
| Emerald (positive) | #10B981 |
| Amber (warning) | #F59E0B |
| Crimson (urgent) | #EF4444 |

## 3. User Flow

```
Splash → Onboarding (3 slides) → Sign Up → Link Account → Dashboard
                                                              ├─ Home (default)
                                                              ├─ Area (municipal calendar)
                                                              ├─ Disputes
                                                              ├─ Contacts
                                                              └─ Profile
                                                         + Notifications Inbox (via bell icon)
                                                         + Bill History (via section)
                                                         + Bill Detail (via tap)
                                                         + Dispute Detail (via tap)
```

**Route structure:**
- `/splash` → `/onboarding` → `/signup` → `/link-account` → `/home`
- Shell routes: `/home`, `/area`, `/disputes`, `/contacts`, `/profile`
- Detail routes: `/home/history`, `/home/bill/:id`, `/home/notifications`, `/disputes/:id`

## 4. Screen Specifications (14 total)

### 4.1 Splash
- Void black background
- Spürhund logo asset (if available) or purple wordmark
- Fade in + subtle scale (0.95 → 1.0) over 800ms
- Auto-navigate to onboarding after 2s

### 4.2 Onboarding Carousel (3 slides)
- Dark background throughout
- Top 60%: geometric illustration area with subtle purple gradient glow behind
- Bottom 40%: headline (white, 26px bold) + subtitle (zinc, 16px)
- Slide 1: "One place for everything." Dashboard consolidation concept
- Slide 2: "We'll remind you before it's too late." Notification/calendar concept
- Slide 3: "Know what's happening in your area." Location/alert concept
- Dot indicators: purple active pill (24px wide), white/20 inactive circles (8px)
- "Skip" top right on all slides (Zinc text)
- "Get Started" purple pill button on slide 3
- "Already have an account? Sign in" at bottom on all slides
- Illustrations: Custom geometric shapes built with Flutter CustomPainter or Icon compositions. Thin white line art with purple gradient glow behind. Must look complete, not like placeholders. Architecture supports Lottie drop-in replacement later.

### 4.3 Sign Up
- Dark background
- Shield/lock icon at top (white, 48px)
- "Get Started with Spürhund" headline (white)
- "Create your account in seconds." subtitle (Zinc)
- Email input (dark surface, white/10 border, white text)
- Password input with visibility toggle
- "Sign Up" purple pill button (full width)
- "Already have an account? Log In" link
- "Or" divider
- Two social auth buttons side by side:
  - Apple: dark surface (#1A1A1A), white Apple logo + "Apple" text
  - Google: dark surface (#1A1A1A), Google G logo + "Google" text
  - Both show "Coming soon" toast on tap in Pitch Tool
- Terms footer in dark zinc at bottom

### 4.4 Link Account
- Dark background
- Building icon at top (white, 48px)
- "Link Your Municipal Account" headline
- "Connect your account to see your bills and alerts." subtitle
- Municipality dropdown (City of Tshwane default, City of Johannesburg option)
- Account number input with "?" help icon (shows mock bill image on tap)
- Property type selector: horizontal chips (Flat, Townhouse, House, Commercial)
- "Connect Account" purple pill button
- Loading state: spinner in button → success checkmark → navigate to dashboard
- Press "Connect" loads mock data, no real validation

### 4.5 Dashboard
- Void black canvas
- Top bar: "SPÜRHUND" wordmark (purple, letter-spaced 3px) left; bell icon (notification count badge) + avatar circle right
- Time-aware greeting below: "Good morning, Lionel" / "Good afternoon, Lionel" / "Good evening, Lionel" in Zinc
- Hero balance card:
  - Purple gradient (#8529E2 → #6B1FB8), rounded 24px
  - "Total Amount Due" label (white/70)
  - "R 2,847.63" display (36px bold white, tabular numbers)
  - "Next due: 15 April 2026" + "12 days" countdown badge (white/20 background)
  - Subtle gradient shimmer animation on load
- Quick actions row: 4 circular icon buttons on dark surface
  - Pay (greyed out, shows "Coming soon" toast), History, Report, More
- "Your Accounts" section header
  - Service tiles: dark cards (#1A1A1A), white/5 border, 16px rounded
  - Each: colour-coded service icon, name, "Due X date", amount, status badge
  - Services: Water, Electricity, Rates & Taxes, Waste, Sanitation
- "Alerts" section header
  - Alert cards: dark surface with severity-coloured left border strip (4px)
  - Load shedding (amber), water maintenance (blue), rate increase (crimson)
- Floating dark glass nav bar at bottom

### 4.6 Notifications Inbox
- Accessible via bell icon on dashboard
- Dark canvas, "Notifications" app bar with back arrow
- List of notification cards (dark surface, white/5 border)
- Each: icon (colour coded by type), title (white), body preview (zinc), timestamp (dark zinc)
- Unread indicator: purple dot on left edge
- Mock notifications: new bill, payment due in 3 days, dispute update, load shedding alert, payment confirmed

### 4.7 Bill History
- Dark canvas, "Bill History" app bar
- Month filter chips (horizontal scroll, purple active)
- List of bill cards: service icon, month/year, amount, paid/unpaid badge
- Tap navigates to bill detail

### 4.8 Bill Detail
- Dark canvas
- Service type header with colour-coded icon
- Bill period, issue date, due date
- Line items: usage, tariff, VAT, total (dark surface card)
- Payment status badge
- "Download Statement" outlined button → "Available in the full version" toast
- "Dispute This Bill" link

### 4.9 Area / Service Status
- Dark canvas, "Your Area" header
- Location indicator: "Sunnyside, Tshwane"
- Municipal calendar: horizontal scrollable 14-day timeline
  - Date circles with event indicators (colour coded dots below)
  - Tap a day to see detail cards: due dates, maintenance, load shedding
  - Populated with realistic mock data
- Active alerts section: severity-coloured cards
- Service health indicators: Water (green check), Electricity (amber warning "Stage 2"), Waste (green check)

### 4.10 Disputes List
- Dark canvas, "Disputes" header
- Filter tabs: All, Open, Resolved
- Dispute cards: ID, service type, status badge (submitted/in progress/resolved), date filed
- Tap to open detail

### 4.11 Dispute Detail
- Dark canvas
- Status timeline (vertical): Submitted → In Progress → Under Review → Resolved
  - Completed steps: emerald, current step: purple pulse, pending: zinc
- Original bill reference
- Dispute reason text
- Municipality response section (mock)
- Status badge prominent at top

### 4.12 Contacts Directory
- Dark canvas, "Contacts" header
- Search input at top
- Category chips: Emergency, Billing, Technical, General
- Contact cards: department name, phone, email, operating hours
- Tap to call / tap to email (launches native dialler/mail)

### 4.13 Profile & Settings
- Dark canvas
- User avatar circle (initials "LM" in purple on dark surface)
- Name, email, phone displayed
- Linked account info: account number, municipality, property type
- Settings sections: Notifications, Appearance (dark mode only note), About, Sign Out
- "Spürhund Pitch Tool v1.0" footer

### 4.14 Floating Navigation Bar (shared component)
- Detached: 24px from bottom, 20px from sides
- Pill shape: border-radius 28px
- Background: black at 80% opacity + ClipRRect with BackdropFilter blur 20px
- Border: 1px white at 5% opacity
- Shadow: 0 8px 32px black/40
- 5 tabs, icon only, no labels
- Active: purple icon + small 4px purple dot below
- Inactive: white at 40% opacity
- Icons: Home (house), Area (compass), Disputes (chat bubble), Contacts (phone), Profile (person)

## 5. Animation Strategy

- Page transitions: horizontal shared axis for tab switches, vertical slide-up for detail screens
- List items: staggered fade-in, 50ms delay per item, translate-y 16px to 0
- Balance card: gradient shimmer sweep on load
- Button press: scale 0.97x with spring physics (exists)
- Onboarding: parallax effect on illustrations during swipe
- Status badges: gentle opacity pulse on overdue items (1s cycle, 0.7 to 1.0)
- Nav bar active icon: scale bounce 1.0 to 1.15 to 1.0
- Link account "Connect": button spinner → checkmark → navigate

## 6. Pitch Tool Constraints

- Social auth buttons: visual only, show "Coming soon" toast
- Pay button: greyed out, shows "Coming soon" toast
- Download Statement: shows "Available in the full version" toast
- Account linking: simulated, no real API, mock data loads on "Connect"
- All data is mock. Realistic Tshwane municipal data based on Mr Lionel's real bill.
- No Supabase integration in the Pitch Tool. That's Lite MVP (Tier 2).
