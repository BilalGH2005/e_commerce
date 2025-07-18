import 'package:e_commerce/auth/cubit/auth_cubit.dart';
import 'package:e_commerce/auth/presentation/widgets/oauth_button.dart';
import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/constants/app_icons.dart';
import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/core/utils/snackbar_util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cubit/app_cubit.dart';

class OAuthWidget extends StatelessWidget {
  const OAuthWidget({
    super.key,
    required this.label,
    required this.onPressed,
    required this.buttonText,
  });

  final String label;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = context.read<AppCubit>().isDarkTheme;
    return SizedBox(
      width: 236,
      height: 154,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            localization(context).orContinueWith,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Theme.of(context).colorScheme.tertiaryFixed,
                ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OAuthButton(
                iconPath: AppIcons.google,
                onPressed: () async =>
                    await context.read<AuthCubit>().googleSignIn(),
                tooltip: localization(context).googleOAuth,
              ),
              OAuthButton(
                iconPath: AppIcons.apple,
                onPressed: () => SnackBarUtil.showInfo(
                  localization(context).appleAccountsSoon,
                ),
                tooltip: localization(context).appleOAuth,
                colorFilter: isDarkTheme
                    ? const ColorFilter.mode(
                        AppColors.white,
                        BlendMode.srcIn,
                      )
                    : null,
              ),
              OAuthButton(
                iconPath: AppIcons.facebook,
                onPressed: () => SnackBarUtil.showInfo(
                  localization(context).facebookAccountsSoon,
                ),
                tooltip: localization(context).facebookOAuth,
                colorFilter: isDarkTheme
                    ? const ColorFilter.mode(
                        AppColors.white,
                        BlendMode.srcIn,
                      )
                    : null,
              )
            ],
          ),
          RichText(
            text: TextSpan(
              text: "$label ",
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Theme.of(context).colorScheme.tertiaryFixed,
                  ),
              children: <TextSpan>[
                TextSpan(
                  text: buttonText,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        decorationColor: Theme.of(context).colorScheme.primary,
                      ),
                  recognizer: TapGestureRecognizer()..onTap = onPressed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
