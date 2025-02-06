import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchBarWidget extends ConsumerWidget {
  final TextEditingController searchController;
  final String filterType;
  final Function(String) onSearchChanged;

  const SearchBarWidget({
    super.key,
    required this.searchController,
    required this.filterType,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width * 0.65,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
         border: Border(
          top: BorderSide(color: Colors.white, width: 1),
          left: BorderSide(color: Colors.white, width: 1),
          bottom: BorderSide(color: Colors.white, width: 2),
          right: BorderSide(color: Colors.white, width: 2),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black, offset: Offset(1, 1), blurRadius:1)
        ],
      ),
      child: Center(
        child: TextField(
          controller: searchController,
          onChanged: onSearchChanged,
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(fontFamily: 'inter', fontSize: 14),
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
