import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 5,
      ),
      child: TextFormField(
        style: const TextStyle(
          fontWeight: FontWeight.normal,
        ),
        decoration: InputDecoration(
          hintText: 'All Songs',
          contentPadding: const EdgeInsets.fromLTRB(
            20.0,
            10.0,
            20.0,
            10.0,
          ),
          prefixIcon: const Icon(
            Icons.search,
          ),
          labelText: 'Search Now...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
        ),
      ),
    );
  }
}
