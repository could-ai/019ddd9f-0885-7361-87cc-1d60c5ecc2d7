# Animeverse

Animeverse is a modern, cross-platform Flutter application that lets users discover, search, and track their favorite anime using real-time data from the Jikan API (MyAnimeList). 

## 🌟 Features

- **Trending Anime:** View the top trending anime right from the home screen.
- **Search:** Search the entire MyAnimeList database to find specific anime.
- **Detailed Information:** View comprehensive details including synopsis, genres, rating, episodes, release dates, and status.
- **Favorites System:** Save your favorite anime directly to your device for easy access later. Favorites are stored locally.
- **Bilingual Support:** Fully localized in English and Arabic, featuring RTL (Right-to-Left) layout support.
- **Modern UI:** Built with Material 3 design, featuring a smooth, responsive grid layout and dark theme out of the box.

## 🛠️ Tech Stack

- **Framework:** [Flutter](https://flutter.dev/) (Dart)
- **State Management:** `provider`
- **Networking:** `http` (interacting with [Jikan API](https://jikan.moe/))
- **Local Storage:** `shared_preferences`
- **Image Caching:** `cached_network_image`
- **Localization:** `flutter_localizations` & `intl`

## 🚀 Setup & Run Instructions

1. **Ensure Flutter is installed** and your environment is configured (iOS Simulator, Android Emulator, Web, or Desktop).
2. **Clone the repository.**
3. **Install dependencies:**
   ```bash
   flutter pub get
   ```
4. **Run code generation (for localization):**
   ```bash
   flutter gen-l10n
   ```
5. **Run the app:**
   ```bash
   flutter run
   ```

## 📱 User Flows

1. **Home Screen:** Start at the Trending tab to see popular anime.
2. **Details & Favorites:** Tap any anime card to read more. Tap the heart icon in the detailed view to add the anime to your Favorites.
3. **Search:** Use the Search tab from the bottom navigation bar to look up specific shows.
4. **Favorites:** Access your saved list anytime in the Favorites tab.
5. **Settings:** Switch between English and Arabic easily using the Settings tab.

---

## About CouldAI

This app was generated with [CouldAI](https://could.ai), an AI app builder for cross-platform apps that turns prompts into real native iOS, Android, Web, and Desktop apps with autonomous AI agents that architect, build, test, deploy, and iterate production-ready applications.
