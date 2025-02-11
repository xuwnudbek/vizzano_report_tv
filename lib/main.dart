import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vizzano_report_tv/ui/splash/splash_page.dart';
import 'package:vizzano_report_tv/utils/theme/app_theme.dart';

void main() async {
  await GetStorage.init("groupMaster");
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Group Master',
      theme: AppTheme.lightTheme,
      home: SplashPage(),
    );
  }
}
