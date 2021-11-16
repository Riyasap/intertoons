import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intertoons/core/constant/custom_colors.dart';
import 'package:intertoons/screen/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intertoons/screen/home/home_model.dart';
import 'package:intertoons/screen/home/home_response_model.dart';
import 'package:intertoons/screen/product_details/product_details_screen.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  List<HomeModel> productList = [];
  List<HomeModel> bannerList = [];
  //HomeModel? homeModel;
  bool isLoading = true;
  bool offer = false;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ref.read(homeController.notifier).getHome();
      setState(() {});
    });
    super.initState();
    print("running");
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<HomeControllerState>(homeController, (previous, next) {
      if (next is HomeState) {
        print("Test");
        if (next.requestStatus == RequestStatus.success) {
          next.response?.forEach((element) {
            if (element.type == 'productlist') {
              print("product");
              if (element.data?.items?.length != 0) productList.add(element);
            } else if (element.type == 'banner') {
              bannerList.add(element);
              print("banner");
            }
          });
          setState(() {
            isLoading = false;
          });
        }

        print("else");
      }
    });
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.menu),
          title: const Text("Oman Phone"),
          centerTitle: true,
          actions: [
            Row(
              children: const [
                Icon(Icons.notifications),
                SizedBox(
                  width: 16,
                )
              ],
            )
          ],
          bottom: const SearchBar(),
        ),
        backgroundColor: Colors.grey,
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      height: 220,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: bannerList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            //height: 150,
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(
                              // productList.where((element) => element.type=='banner').first.data!.file.toString(),
                              bannerList[index].data!.file.toString(),
                              fit: BoxFit.fill,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: productList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, ind) {
                        // if(homeResponseModel?.type=="productlist"){

                        return Container(
                          margin: EdgeInsets.all(6),
                          padding: EdgeInsets.all(14),
                          color: Colors.white,
                          child: (productList[ind].data?.items != 0)
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          productList[ind].data?.title ?? "",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        MaterialButton(
                                          onPressed: () {},
                                          color: CustomColors.red,
                                          child: Text(
                                            "View all",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 16,
                                          // crossAxisSpacing: 13,
                                          crossAxisCount: 2,
                                          childAspectRatio: 3 / 4,
                                        ),
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: productList[ind]
                                            .data!
                                            .items!
                                            .length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              print(productList[index].type);
                                              print(productList.length);
                                              print(productList[ind]
                                                  .data!
                                                  .items!
                                                  .length);
                                              //Get.to(()=>ProductDetailScreen());
                                            },
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        Image.network(
                                                          "http://omanphone.smsoman.com/pub/media/catalog/product/" +
                                                              productList[ind]
                                                                  .data!
                                                                  .items![index]
                                                                  .image
                                                                  .toString(),
                                                          fit: BoxFit.fill,
                                                        ),

                                                      ],
                                                    ),
                                                    Text(
                                                      "${productList[ind].data?.items?[index].name}",
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                //SizedBox(height: 6,),
                                                Text(
                                                  "OMR " +
                                                      productList[ind]
                                                          .data!
                                                          .items![index]
                                                          .price
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: CustomColors.red,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          );
                                        })
                                  ],
                                )
                              : SizedBox(
                                  height: 1,
                                ),
                        );
                        // else{
                        //   return Container(child: Text("data"),);
                        // }
                      },
                    ),
                  ],
                ),
              ));
  }
}

class SearchBar extends StatefulWidget with PreferredSizeWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(68);
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: TextFormField(
          decoration: InputDecoration(
        counterText: "",
        prefixIcon: const Icon(Icons.search),
        hintText: "Search Products",
        hintStyle: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(color: Colors.grey, fontSize: 16),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(16)),
        labelStyle: const TextStyle(fontSize: 30),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.white),
        ),
      )),
    );
  }
}
