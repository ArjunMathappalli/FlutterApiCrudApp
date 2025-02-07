import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_api/Model/product_model.dart';
import 'package:sample_api/Services/api_services.dart';

class ProductController extends GetxController {
  final ApiServices apiServices = ApiServices();
  var products = <ProductModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = "".obs;

  void getProducts() async {
    try {
      isLoading.value = true;
      var productList = await apiServices.getServices();
      if (productList != null) {
        products.value = productList;
        isLoading.value = false;
      } else {
        isLoading.value = false;
        errorMessage.value = "No Product found";
      }
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = "Falied to Load $e";
      print(e);
    }
  }

  void deleteProduct(int id) async {
    try {
      bool isDeleted = await apiServices.deleteService(id);
      if (isDeleted) {
        products.removeWhere((element) => element.id == id);
        print("Product Deleted!!!");
        Get.snackbar(
          "Deleted",
          "Product Deleted!!!",
          snackPosition: SnackPosition.TOP,
          colorText: Colors.red,
        );
      }
    } catch (e) {
      print(e);
      errorMessage.value = "Failed to delete $e";
    }
  }

  void addProduct(ProductModel product) async {
    try {
      bool isAdded = await apiServices.postService(product);
      if (isAdded) {
        print("Product Added!!!");
        Get.snackbar(
          "Success",
          "Product Added!!!",
          backgroundColor: Colors.white,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.green,
        );
      }
    } catch (e) {
      print(e);
      errorMessage.value = "Failed to add $e";
    }
  }

  void updateProduct(ProductModel product) async {
    try {
      bool isUpdated = await apiServices.updateService(product);
      if (isUpdated) {
        print("Product Updated!!!");
        Get.snackbar(
          "Success",
          "Product Updated!!!",
          backgroundColor: Colors.white,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.yellow,
        );
      }
    } catch (e) {
      print(e);
      errorMessage.value = "Failed to update $e";
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProducts();
  }
}
