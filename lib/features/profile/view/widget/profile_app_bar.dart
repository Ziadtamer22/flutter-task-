import 'package:eco/utils/box_styles.dart';
import 'package:eco/utils/widget/back_button.dart';
import 'package:flutter/material.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CustomBackButton(),
          const Text(
            "My profile",
            style: StylesBox.semibold18,
          ),

          ///<--------- LOGOUT BUTTON --------->///
          IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
