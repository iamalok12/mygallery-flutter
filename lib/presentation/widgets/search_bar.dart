import 'package:flutter/material.dart';

// A custom search bar widget with a callback function that triggers when the search icon is tapped.
class CustomSearchBar extends StatefulWidget {
  final Function(String keyword) onSearch;
  const CustomSearchBar({super.key, required this.onSearch});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: "Enter Keyword",
                border: InputBorder.none,
              ),
              controller: _searchController,
            ),
          ),
          InkWell(
            onTap: () {
              widget.onSearch(_searchController.text);
            },
            child: const Icon(Icons.search),
          )
        ],
      ),
    );
  }
}
