import 'package:app_client/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class ShowNoteAppBar extends StatelessWidget with PreferredSizeWidget {
  const ShowNoteAppBar(
      {super.key,
      required this.onColorChangePress,
      required this.color,
      required this.onBackPressed});

  final Function onBackPressed;
  final Function onColorChangePress;
  final int color;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(right: 16, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => {onBackPressed()},
              borderRadius: BorderRadius.circular(16),
              child: Ink(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                  color: Colors.white,
                ),
                
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.black,
                ),
                
              ),
            ),
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(color),
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                const SizedBox(width: 22),
                
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(82.0);
}
