import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todo_list_app/presentation/resources/color_manager.dart';
import 'package:todo_list_app/presentation/resources/routes_manager.dart';
import 'package:todo_list_app/presentation/resources/styles_manager.dart';
import 'package:todo_list_app/presentation/resources/values_manager.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);
  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  List images = ['todoimg_1.jpg', 'todoimg2.jpg', 'todo_3.jpg'];
  List titles = ['Your Ultimate', 'Todo', 'List'];
  List subtitles = ['Welcome', 'to Your Ultimate', 'Ultimate To-Do List App!'];

  List descriptions = [
"Stay organized and achieve your goals with ease." 
"Our app helps you manage tasks", "set priorities, and track your progress effortlessly.",
"Whether it's daily errands or long-term projects, streamline your schedule and boost productivity.",
"Get started and take control of your to-do list today!"
];
  int _currentPage = 0;
  late Timer _timer;
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  
  @override
void initState() {
  super.initState();
  _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
    if (_currentPage < 2) {
      _currentPage++;
    } else {
      _currentPage = 0;
    }
    _pageController.animateToPage(
      _currentPage,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeIn,
    );
  });
}

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/" + images[index]),
                        fit: BoxFit.cover)),
                child: Container(
                  margin: const EdgeInsets.fromLTRB(20, 150, 20, 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppLargeText(text: titles[index]),
                            AppText(text: subtitles[index]),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              width: AppSizes.getWidth(context)*3/5,
                              child: AppText(
                                text:
                                    descriptions[index],
                                color: ColorManager.bigTextColor,
                                size: 14,
                              ),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(context, Routes.homeRoute);
                              },
                              child: SizedBox(
                                width: 200,
                                child: Row (
                                  children : [ 
                                    ResponsiveButton(text:"Skip", width: AppSizes.getWidth(context)*2/5,)
                                  ]
                                )
                              ),
                            )
                          ],
                        ),
                        Column(
                            children: List.generate(3, (indexDots) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 2),
                            width: 8,
                            height: index == indexDots ? 25 : 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: index == indexDots
                                  ? ColorManager.mainColor
                                  : ColorManager.mainColor.withOpacity(0.3),
                            ),
                          );
                        })),
                      ]),
                ),
              );
            }));
  }
}
