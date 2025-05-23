import 'package:e_commerce/core/constants/screens_names.dart';
import 'package:e_commerce/core/utils/duration_extension.dart';
import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'onboarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitial()) {
    _addPageViewListener();
  }

  final PageController pageController = PageController();
  int currentPage = 0;

  void _addPageViewListener() => pageController.addListener(() {
        currentPage = pageController.page?.round() ?? 0;
        emit(OnBoardingPageChanged());
      });

  Future<void> goToPreviousPage() async => await pageController.previousPage(
        duration: 1.s,
        curve: Curves.decelerate,
      );

  Future<void> goToNextPage() async => await pageController.nextPage(
        duration: 1.s,
        curve: Curves.decelerate,
      );

  Future<void> goToSignIn(BuildContext context) async {
    await sharedPreferences.setBool('seenOnBoarding', true);
    print(sharedPreferences.getBool('seenOnBoarding'));
    context.goNamed(ScreensNames.auth);
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
