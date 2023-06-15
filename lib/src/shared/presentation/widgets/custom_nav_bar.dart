import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      notchMargin: 10,
      child: SizedBox(
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              iconSize: 30,
              onPressed: () {},
              icon: const Icon(Icons.home),
            ),
            IconButton(
              iconSize: 30,
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            IconButton(
              iconSize: 30,
              onPressed: () {},
              icon: const Icon(Icons.add_circle),
            ),
            IconButton(
              iconSize: 30,
              onPressed: () {},
              icon: const Icon(Icons.message),
            ),
            IconButton(
              iconSize: 30,
              onPressed: () {},
              icon: const Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}
