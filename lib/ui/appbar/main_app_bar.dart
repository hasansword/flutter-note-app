import 'package:app_client/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  const MainAppBar(
      {super.key, required this.onSearchPress, required this.onInfoPress});

  final Function onSearchPress;
  final Function onInfoPress;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Tamamlanan Egzersizler',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 23,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(82.0);
}
