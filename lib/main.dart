import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/instance_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sample_api/Controller/login_controller.dart';
import 'package:sample_api/View/home_page.dart';
import 'package:sample_api/View/login_page.dart';

void main() async{
  await GetStorage.init();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  
  final LoginController loginController = Get.put(LoginController());
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: loginController.isLoggedIn()?HomePage():LoginPage(),
    );
  }
}
