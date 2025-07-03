
# iOS VIPER Base Project

## 🚀 Project Purpose

This project provides a **VIPER architecture-based**, modular, testable, and scalable starter infrastructure for modern iOS applications.  
It is designed for maintainability, readability, and easy management in large-scale projects.

> **Minimum Requirement:**  
> This project is developed for **iOS 15.0 and above**.  
> It leverages modern Swift concurrency features (`async/await`, `@MainActor`, `Task`, etc.) and is fully compatible with **Swift 6+** and **Xcode 16.4+**.

---

## 📦 About the Project

- Built on a **base VIPER architecture**.
- Each module (e.g., Auth, Onboarding, Home) has its own independent VIPER layers:  
  `View`, `Interactor`, `Presenter`, `Entity`, `Router`.
- Comes with an embedded **Auth module** that includes essential flows:
  - Login
  - Signup
  - Password Reset

### 🔐 Flexible Auth Integration

- ✅ Firebase Ready:
  - Firebase Authentication, Analytics, etc. can be integrated out-of-the-box.
- 🛠️ Custom Backend:
  - Easily integrate your own backend authentication logic.
  - Thanks to **protocol-oriented** and **modular** VIPER structure, only the Interactor and Service layers need to be updated.

> ⚠️ **IMPORTANT:**  
> To switch the authentication provider (e.g., from Firebase to custom backend),  
> update the relevant configuration in `AppDelegate.swift`.  
> (See the **authentication setup section** in the file.)

### 🧱 Architecture Advantages

- **Modularity:** Each module can be developed, tested, and reused independently.
- **Easy Customization:** Themes, localization, analytics services, and helper components are easily pluggable.

---

## ⭐️ Key Features

- **Environment Configuration**  
  - Supports multiple environments (`development`, `staging`, `production`) via `AppEnvironment`.
  - Automatically selects base URL and environment-specific settings.

- **Secure Session & Token Management**  
  - Managed via `SessionManager`, securely stores tokens in **Keychain**.

- **Centralized Validation**  
  - `ValidationManager` protocol handles all form/auth validations.

- **Localization**  
  - Multi-language support out-of-the-box.
  - Easily add new languages by updating `.strings` files.

- **Custom UI Components**  
  - Reusable & themeable: `CustomButton`, `CustomTextField`, etc.

- **Firebase App Check Support**  
  - Integrated for added security in dev and prod.

- **Testability**  
  - Protocol-based architecture supports **easy unit/UI testing**.
  - Dependency Injection ready.

---

## 🛠️ Technologies & Approaches Used

- Swift 6.x (Fully compatible with **Swift 6.1**)
- iOS 15.0+ (Minimum deployment target)
- VIPER Architecture
- UIKit
- Dependency Injection (DI)
- `async/await`, `@MainActor`, `Task`
- Protocol-Oriented Programming
- Localization & Theming
- Firebase Analytics Integration
- Custom Base Classes
- Clean Code & Documentation

---

## 📁 Project Structure

```
iosBase/
├── Modules/
│   └── Auth/
│       ├── AuthViewController.swift
│       ├── AuthPresenter.swift
│       ├── AuthInteractor.swift
│       ├── AuthEntity.swift
│       ├── AuthRouter.swift
│       └── AuthBuilder.swift
├── Resources/
│   └── Google Firebase/
│       ├── GoogleService-Info.plist
│       └── GoogleService-Debug-Info.plist
├── Services/
├── Helpers/
└── Apply to Colors.swift
```

---

## ⚡️ Setup

### 1. Clone the repository

```bash
git clone https://github.com/your-repo/iosBase.git
```

### 2. Install dependencies

- Use **Swift Package Manager**. Open the project in Xcode and wait for it to resolve packages.

### 3. Firebase Integration (Optional but Recommended)

If you're using Firebase services (e.g., Auth, Analytics):

1. Go to [Firebase Console](https://console.firebase.google.com/).
2. Download:
   - `GoogleService-Info.plist` for production
   - `GoogleService-Debug-Info.plist` for development (optional)
3. Place the files in the following directory:
   ```
   iosBase/Resources/Google Firebase/
   ```
4. ✅ **Ensure exact file names and paths**. Incorrect naming or directory will break integration.

### 4. Configure Authentication

If you're using your own backend for auth:

- Open `AppDelegate.swift`
- Follow the inline comments to switch between Firebase and custom logic
- Adjust DI containers and auth services accordingly

### 5. Run the Project

1. Open the project in **Xcode 16.4+**
2. Select a build scheme (e.g., `iosBase-Dev`)
3. Press **Run**

---

## ➕ How to Add a New VIPER Module

1. Create a folder under `Modules/` (e.g., `Profile/`)
2. Add the five VIPER components:
   - `ProfileViewController`
   - `ProfilePresenter`
   - `ProfileInteractor`
   - `ProfileEntity`
   - `ProfileRouter`
   - `ProfileBuilder`
3. Register the module in the DI container if needed
4. Use the builder to instantiate and present the module

---

## 🧑‍💻 Contributing

Pull requests and issues are welcome!  
Please follow the existing code style and architectural conventions when contributing.

---

## 📝 License

**MIT**

---

## 📌 Additional Notes

- Minimum iOS 15.0 required (due to modern Swift concurrency)
- Fully compatible with **Swift 6.1** and **Xcode 16.4+**

---

**Feel free to reach out for questions, feedback, or collaboration!**
