import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_api/Controller/login_controller.dart';
import 'package:sample_api/Controller/product_controller.dart';
import 'package:sample_api/View/add_product.dart';
import 'package:sample_api/View/edit_product.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  ProductController productController = Get.put(ProductController());
  LoginController loginController = Get.put(LoginController());
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add, color: Colors.white),
            backgroundColor: Colors.deepPurple[800],
            onPressed: () {
              Get.to(AddProduct());
            }),
        appBar: AppBar(
          title: const Text("Home"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                loginController.logout();
              },
            ),
          ],
        ),
        body: Obx(() {
          if (productController.isLoading.isTrue) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: productController.products.length,
                itemBuilder: (context, index) {
                  final product = productController.products[index];

                  return Card(
                    color: Colors.white,
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              product.image ?? '',
                              fit: BoxFit.cover,
                              height: 80,
                              width: 80,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image, size: 80),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title ?? 'No Title',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "\$${product.price?.toStringAsFixed(2) ?? '0.00'}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Text(
                                  product.category ?? 'No Category',
                                  style: TextStyle(color: Colors.blue[600]),
                                ),
                                // const SizedBox(height: 10),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        print("Edit button pressed!!");
                                        Get.to(EditProduct(
                                          products: product,
                                        ));
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.green[300],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    IconButton(
                                        onPressed: () {
                                          print("Delete button pressed!!");
                                          productController
                                              .deleteProduct(product.id!);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red[300],
                                        )),
                                    
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        }));
  }
}
