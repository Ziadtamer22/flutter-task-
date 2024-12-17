import 'package:eco/utils/colors_box.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.of(context).pop(),
        borderRadius: BorderRadius.circular(50),
        child: Ink(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: ColorsBox.white50,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.grey[600]!, width: 1.5),
          ),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }
}
