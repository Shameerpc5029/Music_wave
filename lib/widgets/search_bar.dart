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
        cursorColor: const Color.fromARGB(
          255,
          174,
          48,
          39,
        ),
        style: const TextStyle(
          fontWeight: FontWeight.normal,
        ),
        decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.mic_none_rounded,
                color: Color.fromARGB(
                  255,
                  174,
                  48,
                  39,
                ),
              )),
          hintText: 'All Songs',
          hintStyle: const TextStyle(
            color: Color.fromARGB(
              255,
              174,
              48,
              39,
            ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(
            20.0,
            10.0,
            20.0,
            10.0,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: Color.fromARGB(
              255,
              174,
              48,
              39,
            ),
          ),
          labelText: 'Search Now...',
          labelStyle: const TextStyle(
            color: Color.fromARGB(
              255,
              174,
              48,
              39,
            ),
          ),
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
