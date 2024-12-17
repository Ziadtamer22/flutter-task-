import 'package:eco/features/authentication/view/widget/build_login_text.dart';
import 'package:eco/features/authentication/view/widget/input_label.dart';
import 'package:eco/features/authentication/view/widget/social_login_buttons.dart';
import 'package:eco/features/authentication/view/widget/text_field.dart';
import 'package:eco/features/authentication/view_model/register_cubit/register_cubit.dart';
import 'package:eco/features/home/view/home_view.dart';
import 'package:eco/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:eco/utils/widget/custom_primary_button.dart';
import 'package:eco/utils/box_styles.dart';
import 'package:eco/utils/colors_box.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/function/validation_function.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _password = '';
  String _email = '';

  final RegisterCubit registerCubit = RegisterCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RegisterCubit, RegisterState>(
        bloc: registerCubit,
        listener: (context, state) {
          if (state is RegisterSuccess) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomeView()));
          }
          if (state is RegisterFailure) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Error: ${state.message}"),
              ));
            });
          }
        },
        builder: (context, state) {
          if (state is RegisterLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      20.ph,
                      const Text("Register", style: StylesBox.bold32),
                      (MediaQuery.sizeOf(context).height * .05).ph,
                      const InputLabel(text: "Enter your email"),
                      10.ph,
                      CustomTextFailed(
                        hintText: 'Enter your email',
                        validator: validateEmail,
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                          });
                          print('Email changed: $value');
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
                          setState(() {
                            _password = value;
                          });
                          print('Password changed: $value');
                        },
                      ),
                      18.ph,
                      const InputLabel(text: "Re-Enter your password"),
                      10.ph,
                      CustomTextFailed(
                        hintText: 'Re-Enter your password',
                        isPassword: true,
                        validator: (value) =>
                            validatePasswordConfirmation(value, _password),
                        onChanged: (value) {
                          print('Password confirmation changed: $value');
                        },
                      ),
                      10.ph,
                      _buildPrimaryButton(context),
                      10.ph,
                      const BuildLoginText(),
                      10.ph,
                      Text(
                        "Or",
                        style: StylesBox.bold16.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      10.ph,
                      const SocialLoginButtons(),
                      10.ph,
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

  Widget _buildPrimaryButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomPrimaryButton(
        title: "Register",
        onTap: () async {
          if (_formKey.currentState?.validate() ?? false) {
            await registerCubit.registerWithEmail(_email, _password);
          }
        },
      ),
    );
  }
}
