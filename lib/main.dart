import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_manager_poc/modules/home/home_bindings.dart';
import 'package:state_manager_poc/modules/home/view/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      getPages: [
        GetPage(
          name: '/home',
          page: () => HomePage(stateManager: Get.find()),
          binding: HomeBindings(),
        ),
      ],
    );
  }
}
