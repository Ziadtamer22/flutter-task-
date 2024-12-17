import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return SizedBox(
      height: MediaQuery.sizeOf(context).width * .4,
      width: MediaQuery.sizeOf(context).width * .4,
      child: CircleAvatar(
        backgroundColor: Colors.blueAccent.withOpacity(0.2),
        child: user?.photoURL == null
            ? Icon(
                Icons.person,
                size: MediaQuery.sizeOf(context).width * .25,
                color: Colors.blueAccent,
              )
            : CachedNetworkImage(imageUrl: user?.photoURL ?? "s"),
      ),
    );
  }
}
