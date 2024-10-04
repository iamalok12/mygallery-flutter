import 'package:get/get.dart';
import 'package:mygallery/data/repositories/fetch_image_repository_impl.dart';
import 'package:mygallery/domain/entities/image_response_model.dart';

// Controller for managing image search and pagination in the application
// Uses GetX for state management and interacts with FetchImageRepositoryImpl to fetch data

enum MainWidgetStatus { initial, loading, success, fail }

enum ListWidgetStatus { initial, loading, success, fail }

class ImageController extends GetxController {
  final FetchImageRepositoryImpl repository;

  // Observable list to hold the fetched image data
  RxList<Hits> imageList = <Hits>[].obs;

  ImageController({required this.repository});

  // Observable variables to track the state of main and list widgets
  Rx<MainWidgetStatus> mainWidgetStatus = (MainWidgetStatus.initial).obs;
  Rx<ListWidgetStatus> listWidgetStatus = (ListWidgetStatus.initial).obs;

  // Formats the search query by replacing spaces with "+"
  String formatQuery(String keyword) {
    return keyword.trim().replaceAll(" ", "+");
  }

  int page = 1;
  int totalImageCount = 0;
  String keyword = "";

  // Loads more images for pagination when the user reaches the end of the list
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

  // Fetches images based on the entered keyword
  void getImages(String keyword) async {
    try {
      page = 1;
      imageList.clear();
      mainWidgetStatus(MainWidgetStatus.loading);
      final ImageResponseModel? response =
          await repository.getImage(formatQuery(keyword), page);
      if (response != null) {
        totalImageCount = response.totalHits!;
        this.keyword = keyword; // Update the keyword after search
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
