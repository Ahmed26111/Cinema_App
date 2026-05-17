import 'package:cinema_app/constants/color%20constants/colors_manager.dart';
import 'package:cinema_app/ui/core/theme/theme_manager.dart';
import 'package:cinema_app/ui/on_boarding_screen/onboarding_change_index_cubit.dart';
import 'package:cinema_app/ui/on_boarding_screen/onboarding_screen1.dart';
import 'package:cinema_app/ui/on_boarding_screen/onboarding_screen2.dart';
import 'package:cinema_app/ui/on_boarding_screen/onboarding_screen3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingLayoutScreen extends StatelessWidget {
  const OnboardingLayoutScreen({super.key});

  final List<Widget> screens = const [
    OnboardingScreen1(),
    OnboardingScreen2(),
    OnboardingScreen3(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingChangeIndexCubit, OnboardingChangeIndexState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorsManager.blackColor,
          body: Column(
            spacing: 10,
            children: [
              _getAnimatedIndexedStack(state.index),
              _getPageIndicatorAndFilledButton(state.index, context),
            ],
          ),
        );
      },
    );
  }

  Padding _getPageIndicatorAndFilledButton(int index, BuildContext context) {
    return Padding(
              padding: const EdgeInsets.symmetric(vertical: 30 , horizontal: 15),
              child: Row(
                children: [
                  _getPageIndicator(index),
                  Spacer(),
                  _getFilledButton(context)
                ],
              ),
            );
  }

  Expanded _getAnimatedIndexedStack(int index) {
    return Expanded(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 350),
                transitionBuilder: (Widget child, Animation<double> animation) {
                    final slideAnimation = Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOut,
                    ));

                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: slideAnimation,
                        child: child,
                      ),
                    );
                },
                child: IndexedStack(
                  key: ValueKey<int>(index),
                  index: index,
                  children: screens,
                ),
              ),
            );
  }

  SizedBox _getFilledButton(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: FilledButton(
        onPressed: () {
          // Todo
          // if(context.read<OnboardingChangeIndexCubit>().state.index < 2){
          //   context.read<OnboardingChangeIndexCubit>().changeOnboardingPageIndex();
          // }else{
          //   /// Navigation to sign up screen
          // }
          context.read<OnboardingChangeIndexCubit>().changeOnboardingPageIndex();
        },
        style: ThemeManager.getOnboardingFilledButtonStyle(),
        child: Center(child: Icon(Icons.arrow_forward_ios_outlined)),
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
}
