import 'package:eco/features/home/view/widget/category_card.dart';
import 'package:eco/utils/extensions.dart';
import 'package:flutter/material.dart';

class CategoriesBody extends StatelessWidget {
  const CategoriesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        10.ph,
        const CategoryCard(),
        const CategoryCard(),
        const CategoryCard(),
        const CategoryCard(),
      ],
    );
  }
}
