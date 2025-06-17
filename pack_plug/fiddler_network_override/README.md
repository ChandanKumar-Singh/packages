# 🕵️‍♂️ fiddler network override

[![Pub Version](https://img.shields.io/pub/v/fiddler.svg)](https://pub.dev/packages/fiddler)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Platform Support](https://img.shields.io/badge/platform-android%20%7C%20ios%20%7C%20desktop%20-lightgrey.svg)]()

A Flutter plugin to **intercept and route all HTTP traffic through a custom proxy** like [Fiddler Everywhere](https://www.telerik.com/fiddler-everywhere), Charles Proxy, or Burp Suite for easy debugging and QA testing.

---

## ✨ Features

- Globally override Dart `HttpClient` to route HTTP(S) traffic through a proxy.
- Load proxy configuration from:
  - External JSON config file (optional)
  - SharedPreferences with a built-in UI for manual input
- Simple bottom sheet UI to configure proxy:
  - Host & Port inputs with validation
  - Enable/disable toggle
  - Save & soft restart app to apply changes
- Cross-platform support (Android, iOS, macOS, Windows, Linux)
- No recompilation needed to change proxy after initial setup

---

## 🚀 Why Use fiddler?

- Debug API calls by routing traffic through intercepting proxies
- Quickly enable/disable proxy on devices without rebuilds
- Useful for QA teams to test apps with various proxies
- Inspect, modify, and replay network requests easily

---

## 📦 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  fiddler_network_override: ^0.0.1
```


## 🎯 Usage

To show the proxy configuration UI anywhere in your app:

```dart
showProxyInputSheet(context);
```

This sheet lets testers input the proxy host and port, toggle enable/disable, and save.

---

## 🗂 Proxy Configuration Sources

### 1️⃣ External JSON File (Optional)

Path: `/storage/emulated/0/root/fiddler/config.json`

Example JSON format:

```json
{
  "proxy": "192.168.1.9:8866"
}
```

> ⚠️ Requires external storage read permission on Android.

---

### 2️⃣ SharedPreferences (Recommended)

Proxy details stored under keys:

* `fiddler_proxy` = `host:port`
* `fiddler_enabled` = `true` or `false`

Managed via the Proxy Input Sheet UI.

---

## 🔧 How It Works

* On app start, `enableFiddlerIfConfigured()` checks if proxy is enabled.
* If yes, fetches proxy from shared prefs or external file.
* Sets `HttpOverrides.global` to custom `FiddlerNetworkOverride`.
* All Dart HTTP clients route through the proxy.

---

## 📱 Proxy Input Sheet Features

* Validates host (IP or domain) and port inputs
* Enable/disable proxy toggle switch
* Save & Restart button to apply new settings
* Works on Android and iOS with consistent design

---

## 🔒 Permissions

* **External JSON config file:**

  * Requires `READ_EXTERNAL_STORAGE` permission on Android.
  * Not recommended for production apps.
* **SharedPreferences config:**

  * No extra permissions required.

---

## 🖥 Platform Support

| Platform | Status | Notes                       |
| -------- | ------ | --------------------------- |
| Android  | ✅      | Fully supported             |
| iOS      | ✅      | Fully supported             |
| macOS    | ✅      | Dart HttpClient only        |
| Windows  | ✅      | Dart HttpClient only        |
| Linux    | ✅      | Dart HttpClient only        |
| Web      | ❌      | HttpOverrides not supported |

---

## ⚠️ Limitations & Notes

* Only affects **Dart HttpClient**-based HTTP requests.
* Popular libraries like `dio` or `http` must be configured to use Dart HttpClient internally.
* Does not affect Web platform due to Flutter Web limitations.
* Proxy must be a valid and reachable address, or requests may fail.
* App restart required to fully apply new proxy settings.

---

## 🛡 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

## 💡 Future Enhancements

* Soft restart without app exit
* Support for proxy authentication
* Certificate pinning and trust management
* UI improvements and dark mode support

---

## 🤝 Contributing

Contributions are welcome! Feel free to open issues or pull requests.

To run example app:

```bash
cd example
flutter run
```

---

## 👤 Author

Chandan Kumar Singh – [GitHub](https://github.com/ChandanKumar-Singh) | [Email](mailto:thetdsdev@gmail.com)

---

Thank you for using **fiddler_network_override**! If you find this plugin useful, please ⭐️ star the repo and share with your peers.

```
