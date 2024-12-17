import 'package:flutter/material.dart';
import 'package:eco/utils/box_styles.dart';

class ShowAllRow extends StatelessWidget {
  const ShowAllRow({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: StylesBox.bold16),
        TextButton(
          child: const Text("see All", style: StylesBox.medium16),
          onPressed: () {},
        )
      ],
    );
  }
}
