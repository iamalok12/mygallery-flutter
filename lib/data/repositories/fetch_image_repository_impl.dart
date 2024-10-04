import 'package:mygallery/data/datasources/api_provider.dart';
import 'package:mygallery/domain/entities/image_response_model.dart';
import 'package:mygallery/domain/repositories/fetch_image_repository.dart';

class FetchImageRepositoryImpl extends FetchImageRepository {
  final ApiProvider apiProvider;

  FetchImageRepositoryImpl({required this.apiProvider});
  @override
  Future<ImageResponseModel?> getImage(String query, int page) async {
    return await apiProvider.getImage(query, page);
  }
}
