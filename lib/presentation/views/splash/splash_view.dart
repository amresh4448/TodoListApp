
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app/app/app_pref.dart';
import 'package:todo_list_app/presentation/views/splash/widgets/logo.dart';
import 'package:todo_list_app/presentation/resources/assets_manager.dart';
import 'package:todo_list_app/presentation/resources/color_manager.dart';
import 'package:todo_list_app/presentation/resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late Timer _timer;
  late AppPreferences _appPreferences;
  


  _startDelay() {
    _timer = Timer(Duration(seconds: 8), _goNext);
  }

  _goNext() {
    _appPreferences = AppPreferences(context.read<SharedPreferences>());
    _appPreferences
    .getOnboardingStatus()
    .then((isOnboardingScreenViewed) {
      if(isOnboardingScreenViewed){
        Navigator.pushReplacementNamed(context, Routes.loginRoute);
      }
      else {
        Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.mainColor,
      body: SizedBox(
        child: Center(
          child: AnimatedLogo()
        ),
      ),
    );

  }
}