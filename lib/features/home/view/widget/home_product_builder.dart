import 'package:eco/features/home/view/widget/product_card.dart';
import 'package:eco/features/home/view/widget/show_all_row.dart';
import 'package:eco/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:eco/utils/box_styles.dart';

class HomeProductBuilder extends StatelessWidget {
  const HomeProductBuilder({super.key, required this.categoryTitle});
  final String categoryTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShowAllRow(title: categoryTitle),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [ProductCard(), ProductCard()],
        ),
        10.ph,
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ProductCard(),
            ProductCard(),
          ],
        ),
        Align(
          alignment: AlignmentDirectional.center,
          child: TextButton(
            onPressed: () {},
            child: const Text("see more", style: StylesBox.bold16),
          ),
        ),
      ],
    );
  }
}
