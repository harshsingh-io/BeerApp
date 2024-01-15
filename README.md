# Beer Explorer App

Welcome to the Beer Explorer app, a Flutter project utilizing the BLoC pattern and the Punk API.

## Overview

The Beer Explorer app is designed to provide users with an extensive list of beers, fetched from the Punk API. The app utilizes the BLoC pattern for efficient state management, creating a seamless and responsive user experience.


<img src="https://github.com/harshsingh-io/BeerApp/raw/main/6116255260269875734.gif" alt="Demo GIF" width="180" height="400">

## Features

- Display a list of beers with infinite scrolling.
- View detailed information about each beer.
- Filter the beer list based on Alcohol By Volume (ABV) and International Bitterness Units (IBU).
- User-friendly and aesthetically pleasing design.

## Project Structure

- **lib/blocs**: Contains BLoC classes for managing the state of the app.
  - `beer_list_bloc.dart`: Handles fetching and filtering of beer data.
  - `beer_details_bloc.dart`: Manages the state of the beer details screen.

- **lib/models**: Includes the data models used in the app.
  - `beer_model.dart`: Represents the structure of beer data.

- **lib/screens**: Holds the different screens of the app.
  - `beer_list_screen.dart`: Displays the list of beers and handles filtering.
  - `beer_details_screen.dart`: Presents detailed information about a selected beer.

- **lib/services**: Provides the ApiService for fetching beer data from the Punk API.

- **lib/utils**: Contains constants used throughout the app.

- **lib/widgets**: Includes reusable widgets for the app.
  - `beer_tile.dart`: Represents a tile for displaying individual beer items.

## Getting Started

To run the project locally, follow these steps:

1. Ensure you have Flutter installed. If not, [install Flutter](https://flutter.dev/docs/get-started/install).
2. Clone this repository: `git clone <repository_url>`
3. Navigate to the project directory: `cd filename`
4. Run the app: `flutter run`

## Dependencies

- `flutter_bloc`: State management library for Flutter.
- `http`: HTTP client for making API calls.

## Acknowledgments

- Punk API (https://punkapi.com/documentation/v2): Providing the beer data for the app.
