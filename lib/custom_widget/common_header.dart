import 'package:flutter/material.dart';

class CommonHeader extends StatelessWidget {
  final bool isDesktop;
  final BuildContext context;
  const CommonHeader({super.key, required this.isDesktop, required this.context});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: !isDesktop
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.end,
      children: [
        if (!isDesktop)
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hey Harshil',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("harshil@gmail.com",
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
