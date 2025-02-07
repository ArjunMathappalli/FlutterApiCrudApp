// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_api/Controller/product_controller.dart';
import 'package:sample_api/Model/product_model.dart';

// ignore: must_be_immutable
class EditProduct extends StatelessWidget {
  ProductModel products;

  EditProduct({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController discriptionController = TextEditingController();
    TextEditingController imageController = TextEditingController();
    TextEditingController categoryController = TextEditingController();
    ProductController productController = Get.put(ProductController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Product"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(hintText: products.title),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: priceController,
                decoration:
                    InputDecoration(hintText: products.price.toString()),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: discriptionController,
                decoration: InputDecoration(hintText: products.description),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: imageController,
                decoration: InputDecoration(hintText: products.image),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: categoryController,
                decoration: InputDecoration(hintText: products.category),
              ),
              SizedBox(
                height: 60,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.orange)),
                    onPressed: () {
                      final updatedProduct = ProductModel(
                        id: products.id,
                        title: titleController.text.isEmpty
                            ? products.title
                            : titleController.text,
                        price: priceController.text.isEmpty
                            ? products.price
                            : double.parse(priceController.text),
                        description: discriptionController.text.isEmpty
                            ? products.description
                            : discriptionController.text,
                        category: categoryController.text.isEmpty
                            ? products.category
                            : categoryController.text,
                        image: imageController.text.isEmpty
                            ? products.image
                            : imageController.text,
                      );

                      productController.updateProduct(updatedProduct);

                      Get.back();
                    },
                    child: const Text("Edit Product",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold))),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
