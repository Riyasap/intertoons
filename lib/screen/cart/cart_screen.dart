// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intertoons/core/constant/custom_colors.dart';
import 'package:intertoons/screen/home/home_controller.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            const SizedBox(
              width: 25,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Total"),
                Text(
                  "OMR ${cartProducts.fold<double>(0, (previousValue, element) => previousValue + ((element.price?.toDouble() ?? 0.0) * (element.count?.toInt() ?? 1))).toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                )
              ],
            ),
            const Spacer(),
            MaterialButton(
              onPressed: () {
                Get.snackbar("Message", "Checkout Successfully");
                ref.read(productCartProvider).clear();
                ref.watch(productCartProvider);
                setState(() {

                });
              },
              child: const Text("CHECKOUT"),
              color: CustomColors.red,
              minWidth: 140,
            ),
            const SizedBox(
              width: 25,
            )
          ],
        ),
        color: Colors.grey.shade400,
        width: MediaQuery.of(context).size.width,
        height: 60,
      ),
      appBar: AppBar(
        backgroundColor: CustomColors.red,
        title: Text("My Cart (${cartProducts.length})"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: cartProducts.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(6),
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 12,
                  )
                ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Text(cartProducts[index].name.toString(),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                            height: 170,
                            width: 170,
                            child: Image.network(
                              cartProducts[index].image!.first,
                              fit: BoxFit.fill,
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "OMR ${cartProducts[index].price.toString()}",
                              style: const TextStyle(
                                  color: CustomColors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              ref
                                  .read(productCartProvider)
                                  .remove(cartProducts[index]);
                              ref.watch(productCartProvider);
                              setState(() {});
                            },
                            icon: const Icon(Icons.delete_outline_outlined)),
                        const SizedBox(
                          width: 30,
                        ),
                        Container(
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    int count = cartProducts[index].count!;
                                    if (count > 1) {
                                      count--;
                                      cartProducts[index].count = count;
                                    }
                                  });
                                },
                                child: Container(
                                  width: 25,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey[500]),
                                  child: const Center(
                                      child: Text(
                                    "-",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                  )),
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(cartProducts[index].count.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              const SizedBox(
                                width: 6,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    int count =
                                        cartProducts[index].count!.toInt();
                                    count++;
                                    cartProducts[index].count = count;
                                  });
                                },
                                child: Container(
                                  width: 25,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey[500]),
                                  child: const Center(
                                      child: Text(
                                    "+",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 25),
                                  )),
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }
}
