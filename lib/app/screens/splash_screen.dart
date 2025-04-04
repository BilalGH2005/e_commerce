import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Center(
        child: screenWidth >= 500
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/app_logo.svg'),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'E-Commerce',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/app_logo.svg'),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'E-Commerce',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
      ),
    );
  }
}
