# Spürhund Web App

Spürhund is a modernized municipal billing and dispute resolution platform specifically designed for the residents of Tshwane. This Flutter project brings the high-fidelity UI designs from Stitch into a functioning web application deployed on Vercel.

## Features

*   **13 Distinct Screens:** Fully developed UI covering Splash, Onboarding, Authentication, Dashboard, Bills, Status, Disputes, Contacts, and Profile.
*   **Design System Implementation:** A unified Material 3 `app_theme.dart` and `colours.dart` matching the brand guidelines.
*   **Custom Shared Widgets:** Reusable GlassMorphism cards, custom app inputs, branded pills and buttons, and a floating Navigation bar.
*   **Mock State Management:** `Provider` based implementation simulating data layers for Accounts, Bills, Disputes, Contacts, making the prototype interactive.
*   **Web Deployment & PWA:** Fully configured for Flutter Web and deployed via Vercel with customized manifests and icons.

## Getting Started

To run the application locally:

1.  Ensure you have [Flutter](https://docs.flutter.dev/get-started/install/macos) installed.
2.  Clone the repository and run `flutter pub get`.
3.  Copy `.env.example` to `.env` if you decide to hook up Supabase in the future.
4.  Run the application on Chrome: `flutter run -d chrome`.

### Production Build

```bash
flutter build web --release
```

## Live Demo

The current master build of the web application is live at [https://spurhundapp.vercel.app](https://spurhundapp.vercel.app).
