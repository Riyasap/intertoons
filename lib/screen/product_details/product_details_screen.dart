// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intertoons/core/constant/custom_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intertoons/screen/cart/cart_screen.dart';
import 'package:intertoons/screen/home/home_controller.dart';
import 'package:intertoons/screen/product_details/product_response_model.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  ProductDetailScreen({Key? key, required this.productResponseModel})
      : super(key: key);
  ProductResponseModel productResponseModel;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  ProductResponseModel? productResponseModel;
  bool offer = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          const Icon(Icons.search),
          const SizedBox(
            width: 6,
          ),
          InkWell(
            onTap: () => Get.to(() => const CartScreen()),
            child: Stack(
              children: [
                const Center(child: Icon(Icons.shopping_cart)),
                if (cartProducts.length != 0)
                  Positioned(
                      right: 0,
                      top: 28,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.green,
                        child:
                            Center(child: Text(cartProducts.length.toString())),
                      ))
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
        title: const Text("Product Details"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 400,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: productResponseModel?.image?.length ?? 1,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              height: 300,
                              width: MediaQuery.of(context).size.width,
                              child: Image.network(
                                widget.productResponseModel.image![index],
                                fit: BoxFit.fill,
                              ));
                        }),
                  ),
                  const Positioned(
                    child: Icon(
                      Icons.category_outlined,
                      size: 30,
                    ),
                    right: 25,
                    top: 25,
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 8, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.productResponseModel.name.toString(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(16)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 16,
                          ),
                          Text(
                            "3.4",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.productResponseModel.price.toString(),
                      style: const TextStyle(
                          color: CustomColors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.grey,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: const [
                          Text("color"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          MaterialButton(
            onPressed: () {
              bool isCarted = false;
              if (cartProducts.any(
                  (element) => element.id == widget.productResponseModel.id)) {
                isCarted = true;
              }
              if (isCarted) {
                int count = widget.productResponseModel.count?.toInt() ?? 0;
                count++;
                widget.productResponseModel.count = count;
              } else {
                widget.productResponseModel.count = 1;
                ref.read(productCartProvider).add(
                      widget.productResponseModel,
                    );
              }
              setState(() {});
            },
            minWidth: MediaQuery.of(context).size.width,
            color: CustomColors.red,
            height: 56,
            child: const Text(
              "Add to Cart",
              style: TextStyle(fontSize: 20),
            ),
          )
          //SizedBox(height: 6,),
        ],
      ),
    );
  }
}
