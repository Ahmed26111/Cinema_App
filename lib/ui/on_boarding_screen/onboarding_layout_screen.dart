import 'dart:developer';

import 'package:cinema_app/constants/color%20constants/colors_manager.dart';
import 'package:cinema_app/constants/routes%20constants/routes_constants.dart';
import 'package:cinema_app/ui/core/theme/theme_manager.dart';
import 'package:cinema_app/ui/on_boarding_screen/onboarding_change_index_cubit.dart';
import 'package:cinema_app/ui/on_boarding_screen/onboarding_screen1.dart';
import 'package:cinema_app/ui/on_boarding_screen/onboarding_screen2.dart';
import 'package:cinema_app/ui/on_boarding_screen/onboarding_screen3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OnboardingLayoutScreen extends StatefulWidget {
  const OnboardingLayoutScreen({super.key});

  @override
  State<OnboardingLayoutScreen> createState() => _OnboardingLayoutScreenState();
}

class _OnboardingLayoutScreenState extends State<OnboardingLayoutScreen> {
  final List<Widget> screens = const [
    OnboardingScreen1(),
    OnboardingScreen2(),
    OnboardingScreen3(),
  ];

  late final PageController _pageController;

   @override
  void initState() {
     super.initState();
      _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingChangeIndexCubit, OnboardingChangeIndexState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorsManager.blackColor,
          body: Column(
            spacing: 10,
            children: [
              _getPageView(),
              _getPageIndicatorAndFilledButton(state.index, context , state),
            ],
          ),
        );
      },
    );
  }

  Padding _getPageIndicatorAndFilledButton(int index, BuildContext context, OnboardingChangeIndexState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
      child: Row(
        children: [
          _getPageIndicator(index),
          Spacer(),
          _getFilledButton(context, state)
        ],
      ),
    );
  }

  Expanded _getPageView() {
    return Expanded(
      child: PageView.builder(
        controller: _pageController,
        itemCount: screens.length,
        itemBuilder: (context, index) => screens[index],
        scrollDirection: Axis.horizontal,
        onPageChanged: (index) {
          context.read<OnboardingChangeIndexCubit>().changeOnboardingPageIndex(index);
        },
      ),
    );
  }

  SizedBox _getFilledButton(BuildContext context , OnboardingChangeIndexState state) {
    return SizedBox(
      width: (state.index == 2 ) ? 140 :  60,
      height: 60,
      child: FilledButton(
        onPressed: () {
          if(context.read<OnboardingChangeIndexCubit>().state.index < 2){
            _pageController.nextPage(duration: Duration(milliseconds: 450), curve: Curves.easeInOut);
            context.read<OnboardingChangeIndexCubit>().changeOnboardingPageIndex(state.index + 1);
          }else{
            context.go(RoutesConstants.loginScreen);
          }
        },
        style: (state.index != 2) ? ThemeManager
            .getOnboardingFilledButtonStyle() : ThemeManager.getOnboardingFilledButtonStyle().copyWith(
            shape: WidgetStateProperty.resolveWith(
                (widgets) => RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
            )
        ),
        child: Center(child: (state.index == 2) ? Text("Get Started" , style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 14 , fontWeight: FontWeight.bold),) : Icon(Icons.arrow_forward_ios_outlined)),
      ),
    );
  }

  Widget _getPageIndicator(int activeIndex) {
    return Row(
      children: List.generate(3, (index) {
        bool isActive = (index == activeIndex);
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(right: 8),
          height: 8,
          width: (isActive) ? 24 : 8,
          decoration: BoxDecoration(
            color: (isActive)
                ? ColorsManager.primaryBlueAccentColor
                : ColorsManager.primaryBlueAccentColorLessOpacity,
            borderRadius: BorderRadius.circular(8),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
