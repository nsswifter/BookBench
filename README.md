# <img src="Documentation/icon.png" style="border: 1px solid purple" width="60" height="60"/> &nbsp; BookBench

BookBench is a dynamic and innovative iOS application designed to streamline the process of reserving library seats.
Leveraging the power of `SwiftUI` and following a well-structured `MVVM architecture`, this app aims to provide users with a convenient and efficient way to secure a seat in the library. 
While the project is currently in progress, significant milestones have been accomplished, including the implementation of `SignUp`, `LogIn`, and `Reset Password` views using `Firebase` Authentication and Database. 
Additionally, a visually appealing launch screenView, accompanied by a captivating custom `Lottie animation`, creates a memorable user experience.

> Note: The project is currently in progress...

## Table of Contents

- [Project Diagram](#project-diagram)
- [Package Dependencies](#package-dependencies)
- [Contributing](#contributors)
- [Author](#author)
- [License](#license)

## Project Diagram

```bash
.
├── BookBench
│   ├── App
│   │   ├── Assets.xcassets
│   │   │   ├── AccentColor.colorset
│   │   │   │   └── Contents.json
│   │   │   ├── AppIcon.appiconset
│   │   │   │   ├── Contents.json
│   │   │   │   └── icon.png
│   │   │   └── Contents.json
│   │   ├── BookBenchApp.swift
│   │   └── GoogleService-Info.plist
│   ├── Info.plist
│   ├── Models
│   │   └── AuthModel.swift
│   ├── Utils
│   │   ├── DynamicLinearGradient.swift
│   │   ├── Extensions
│   │   │   └── View.swift
│   │   ├── GradientIcon.swift
│   │   ├── Lottie
│   │   │   └── BookBenchAnimation.json
│   │   ├── LottieView.swift
│   │   └── RevealableSecureField.swift
│   ├── ViewModels
│   │   ├── AuthViewModel.swift
│   │   └── ContentViewModel.swift
│   └── Views
│       ├── Authentication
│       │   ├── AuthPages
│       │   │   ├── ForgotPasswordView.swift
│       │   │   ├── LogInView.swift
│       │   │   └── SignUpView.swift
│       │   └── AuthView.swift
│       ├── ContentView.swift
│       ├── LaunchScreenView.swift
│       ├── MainView.swift
│       └── ProfileView.swift
├── BookBench.xcodeproj
│   ├── project.pbxproj
│   ├── project.xcworkspace
│   │   ├── contents.xcworkspacedata
│   │   ├── xcshareddata
│   │   │   ├── IDEWorkspaceChecks.plist
│   │   │   ├── WorkspaceSettings.xcsettings
│   │   │   └── swiftpm
│   │   │       ├── Package.resolved
│   │   │       └── configuration
│   │   └── xcuserdata
│   │       └── mehdi.xcuserdatad
│   │           ├── UserInterfaceState.xcuserstate
│   │           └── WorkspaceSettings.xcsettings
│   └── xcuserdata
│       └── mehdi.xcuserdatad
│           ├── xcdebugger
│           │   └── Breakpoints_v2.xcbkptlist
│           └── xcschemes
│               └── xcschememanagement.plist
├── Documentation
│   └── icon.png
└── README.md
```
## Package Dependencies

[Firebase](https://github.com/firebase/firebase-ios-sdk) 

[Lottie iOS](https://github.com/airbnb/lottie-ios.git)

## Contributors

Feel free to share your ideas or any other problems. Pull requests are welcome! 
For major changes, please open an issue first to discuss what you would like to change.

## Author

- [Mehdi Karami](https://www.github.com/mehdi2003karami)

## License

`Book Bench` is released under an MIT license. See [LICENSE](LICENSE) for more information.
