# Flutter Image Gallery Application

This Flutter application is a responsive image gallery that fetches and displays images from the Pixabay API. The images are shown in a square grid, with the number of columns automatically adjusted based on the screen width. The app supports infinite scrolling, dynamically loading new images as the user scrolls down. Additionally, each image displays the number of likes and views.

## Features

- **Responsive Grid Layout**: The number of image columns adjusts based on the screen width.
- **Pixabay API Integration**: Images are fetched dynamically from Pixabay.
- **Likes and Views Display**: Each image shows the total number of likes and views underneath.
- **Infinite Scrolling**: The gallery supports automatic loading of new images when the user scrolls down.
- **Web Version**: The application is deployed and accessible on GitHub Pages.

## How to Use

1. **Search Images**: Enter a keyword in the search bar to find images related to the search term.
2. **Infinite Scroll**: As you scroll through the gallery, more images will be automatically loaded.
3. **Image Details**: Each image shows the number of likes and views below it.

## Getting Started

### Prerequisites

To run the application locally, you need to have the following installed:

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- A code editor (e.g., VSCode, Android Studio)

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/iamalok12/mygallery-flutter
   ```

2. Navigate to the project directory:

   ```bash
   cd mygallery
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Obtain a Pixabay API key by signing up at [Pixabay API](https://pixabay.com/api/docs/).

5. Add your API key to the project. Open `main.dart` and replace the placeholder with your actual API key:

   ```dart
   const String apiKey = 'YOUR_PIXABAY_API_KEY';
   ```

6. Run the application:

   ```bash
   flutter run
   ```

### Web Deployment (GitHub Pages)

1. Enable web support in Flutter by running:

   ```bash
   flutter config --enable-web
   ```

2. Build the Flutter web app:

   ```bash
   flutter build web
   ```

## Code Structure

- `lib/`: Main source folder
  - `controllers/`: Contains GetX controllers for managing state (e.g., `image_controller.dart`).
  - `data/`: Contains repositories and models for fetching images from the Pixabay API.
  - `presentation/`: Contains the UI components and widgets, such as the `HomeScreen` and `CustomSearchBar`.
  - `widgets/`: Contains reusable components, like the custom search bar widget.
