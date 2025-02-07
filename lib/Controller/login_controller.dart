import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sample_api/Services/api_services.dart';
import 'package:sample_api/View/home_page.dart';
import 'package:sample_api/View/login_page.dart';

class LoginController {
  final ApiServices apiServices = ApiServices();
  var isLoading = false.obs;
  var token = "".obs;
  var errorMessage = "".obs;
  GetStorage storage = GetStorage();

  Future<void>? login(String username, String password) async {
    try {
      isLoading = true.obs;
      final userToken = await apiServices.loginService(username, password);
      token.value = userToken.toString();
      storage.write('token', userToken);
      print("Token exists----:---- ${storage.read('token')}");
      isLoading = false.obs;
      Get.snackbar("Success", "Login Successful", colorText: Colors.green);
      Get.to(HomePage());
    } catch (e) {
      isLoading = false.obs;
      errorMessage.value = e.toString();
      Get.snackbar("Failed", "Login Failed", colorText: Colors.red);
    }
  }

  bool isLoggedIn() {
    return storage.hasData('token');
  }

  void logout() {
    storage.remove('token');
    token.value = "";
    Get.offAll(LoginPage());
  }
}
