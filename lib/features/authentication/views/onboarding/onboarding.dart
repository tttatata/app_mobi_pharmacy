import 'package:app_mobi_pharmacy/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:app_mobi_pharmacy/features/authentication/views/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:app_mobi_pharmacy/features/authentication/views/onboarding/widgets/onboarding_page.dart';
import 'package:app_mobi_pharmacy/features/authentication/views/onboarding/widgets/onboarding_skip.dart';
import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
import 'package:app_mobi_pharmacy/util/constans/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/onboarding_next_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    // checkFirstTime();
  }

  // Future<void> checkFirstTime() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final isFirstTime = prefs.getBool('isFirstTime') ?? true;

  //   if (isFirstTime) {
  //     // Hiển thị màn hình Onboarding
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => const OnboardingScreen()),
  //     );

  //     // Sau khi hiển thị xong, đánh dấu là đã xem màn hình Onboarding
  //     prefs.setBool('isFirstTime', false);
  //   } else {
  //     // Đã xem màn hình Onboarding trước đó, chuyển đến màn hình chính
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => const LoginScreen()),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
        body: Stack(
      children: [
        ///Horizontal Scrollable Pages
        PageView(
          controller: controller.pageController,
          onPageChanged: controller.updatePageIndicator,
          children: const [
            OnBoardingPage(
              image: TImages.onBoardingImage1,
              title: TTexts.onBoardingTitle1,
              subTitle: TTexts.onBoardingSubTitle1,
            ),
            OnBoardingPage(
              image: TImages.onBoardingImage2,
              title: TTexts.onBoardingTitle2,
              subTitle: TTexts.onBoardingSubTitle2,
            ),
            OnBoardingPage(
              image: TImages.onBoardingImage3,
              title: TTexts.onBoardingTitle3,
              subTitle: TTexts.onBoardingSubTitle3,
            ),
          ],
        ),

        ///Skip Button
        const OnBoardingSkip(),

        ///Dot Navigation SmoothPageIndicator
        const OnBoardingDotNavigation(),

        ///Circular Button
        const OnBoardingNextButton()
      ],
    ));
  }
}
