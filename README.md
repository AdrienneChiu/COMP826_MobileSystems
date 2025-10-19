# 📱 CyberBuddy - Cyber Safety Learning App for Children

An educational mobile application designed to teach children aged 6–12 about cyber safety through interactive lessons, gamified quizzes, and motivational rewards. Built with Flutter and tested on the Xcode iOS Simulator.

### 🚀 Features
📚 Learning Modules – interactive lessons on safe passwords, scams, online etiquette  
🎮 Gamified Quizzes – short child-friendly quizzes with child-friendly design    
🏆 Completion & Rewards – animations and positive reinforcement to encourage engagement   
🎨 Child-Friendly UI – simple navigation, bright visuals, and large accessible buttons  
🔒 Privacy by Design – all progress stored locally (no accounts, no personal data) 

### 🧩Architecture

CyberBuddy follows the Model–View–Presenter (MVP) pattern:

- Model Layer:
ProgressStore, ProgressData, QuizQuestion – manage local data storage and quiz content.
- View Layer:
Screens such as HomePage, LearnView, QuizView, ProfileView, and CompletionView.
- Presenter Layer:
QuizPresenter – handles quiz logic, scoring, and state updates between Model and View.\

This structure ensures a clean separation of concerns and easier future extensions.

### 🛠️ Tech Stack
- Frontend: Flutter (Dart)  
- Backend (Prototype): Local JSON/state (extendable to SQLite)   
- IDE/Tools: Visual Studio Code, GitHub, Flutter DevTools  
- Testing Environment: Xcode Simulator (iOS)

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


3. Run the app on Xcode iOS Simulator

```flutter run```


- Select your desired iOS device in the simulator (e.g., iPhone 16 Pro).  
- For Android testing, run on an Android Emulator via Android Studio (e.g., Google Pixel 6).

  Note: Check Flutter setup - Run ```flutter doctor``` to verify Flutter, Xcode, and simulator configurations. This command highlights missing dependencies or version issues.

<br>

# 👩‍💻 Author

Developed by Adrienne Chiu as part of COMP826 Mobile Systems Development at Auckland University of Technology (AUT), Sem 2 2025.
