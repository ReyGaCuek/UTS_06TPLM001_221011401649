# 🌦️ Weather App

A beautifully crafted Weather Application built with Flutter — fast, modern, and reliable.  
Get real-time weather updates by simply entering your city. ☁️☀️❄️⚡

---

## ✨ Features

- 🔍 **Search Weather by City**
- 🌡️ **Current, Min, Max Temperature**
- 📅 **Formatted Date & Time**
- 🎨 **Dynamic Weather Icons**
- 🌈 **Sleek, Modern UI**
- 🔒 **Secure API Key Management with `.env`**

---

## 🚀 Built With

| Package         | Description                       |
|-----------------|-----------------------------------|
| `cupertino_icons` | iOS-style icons |
| `http`           | Easy HTTP requests |
| `intl`           | Date & Time formatting |
| `flutter_dotenv` | Environment variable handling |
| `weather_icons`  | Weather-specific beautiful icons |

---

## 🖼️ Preview

<img src="screenshot\Screenshot_1.png" alt="Weather app demo" width="200"/>
<img src="screenshot\Screenshot_2.png" alt="Weather app demo" width="200"/>
<img src="screenshot\Screenshot_3.png" alt="Weather app demo" width="200"/>

---

## ‼️ Important Set Up ‼️

Create a .env file in your root directory:
```bash
touch .env
```

Inside .env, add your OpenWeatherMap API Key:
```bash
API_KEY=your_api_key_here
```

ex : https://api.openweathermap.org/data/2.5/weather?q=Jakarta&appid={your_api_key_here}&units=metric

### ❕ Install Dependencies ❕
```bash
flutter pub get
```

### ❕ Run the App ❕
```bash
flutter run
```

---

## 📄 License

MIT – see [LICENSE](LICENSE)

---

## 🛠️ Installation

1. **Clone the Repository**

```bash
git clone https://github.com/ReyGaCuek/UTS_06TPLM001_221011401649.git
cd weather_app
