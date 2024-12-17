import 'package:eco/utils/extensions.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:eco/features/authentication/view_model/login_cubit/login_cubit.dart';
import 'package:eco/utils/box_styles.dart';
import 'package:eco/utils/widget/custom_outline_button.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SocialLoginButton(
          onTap: () async {
            await LoginCubit().loginWithGoogle();
          },
          icon: const Icon(EvaIcons.google, color: Color(0xffd62d20)),
          title: "Continue with Google",
        ),
        10.ph,
        SocialLoginButton(
          onTap: () {},
          icon: Icon(EvaIcons.facebook, color: Colors.blue.shade800),
          title: "Continue with Facebook",
        ),
      ],
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final Widget icon;
  final String title;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomOutlineButton(
        icon: Padding(
          padding: const EdgeInsetsDirectional.only(end: 10),
          child: icon,
        ),
        title: title,
        onTap: onTap,
      ),
    );
  }
}
