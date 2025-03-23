# SpaceX Rockets App 🚀

A Flutter application that displays a list of SpaceX rockets and their details. The app fetches data from the [SpaceX API](https://github.com/r-spacex/SpaceX-API) and provides a smooth user experience with features like **offline support**, **shimmer loading effects**, and **pull-to-refresh**.

## Features ✨

- **Rocket List**: Displays a list of SpaceX rockets with their names, countries, and images.
- **Rocket Details**: Shows detailed information about a selected rocket, including its description, dimensions, engines, and more.
- **Shimmer Loading**: Provides a smooth loading experience with a shimmer effect.
- **Offline Support**: Caches rocket data locally using SQLite for offline access.
- **Pull-to-Refresh**: Allows users to refresh data and fetch the latest information from the API.
- **Riverpod State Management**: Efficiently manages app state using Riverpod.

## Screenshots 📸

| Rocket List Screen | Rocket Details Screen |
|--------------------|-----------------------|
| <img src="screenshots/rocket_list.png" width="300"> | <img src="screenshots/rocket_details.png" width="300"> |

## Tech Stack 🛠️

- **Flutter**: The framework used to build the app.
- **Riverpod**: For state management.
- **SQLite**: For local data storage.
- **Shimmer**: For loading animations.
- **SpaceX API**: For fetching rocket data.

## Getting Started 🚀

### Prerequisites

- Flutter SDK installed on your machine. [Install Flutter](https://flutter.dev/docs/get-started/install)
- A code editor (e.g., Visual Studio Code, Android Studio).

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/spacex-rockets-app.git
   cd spacex-rockets-app
2. **Install dependencies**:
   flutter pub get
3. **Run the app**:
   flutter run

### Project Structure 🗂️

```plaintext
lib/
├── main.dart
├── core/
│   ├── constants/
│   │   └── app_constants.dart
│   ├── utils/
│   │   └── app_utils.dart
│   ├── widgets/
│   │   └── custom_shimmer.dart
├── data/
│   ├── models/
│   │   └── rocket_model.dart
│   ├── repositories/
│   │   └── rocket_repository_impl.dart
│   ├── datasources/
│   │   ├── spacex_api_service.dart
│   │   └── local_database.dart
├── domain/
│   ├── entities/
│   │   └── rocket.dart
│   ├── repositories/
│   │   └── rocket_repository.dart
│   ├── usecases/
│   │   └── get_rockets.dart
└── presentation/
    ├── pages/
    │   ├── rocket_list_screen.dart
    │   └── rocket_details_screen.dart
    ├── providers/
    │   └── rocket_provider.dart
    ├── widgets/
    │   └── rocket_item_widget.dart
```


## How It Works 🛠️

1. **Fetching Data**:
   - The app fetches rocket data from the SpaceX API using the SpaceXApiService.
   - Data is cached locally using SQLite for offline access.
2. **State Management**:
   - Riverpod is used to manage the state of rocket data.
   - The rocketProvider fetches data and handles loading and error states.
3. **UI**:
   - The RocketListScreen displays a list of rockets.
   - The RocketDetailsScreen shows detailed information about a selected rocket.
   - A shimmer effect is displayed during data loading.
4. **Offline Support**:
   - If the API call fails, the app retrieves data from the local database.
5. **Pull-to-Refresh**:
   - Users can refresh data by tapping the refresh button in the app bar.

## Dependencies 📦

- flutter_riverpod: For state management.
- shimmer: For loading animations.
- sqflite: For local database storage.
- http: For making API requests.

## Acknowledgments 🙏

- [SpaceX API](https://github.com/r-spacex/SpaceX-API) for providing the rocket data.
- [Flutter](https://flutter.dev/) for the amazing framework.
- [Riverpod](https://riverpod.dev/) for state management.

## Contact 📧

###If you have any questions or suggestions, feel free to reach out:

- Email: rahulbhanushali000@gmail.com

## Happy Coding! 🚀
















   


