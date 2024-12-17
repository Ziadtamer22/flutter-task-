import 'package:eco/features/authentication/view/pages/login_view.dart';
import 'package:eco/features/profile/view/profile_view.dart';
import 'package:eco/utils/colors_box.dart';
import 'package:eco/utils/extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eco/utils/box_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Row(
      children: [
        /// <---- user image ---->///
        InkWell(
          onTap: () {
            if (user != null) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProfileView()));
            } else {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginView()),
                (Route<dynamic> route) => false,
              );
            }
          },
          borderRadius: BorderRadius.circular(99999),
          child: SizedBox(
            height: 40,
            width: 40,
            child: CircleAvatar(
              backgroundColor: Colors.blueAccent.withOpacity(0.2),
              child: user?.photoURL == null
                  ? const Icon(
                      Icons.person,
                      color: Colors.blueAccent,
                    )
                  : CachedNetworkImage(imageUrl: user?.photoURL ?? "s"),
            ),
          ),
        ),

        10.pw,

        ///<----- user name ----->///
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "welcome ${user?.displayName ?? " "}",
              style: StylesBox.bold16,
            ),
            const Text(
              "start Shopping",
              style: StylesBox.regular16,
            ),
          ],
        ),
        const Spacer(),

        /// <---- team info button ---->///
        InkWell(
          onTap: () {
            // todo add team info page
          },
          borderRadius: BorderRadius.circular(200),
          child: Ink(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: ColorsBox.lighterPurple,
              borderRadius: BorderRadius.circular(200),
            ),
            child: const Icon(
              Icons.info_outline_rounded,
              color: ColorsBox.white,
            ),
          ),
        ),
      ],
    );
  }
}
