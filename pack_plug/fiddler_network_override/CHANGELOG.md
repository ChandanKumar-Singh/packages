## 0.0.1

- Initial release of `fiddler` plugin — a Dart-only, developer-friendly utility to route Flutter HTTP traffic through a proxy (e.g., Fiddler, Charles).
- Key Features:
  - 🧠 Automatically sets `HttpOverrides.global` to route all Dart `HttpClient` requests via a configured proxy.
  - 📄 Supports external config file loading (`/storage/emulated/0/root/fiddler/config.json`) with fallback to SharedPreferences.
  - ⚙️ Built-in bottom sheet UI (`ProxyInputSheet`) for testers/developers to:
    - Enter and save proxy host & port.
    - Enable/disable proxy.
    - Save to `SharedPreferences` and soft restart the app.
  - 🧩 Cross-platform compatible (Android, iOS, macOS, Windows, Linux; excludes Web by default).
- Ideal for QA testing, debugging APIs, and inspecting network traffic during development.

