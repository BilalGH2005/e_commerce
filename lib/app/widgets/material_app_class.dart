import 'package:e_commerce/admin/cubit/admin_cubit.dart';
import 'package:e_commerce/app/cubit/app_cubit.dart';
import 'package:e_commerce/auth/cubit/auth_cubit.dart';
import 'package:e_commerce/core/router/app_router.dart';
import 'package:e_commerce/core/themes/dark_theme.dart';
import 'package:e_commerce/core/themes/light_theme.dart';
import 'package:e_commerce/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MaterialAppClass extends StatelessWidget {
  const MaterialAppClass({super.key});

  //TODO: fix material app getting called twice
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppCubit()..getAppInitialData(),
          ),
          BlocProvider(
            create: (context) => AuthCubit()
              ..addAuthEventsListener()
              ..addUriListener(),
          ),
          BlocProvider(
            create: (context) => HomeCubit(),
          ),
          BlocProvider(
            create: (context) => AdminCubit(),
          ),
        ],
        child: Builder(
          builder: (context) => BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              final cubit = context.read<AppCubit>();
              final locale =
                  cubit.isArabic ? const Locale('ar') : const Locale('en');
              return MaterialApp.router(
                title: 'E-Commerce',
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: AppLocalizations.supportedLocales,
                locale: locale,
                routerConfig: router,
                debugShowCheckedModeBanner: false,
                theme: LightTheme(locale).lightTheme,
                darkTheme: DarkTheme(locale).darkTheme,
                themeMode: cubit.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
              );
            },
          ),
        ),
      );
}
