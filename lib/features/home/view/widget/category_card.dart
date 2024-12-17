import 'package:eco/utils/colors_box.dart';
import 'package:eco/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:eco/utils/box_styles.dart';
import 'package:eco/utils/images.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: InkWell(
        onTap: () {},
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Ink(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            gradient: LinearGradient(
              colors: [
                ColorsBox.lighterShade,
                ColorsBox.lighterPurple,
                ColorsBox.darkerPurple,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  AssetsBox.userAvatar,
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                ),
              ),
              16.pw,
              Text(
                "Categories",
                style: StylesBox.bold16.copyWith(color: ColorsBox.white),
              ),
              const Spacer(),
              const Icon(Icons.chevron_right_rounded, color: ColorsBox.white),
              8.pw,
            ],
          ),
        ),
      ),
    );
  }
}
