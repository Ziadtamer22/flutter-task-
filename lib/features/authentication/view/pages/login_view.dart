import 'package:eco/features/authentication/view/pages/forgot_password_view.dart';
import 'package:eco/features/authentication/view/widget/build_register_text.dart';
import 'package:eco/features/authentication/view/widget/input_label.dart';
import 'package:eco/features/authentication/view/widget/social_login_buttons.dart';
import 'package:eco/features/authentication/view/widget/text_field.dart';
import 'package:eco/features/authentication/view_model/login_cubit/login_cubit.dart';
import 'package:eco/features/home/view/home_view.dart';
import 'package:eco/utils/extensions.dart';
import 'package:eco/utils/widget/custom_primary_button.dart';
import 'package:eco/utils/box_styles.dart';
import 'package:eco/utils/colors_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/function/validation_function.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String email = '';
    String password = '';
    LoginCubit loginCubit = LoginCubit();

    return Scaffold(
      body: BlocBuilder<LoginCubit, LoginState>(
        bloc: loginCubit,
        builder: (context, state) {
          if (state is LoginLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LoginError) {
            // Schedule a post-frame callback to show the SnackBar
            WidgetsBinding.instance.addPostFrameCallback((_) {
              print("eeeerorr: ${state.error}");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            });
          }

          if (state is LoginSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Login Successful"),
                ),
              );
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomeView()));
            });
          }

          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      20.ph,
                      const Text(
                        "Login",
                        style: StylesBox.bold32,
                      ),
                      (MediaQuery.sizeOf(context).height * .1).ph,
                      const InputLabel(text: "Enter your email"),
                      10.ph,
                      CustomTextFailed(
                        hintText: 'Enter your email',
                        validator: validateEmail,
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                      18.ph,
                      const InputLabel(text: "Enter your password"),
                      10.ph,
                      CustomTextFailed(
                        hintText: 'Enter your password',
                        isPassword: true,
                        validator: validatePassword,
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ForgetPasswordView(),
                              ),
                            );
                          },
                          child: Text(
                            "Forgot password?",
                            style: StylesBox.regular16.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
                      10.ph,
                      SizedBox(
                        width: double.infinity,
                        child: CustomPrimaryButton(
                          title: "Login",
                          onTap: () {
                            if (formKey.currentState?.validate() ?? false) {
                              loginCubit.loginWithEmail(email, password);
                            }
                          },
                        ),
                      ),
                      10.ph,
                      const BuildRegisterText(),
                      10.ph,
                      Text(
                        "Or",
                        style:
                            StylesBox.bold16.copyWith(color: Colors.grey[600]),
                      ),
                      10.ph,
                      const SocialLoginButtons(),
                      10.ph,
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeView()));
                        },
                        child: Text(
                          "Continue as Guest",
                          style: StylesBox.bold16.copyWith(
                            decoration: TextDecoration.underline,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
