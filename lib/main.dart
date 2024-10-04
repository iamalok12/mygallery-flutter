import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:mygallery/data/datasources/api_provider.dart';
import 'package:mygallery/data/repositories/fetch_image_repository_impl.dart';
import 'package:mygallery/presentation/controllers/image_controller.dart';
import 'package:mygallery/presentation/screens/home_screen.dart';

Future<void> main() async {
  const String baseUrl = "https://pixabay.com/api/";
  const String apiKey = "46323978-1ac16f9490890542937db8edc";
  final httpClient = http.Client();
  final ApiProvider apiProvider =
      ApiProvider(apiKey: apiKey, baseUrl: baseUrl, httpClient: httpClient);
  final FetchImageRepositoryImpl fetchImageRepository =
      FetchImageRepositoryImpl(apiProvider: apiProvider);
  final ImageController imageController =
      ImageController(repository: fetchImageRepository);
  runApp(MyApp(
    imageController: imageController,
  ));
}

class MyApp extends StatelessWidget {
  final ImageController imageController;
  const MyApp({super.key, required this.imageController});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomeScreen(imageController: imageController),
    );
  }
}
