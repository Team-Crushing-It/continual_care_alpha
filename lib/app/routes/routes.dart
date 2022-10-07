import 'package:flutter/widgets.dart';
import 'package:continual_care_alpha/app/app.dart';
import 'package:continual_care_alpha/home/home.dart';
import 'package:continual_care_alpha/login/login.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [LoadingPage.page()];

    case AppStatus.initialized:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
