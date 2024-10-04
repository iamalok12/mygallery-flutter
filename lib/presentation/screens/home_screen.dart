import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygallery/presentation/controllers/image_controller.dart';
import 'package:mygallery/presentation/widgets/search_bar.dart';
import 'package:responsive_grid/responsive_grid.dart';

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
    controller = Get.put(widget.imageController);
    _scrollController.addListener(_loadMore);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
            const SizedBox(
              height: 30,
            ),
            CustomSearchBar(
              onSearch: (keyWord) {
                controller.getImages(keyWord);
              },
            ),
            const SizedBox(
              height: 30,
            ),
            _showImages(controller),
            _showLoadMore(),
            _showBottomLoader(controller),
          ],
        ),
      ),
    );
  }

  Widget _showImages(ImageController controller) {
    return Obx(
      () {
        if (controller.mainWidgetStatus.value == MainWidgetStatus.initial) {
          return const Expanded(
            child: Text(
              "Enter keyword to search item",
              style: TextStyle(fontSize: 20),
            ),
          );
        }
        if (controller.mainWidgetStatus.value == MainWidgetStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (controller.imageList.isEmpty) {
          return const Expanded(
            child: Text(
              "No item found",
              style: TextStyle(fontSize: 20),
            ),
          );
        }
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
      },
    );
  }

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

  Widget _showBottomLoader(ImageController controller) {
    return Obx(
      () {
        if (controller.listWidgetStatus.value == ListWidgetStatus.loading) {
          return const LinearProgressIndicator();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
