# Design System: Spürhund
**Project ID:** projects/3161321691366009612

## 1. Visual Theme and Atmosphere
Premium editorial mobile design with depth, texture, and spatial confidence. Inspired by luxury fintech and premium consumer apps. The aesthetic blends "Soft Structuralism" with "Editorial Luxury": a near white canvas with generous breathing room, punctuated by a singular bold purple accent. Cards are substantial, layered objects with frosted glass overlays and deep soft shadows. Navigation floats above the content as a detached glass island. Typography is large, tight tracked, and confident. The feel is: a R150,000 agency build, not a developer template. Think Apple Wallet crossed with the Airbnb booking experience.

## 2. Color Palette and Roles
- **Spürhund Purple** (#8529E2) for primary interactive elements: CTAs, active states, accent gradients, hero card overlays
- **Deep Violet** (#6B1FB8) for pressed states, gradient endpoints, dark purple backgrounds on hero elements
- **Soft Lavender** (#B07AEF) for inactive navigation icons, secondary accents
- **Whisper Purple** (#F3ECFD) for selected chip fills, notification badge fills, subtle card tints
- **Canvas** (#FAFAFA) for the page background (not pure white; slightly warm for editorial feel)
- **Pure White** (#FFFFFF) for card surfaces, floating nav, overlays
- **Cloud Grey** (#F5F5F7) for input backgrounds, section dividers, grouped list backgrounds
- **Near Black** (#111111) for headlines and primary text (deeper than standard dark grey for editorial contrast)
- **Slate** (#6B7280) for secondary text, labels, timestamps
- **Ash** (#9CA3AF) for placeholders, disabled states, inactive elements
- **Emerald** (#10B981) for positive states: paid, resolved
- **Amber** (#F59E0B) for warning states: due soon, maintenance
- **Crimson** (#EF4444) for urgent states: overdue, outages
- **Fog** (#E5E7EB) for dividers, hairlines

## 3. Typography Rules
System native fonts (San Francisco on iOS, Google Sans/Roboto on Android). Headlines are large, bold weight, tight tracked (tracking tight equivalent). Hero numbers (balance totals) are displayed at 32pt+ bold with tabular number spacing. Section headers at 20pt semibold. Body text at 15pt regular with relaxed leading. Captions at 12pt medium in Slate. All financial figures use medium or semibold weight.

## 4. Component Stylings

* **Navigation Bar (FLOATING ISLAND):** The bottom nav is NOT flush with the screen edge. It floats as a detached, pill shaped glass island (rounded 2.5rem), positioned 24px from the bottom and 24px from each side, with heavy backdrop blur (backdrop-blur-xl), a subtle white/95 background, and a deep diffused shadow (0 10px 30px rgba(0,0,0,0.12)). Active tab icon has a subtle circular tinted background (Whisper Purple) with an active dot indicator below it. Inactive icons in Ash grey. This is the signature element; it must feel like a physical floating glass object.

* **Hero Cards (GLASSMORPHIC OVERLAY):** Large, full width cards with 2rem+ rounded corners, tall aspect ratio (380px minimum height), featuring a background image or gradient. Info content sits in a frosted glass overlay panel at the bottom of the card (backdrop-blur-lg, white/90 background, 1.5rem inner radius, 1px white/10 hairline border, soft inner shadow for edge refraction). The overlay contains the title, subtitle, and detail chips. Inspired by the real estate card in the reference.

* **Account Cards (DOUBLE BEZEL):** Nested card architecture. Outer shell has a subtle background (Cloud Grey or Whisper Purple at 50%), thin outer hairline (ring-1 ring-black/5), padding of 6px, and 2rem radius. Inner core has white background, its own inner shadow highlight (inset 0 1px 1px rgba(255,255,255,0.15)), and a calculated smaller radius (calc(2rem minus 6px)). This creates a machined, physical feel like a glass plate in an aluminium tray.

* **Buttons (PILL ISLAND):** Fully rounded pill shape (rounded-full). Primary: solid Spürhund Purple fill with white text, generous padding (px-6 py-3.5). If button has a trailing arrow icon, the arrow sits inside its own distinct circular wrapper (w-8 h-8 rounded-full bg-white/20) flush with the button's inner padding. On press: scale to 0.97x with spring physics. Secondary: ghost style with 1px purple border.

* **Category Chips:** Pill shaped (rounded-full), active chip has Near Black fill with white text and a subtle shadow (shadow-md shadow-black/10). Inactive chips have white fill, 1px Fog border, Slate text. Horizontal scroll with no visible scrollbar.

* **List Item Cards:** Rounded 1.5rem, white background, 1px Fog border, subtle shadow on hover (shadow-md transition). Contains a square thumbnail (rounded-2xl, 96px) on the left, content on the right with title, subtitle, and detail icons. Inspired by the "Best for you" list in the reference.

* **Status Badges:** Pill shaped, tinted background at 10% opacity of status colour, status colour text, small and compact.

* **Inputs:** Cloud Grey fill (#F5F5F7), no visible border at rest, 2px purple ring on focus. Rounded 12px. Search inputs have icon inside on the left. Filter button is a square icon button (rounded-xl) with dark fill and white icon, subtle shadow.

* **Section Headers:** "Near You" style: title on the left (20pt semibold, Near Black), "See all" link on the right (14pt, Ash, hover to Near Black).

## 5. Layout Principles
8px grid. Generous vertical section spacing (32px between major sections). Horizontal padding: 24px (slightly wider than standard 16px for editorial breathing room). Cards use full width minus horizontal margins. The floating nav bar creates a 96px bottom safe zone (72px nav height + 24px offset). Pull to refresh on data screens. Content scrolls behind the floating nav (no clip). Staggered fade in on list items (50ms delay per item, translate-y-16 to translate-y-0 with opacity).

## 6. Design System Notes for Stitch Generation
Platform: Mobile, Mobile-first
Theme: Light, editorial, premium, Apple-inspired with glassmorphic depth
Background: Warm Canvas (#FAFAFA)
Surface: Pure White (#FFFFFF) for cards and floating elements
Primary Accent: Spürhund Purple (#8529E2) for interactive elements and hero gradients
Text Primary: Near Black (#111111) for headlines with tight tracking
Text Secondary: Slate (#6B7280) for labels and captions
Navigation: Floating glass island nav bar, detached from bottom edge, backdrop-blur, heavy shadow
Cards: Double bezel nested architecture, 2rem+ radius, frosted glass overlays on hero cards
Buttons: Pill shaped, fully rounded, generous padding, trailing icon in own circular wrapper
Category Filters: Horizontal scrolling pill chips, active=dark fill, inactive=white with border
Shadows: Deep, diffused, warm tinted (never harsh grey drop shadows)
Spacing: 24px horizontal margins, 32px between sections, generous whitespace
