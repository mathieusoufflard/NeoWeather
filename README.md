# 🌤️ NeoWeather

flutter mobil app made for Neosilver as part of a technical test
NeoWeather is a modern weather application built with **Flutter**. It allows users to search, add, and view weather forecasts for their favorite cities while offering an offline mode using **Hive**.

---

## 📋 **Key Features**
✅ Search and add cities via the OpenWeather API  
✅ Display current, hourly, and daily weather forecasts  
✅ Automatic weather data updates every hour  
✅ Detect the user’s location to add the current city  
✅ Store cities and weather data locally using **Hive**  
✅ Smooth and responsive UI  

---

## 🚀 **Installation and Setup**

### 1️⃣ **Prerequisites**
- **Flutter** (>=3.x)
- **Dart** (>=2.17)
- An **OpenWeather API key** ([Get your key here](https://home.openweathermap.org/api_keys))
- **GitHub account** (if you plan to clone the repository)

### 2️⃣ **Clone the Repository**
```sh
git clone https://github.com/YourUsername/NeoWeather.git
cd NeoWeather
```

### 3️⃣ **Install Dependencies**
```sh
flutter pub get
```

### 4️⃣ **Configure the API Key with `dotenv`**
The application uses the **dotenv** package to securely store the API key.

🔹 **Create a `.env` file in the project root**  
🔹 **Add the following line with your OpenWeather API key:**  
```sh
API_KEY=your_api_key_here
```

🔹 **Ensure `flutter_dotenv` is included in `pubspec.yaml`:**  
```yaml
dependencies:
  flutter_dotenv: ^5.0.2
```

🔹 **Load the `.env` file in `main.dart`:**  
```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}
```

🔹 **Use the API Key in API calls (`api_call.dart`):**  
```dart
final url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=Paris&appid=${dotenv.env['API_KEY']}");
```

⚠️ **IMPORTANT:** Add `.env` to `.gitignore` to prevent pushing your API key to GitHub:
```sh
# .gitignore
.env
```

---

## 🛠️ **Technologies Used**
- **Flutter & Dart** 🏗️
- **Hive** for local storage 📦
- **OpenWeather API** for weather data 🌍
- **Geolocator** for location tracking 📍
- **flutter_dotenv** for environment variable management 🔑

---

## 🤝 **How to Contribute**
Contributions are welcome! Clone the repo, create a branch, and submit a **pull request** 🚀.

### 1️⃣ **Fork the Repository**
```sh
git fork https://github.com/YourUsername/NeoWeather.git
```

### 2️⃣ **Create a Feature Branch**
```sh
git checkout -b my-feature
```

### 3️⃣ **Commit and Push Changes**
```sh
git add .
git commit -m "Added my new feature"
git push origin my-feature
```

---

