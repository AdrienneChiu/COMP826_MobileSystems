# CyberBuddy - Cyber Safety Learning App for Children

CyberBuddy is an educational mobile application designed to teach children aged 6–12 about cyber safety through interactive lessons, gamified quizzes, and positive reinforcement.Built in Flutter and tested on iOS and Android emulators, the system prioritises child-friendly UX and privacy-by-design.

### Features
- Learning Modules – interactive lessons on safe passwords, scams, online etiquette  
- Gamified Quizzes – short child-friendly quizzes with child-friendly design    
- Completion & Rewards – animations and positive reinforcement to encourage engagement   
- Child-Friendly UI – simple navigation, bright visuals, and large accessible buttons  
- Privacy by Design – all progress stored locally (no accounts, no personal data) 

### Architecture

CyberBuddy follows the Model–View–Presenter (MVP) pattern:

- Model Layer:
ProgressStore, ProgressData, QuizQuestion – manage local data storage and quiz content.
- View Layer:
Screens such as HomePage, LearnView, QuizView, ProfileView, and CompletionView.
- Presenter Layer:
QuizPresenter – handles quiz logic, scoring, and state updates between Model and View.

This structure ensures a clean separation of concerns and easier future extensions.

### Tech Stack
- Frontend: Flutter (Dart)  
- Data Storage: SQLite (offline progress tracking) 
- IDE/Tools: Visual Studio Code, GitHub, Flutter DevTools  
- Testing Environment: iOS Simulator (Xcode), Android Emulator (Android Studio)

<br>

# 📦 Installation
### Prerequisites

- Download [Flutter SDK](https://docs.flutter.dev/get-started/install)  

- Xcode installed (for iOS Simulator)  

- iOS Simulator configured (e.g., iPhone 16 Pro)  
  
### Steps

1. Clone the repository on your chosen IDE

  ```git clone https://github.com/AdrienneChiu/COMP826_MobileSystems.git```  

2. Install dependencies

```flutter pub get```

3. Start the iOS Simulator

```open -a Simulator```

4. Run the app

```flutter run```

- Select your desired iOS device in the simulator (e.g., iPhone 16 Pro).  
- For Android, launch an Android emulator in Android Studio (e.g., Pixel 6) and run ```flutter run -d android```.

  Note: Check Flutter setup - Run ```flutter doctor``` to verify Flutter, Xcode, and simulator configurations. This command highlights missing dependencies or version issues.

<br>

# 👩‍💻 Author

Developed by Adrienne Chiu as part of COMP826 Mobile Systems Development at Auckland University of Technology (AUT), Sem 2 2025.
