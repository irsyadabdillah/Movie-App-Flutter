import 'package:flutter/material.dart';
import 'package:movie_app_flutter/style/colors.dart';

class SettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final GestureTapCallback onTap;
  const SettingItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 24.0, left: 24.0, top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  color: maroon,
                  size: 24,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                    child: Text(
                  title,
                  style: const TextStyle(fontSize: 16),
                )),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: maroon,
                  size: 14,
                )
              ],
            ),
          ),
          const Divider()
        ],
      ),
    );
  }
}
