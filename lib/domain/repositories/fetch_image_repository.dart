import 'package:mygallery/domain/entities/image_response_model.dart';

abstract class FetchImageRepository {
  Future<ImageResponseModel?> getImage(String query, int page);
}
