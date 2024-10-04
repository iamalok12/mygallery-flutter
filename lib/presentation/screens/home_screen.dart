import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygallery/presentation/controllers/image_controller.dart';
import 'package:mygallery/presentation/widgets/search_bar.dart';
import 'package:responsive_grid/responsive_grid.dart';

// HomeScreen displays a list of images based on search results with pagination
// Uses GetX for state management and ResponsiveGrid for layout

class HomeScreen extends StatefulWidget {
  final ImageController imageController;
  const HomeScreen({super.key, required this.imageController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  late final ImageController controller;

  @override
  void initState() {
    super.initState();
    // Initialize the imageController and add listener to the scroll controller for pagination
    controller = Get.put(widget.imageController);
    _scrollController.addListener(_loadMore);
  }

  @override
  void dispose() {
    // Dispose of the scroll controller to avoid memory leaks
    _scrollController.dispose();
    super.dispose();
  }

  // Load more images when the user reaches the bottom of the scrollable area
  void _loadMore() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      controller.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            // Search bar to input a keyword for image search
            CustomSearchBar(
              onSearch: (keyWord) {
                controller.getImages(keyWord);
              },
            ),
            const SizedBox(height: 30),
            // Show the images based on search results
            _showImages(controller),
            // Show load more button if there are more images to load
            _showLoadMore(),
            // Show a bottom loader if images are being fetched
            _showBottomLoader(controller),
          ],
        ),
      ),
    );
  }

  Widget _showImages(ImageController controller) {
    return Obx(() {
      // Show instructions to search for images if no keyword has been entered
      if (controller.mainWidgetStatus.value == MainWidgetStatus.initial) {
        return const Expanded(
          child: Text(
            "Enter keyword to search item",
            style: TextStyle(fontSize: 20),
          ),
        );
      }
      // Show a loading spinner while fetching images
      if (controller.mainWidgetStatus.value == MainWidgetStatus.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      // Show message if no images are found
      if (controller.imageList.isEmpty) {
        return const Expanded(
          child: Text(
            "No item found",
            style: TextStyle(fontSize: 20),
          ),
        );
      }
      // Display the fetched images in a responsive grid
      return Expanded(
        child: ResponsiveGridList(
          controller: _scrollController,
          desiredItemWidth: 200,
          minSpacing: 10,
          children: controller.imageList
              .map(
                (e) => Container(
                  height: 200,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26, width: 4),
                  ),
                  child: Column(
                    children: [
                      Image.network(
                        e.previewURL!,
                        fit: BoxFit.fill,
                        height: 100,
                        width: 100,
                      ),
                      Text("Like(s):${e.likes}"),
                      Text("View(s):${e.views}"),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      );
    });
  }

  // Button to load more images if available
  Widget _showLoadMore() {
    return Obx(() {
      if (controller.imageList.isNotEmpty) {
        return ElevatedButton(
          onPressed: () {
            controller.loadMore();
          },
          child: const Text("Load More"),
        );
      }
      return const SizedBox.shrink();
    });
  }

  // Show a linear progress indicator at the bottom if more images are being loaded
  Widget _showBottomLoader(ImageController controller) {
    return Obx(() {
      if (controller.listWidgetStatus.value == ListWidgetStatus.loading) {
        return const LinearProgressIndicator();
      }
      return const SizedBox.shrink();
    });
  }
}
