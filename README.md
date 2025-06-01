# 🚀 Flutter Base Template Project

A scalable, modular Flutter starter project optimized for real-world applications. This template includes:

- ✅ Flavor-based architecture (test, staging, prod)
- ✅ Auto-managed dependencies and changelog
- ✅ Latest stable Android SDK (AGP, Kotlin, Firebase, etc.)
- ✅ Modular code structure for maintainability
- ✅ GitHub-ready and CI/CD-friendly

---

## 🧩 Project Structure

lib/
├── core/ # Utilities, services, constants, models
├── views/ # Feature-based modules
│ └── feature_name/
│ ├── cubit/
│ ├── widgets/
│ └── view.dart
├── main.dart # Flavor entry points

yaml
Copy
Edit

---

## 🛠 Flavors Configuration

Three environments are supported:

- `test`
- `staging`
- `prod`

### Android setup

Your `build.gradle` is configured with:

```groovy
productFlavors {
  test {
    applicationId "com.example.app.test"
    ...
  }
  staging {
    applicationId "com.example.app.staging"
    ...
  }
  prod {
    applicationId "com.example.app"
    ...
  }
}
Run Commands
bash
Copy
Edit
flutter run --flavor test    -t lib/main_test.dart
flutter run --flavor staging -t lib/main_staging.dart
flutter run --flavor prod    -t lib/main_prod.dart
📦 Tooling
🔄 Update Dependencies Automatically
bash
Copy
Edit
dart tools/update_dependencies.dart
Updates all direct and used packages to latest

Suggests unused packages

Generates changelog_dependency_updates.md

⚙️ Update Android SDK Versions
bash
Copy
Edit
dart tools/update_android_versions.dart
Fetches latest AGP, Kotlin, Google Services, Crashlytics, and NDK

Updates:

build.gradle

gradle-wrapper.properties

settings.gradle

ndkVersion in build.gradle

🚧 Development Notes
Generate Icons
bash
Copy
Edit
flutter pub run flutter_launcher_icons
Localization
bash
Copy
Edit
flutter pub run easy_localization:generate -S assets/langs -O lib/core/langs
📋 Requirements
Flutter 3.x

Dart 3.x

Android Studio (w/ NDK support)

Java 17+

📄 License
MIT

🙋 Support
If this template helps you, please ⭐️ the repo and consider contributing!

yaml
Copy
Edit

---

Let me know if you'd like to:
- Add CI/CD instructions (like GitHub Actions)
- Include environment variable handling (`.env`)
- Auto-generate docs or API integrations

I can tailor it to your stack or repo goals.
```
