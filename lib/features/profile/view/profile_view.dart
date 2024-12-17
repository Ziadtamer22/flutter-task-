import 'package:eco/features/authentication/view/pages/login_view.dart';
import 'package:eco/features/profile/view/widget/profile_app_bar.dart';
import 'package:eco/features/profile/view/widget/profile_info.dart';
import 'package:eco/features/profile/view/widget/user_image.dart';
import 'package:eco/features/profile/view_model/cubit/log_out_cubit.dart';
import 'package:eco/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    LogOutCubit logOutCubit = LogOutCubit();
    return Scaffold(
      body: BlocConsumer<LogOutCubit, LogOutState>(
        bloc: logOutCubit,
        listener: (context, state) {
          if (state is LogOutSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(" logged out successfully"),
                ),
              );
            });
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginView()),
              (Route<dynamic> route) => false,
            );
          } else if (state is LogOutFailure) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(" logged out failed"),
                ),
              );
            });
          }
        },
        builder: (context, state) {
          if (state is LogOutLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SafeArea(
            child: Column(
              children: [
                ProfileAppBar(
                  onPressed: () {
                    logOutCubit.logout();
                  },
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const ProfileImage(),
                          20.ph,
                          const UserInformation(),
                          20.ph,
                          10.ph,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
