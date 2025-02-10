import 'package:e_commerce/auth/widgets/oauth_widget.dart';
import 'package:e_commerce/core/utils/constants/constants.dart';
import 'package:e_commerce/core/utils/constants/screens_names.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubit/auth_cubit.dart';
import '../widgets/auth_field.dart';
import '../widgets/obscure_button.dart';
import '../widgets/reusable_button.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 48.0, bottom: 29.0, right: 29.0, left: 29.0),
            child: Column(
              children: [
                SizedBox(
                  height: 488,
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      final cubit = context.read<AuthCubit>();
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                'Create an\naccount',
                                textAlign: TextAlign.start,
                                style: Constants.kTitleTextStyle,
                              ),
                            ],
                          ),
                          AuthField(
                            controller: cubit.emailTextController,
                            label: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            icon: const Icon(Icons.person),
                            validator: (value) =>
                                AuthCubit.emailValidator(value),
                          ),
                          AuthField(
                            controller: cubit.passwordTextController,
                            isObscure: cubit.isPasswordObscure,
                            suffixIcon: ObscureButton(
                                isObscure: cubit.isPasswordObscure,
                                onPressed: () => context
                                    .read<AuthCubit>()
                                    .togglePasswordObscure('password')),
                            label: 'Password',
                            icon: const Icon(Icons.lock),
                            validator: (value) =>
                                AuthCubit.passwordValidator(value),
                          ),
                          AuthField(
                            controller: cubit.confirmPasswordTextController,
                            isObscure: cubit.isConfirmPasswordObscure,
                            suffixIcon: ObscureButton(
                                isObscure: cubit.isConfirmPasswordObscure,
                                onPressed: () => context
                                    .read<AuthCubit>()
                                    .togglePasswordObscure('confirmPassword')),
                            label: 'Confirm password',
                            icon: const Icon(Icons.lock),
                            validator: (value) =>
                                AuthCubit.confirmPasswordValidator(
                                    value: value,
                                    passwordTextController:
                                        cubit.passwordTextController),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text:
                                      'By clicking the Create Account button, you\nagree to ',
                                  style: Constants.kGreyTextStyle,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'our terms',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 12,
                                        color: Color(0xFFFF4B26),
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          context.pushNamed(ScreensNames.terms);
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          ReusableButton(
                            onPressed: () async =>
                                await cubit.formsAuthentication(
                                    formKey: formKey,
                                    screen: ScreensNames.signUp),
                            label: 'Create Account',
                          )
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: 260,
                  height: 154,
                  child: OAuthWidget(
                    label: 'I already have an account',
                    buttonText: 'Sign in',
                    onPressed: () => context.pushNamed(ScreensNames.signIn),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
