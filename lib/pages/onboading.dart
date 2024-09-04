import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:onboading/pages/home.dart';

class OnboadingPage extends StatefulWidget {
  const OnboadingPage({super.key});

  @override
  State<OnboadingPage> createState() => _OnboadingPageState();
}

class _OnboadingPageState extends State<OnboadingPage> {
  int currentPage = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              children: [
                PageViewItem(
                  buttonTitle: 'Next',
                  onTap: () {
                    pageController.animateToPage(
                      currentPage + 1,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeIn,
                    );
                  },
                ),
                PageViewItem(
                  buttonTitle: 'Next',
                  onTap: () {
                    pageController.animateToPage(
                      currentPage + 1,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeIn,
                    );
                  },
                ),
                PageViewItem(
                  buttonTitle: 'Finish',
                  onTap: () {
                    // set boarding to true
                    GetStorage().write('onboarding', true);

                    // goto home page
                    Get.offAll(() => const HomePage());
                  },
                ),
              ],
            ),
          ),

          // indicator
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                3,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Icon(
                      Icons.circle,
                      color: (currentPage == index)
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.inversePrimary,
                      size: (currentPage == index) ? 12 : 8,
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PageViewItem extends StatelessWidget {
  const PageViewItem({super.key, required this.onTap, this.buttonTitle});

  final VoidCallback onTap;
  final String? buttonTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        UnDraw(
          color: Theme.of(context).colorScheme.primary,
          illustration: UnDrawIllustration.business_man,
          width: Get.width * 0.8,
        ),
        const Spacer(),
        (buttonTitle != null)
            ? OutlinedButton(
                onPressed: () => onTap(),
                child: Text('$buttonTitle'),
              )
            : Container(),
      ],
    );
  }
}
