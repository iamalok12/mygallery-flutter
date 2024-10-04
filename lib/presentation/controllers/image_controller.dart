import 'package:get/get.dart';
import 'package:mygallery/data/repositories/fetch_image_repository_impl.dart';
import 'package:mygallery/domain/entities/image_response_model.dart';

enum MainWidgetStatus { initial, loading, success, fail }

enum ListWidgetStatus { initial, loading, success, fail }

class ImageController extends GetxController {
  final FetchImageRepositoryImpl repository;

  RxList<Hits> imageList = <Hits>[].obs;

  ImageController({required this.repository});

  Rx<MainWidgetStatus> mainWidgetStatus = (MainWidgetStatus.initial).obs;
  Rx<ListWidgetStatus> listWidgetStatus = (ListWidgetStatus.initial).obs;
  String formatQuery(String keyword) {
    return keyword.trim().replaceAll(" ", "+");
  }

  int page = 1;
  int totalImageCount = 0;
  String keyword = "";

  void loadMore() async {
    try {
      listWidgetStatus(ListWidgetStatus.loading);
      bool hasMore = imageList.length < totalImageCount;
      if (hasMore) {
        page++;
        final ImageResponseModel? response =
            await repository.getImage(formatQuery(keyword), page);
        if (response != null) {
          totalImageCount = response.totalHits!;
          imageList.addAll(response.hits!);
          listWidgetStatus(ListWidgetStatus.success);
          return;
        }
      }
      listWidgetStatus(ListWidgetStatus.fail);
    } catch (e) {
      listWidgetStatus(ListWidgetStatus.fail);
    }
  }

  void getImages(String keyword) async {
    try {
      page = 1;
      imageList.clear();
      mainWidgetStatus(MainWidgetStatus.loading);
      final ImageResponseModel? response =
          await repository.getImage(formatQuery(keyword), page);
      if (response != null) {
        totalImageCount = response.totalHits!;
        keyword = keyword;
        imageList.addAll(response.hits!);
        mainWidgetStatus(MainWidgetStatus.success);
        return;
      }
      mainWidgetStatus(MainWidgetStatus.fail);
    } catch (e) {
      mainWidgetStatus(MainWidgetStatus.fail);
    }
  }
}
