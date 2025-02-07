import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_api/Controller/product_controller.dart';
import 'package:sample_api/Model/product_model.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController discriptionController = TextEditingController();
    TextEditingController imageController = TextEditingController();
    TextEditingController categoryController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    ProductController productController = Get.put(ProductController());


    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: "Title"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Discription is required.";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: priceController,
                  decoration: const InputDecoration(labelText: "Price"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter a valid price.";
                    }
                    if (double.tryParse(value) == null) {
                      return "Enter a valid price.";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: discriptionController,
                  decoration: const InputDecoration(labelText: "Discription"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Discription is required.";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: imageController,
                  decoration: const InputDecoration(labelText: "Image"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Valid Image is required.";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: categoryController,
                  decoration: const InputDecoration(labelText: "Category"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Category is required.";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 60,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                      onPressed: () {
                        print("button clikced");
                        if (formKey.currentState!.validate()) {
                          final newProduct = ProductModel(
                            title: titleController.text,
                            price: double.parse(priceController.text),
                            description: discriptionController.text,
                            category: categoryController.text,
                            image: imageController.text,
                          );
                          productController.addProduct(newProduct);
                        
                          Get.back();
                        }
                      },
                      child: const Text("Add Product",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold))),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
