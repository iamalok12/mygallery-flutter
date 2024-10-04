import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mygallery/domain/entities/image_response_model.dart';

class ApiProvider {
  final String baseUrl;
  final String apiKey;
  final http.Client httpClient;

  ApiProvider(
      {required this.baseUrl, required this.apiKey, required this.httpClient});

  Future<ImageResponseModel?> getImage(String keyword, int page) async {
    final response = await httpClient.get(Uri.parse(
        '$baseUrl?key=$apiKey&q=$keyword&image_type=photo&page=$page'));
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return ImageResponseModel.fromJson(result);
    } else {
      throw Exception("Something went wrong!");
    }
  }
}
