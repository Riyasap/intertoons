
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
  List<HomeModel> productList=[];
  //HomeModel? homeModel;
  bool isLoading = false;
  bool offer =false;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ref.read(homeController.notifier).getHome();
      setState(() {

      });
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
          setState(() {
            print("Test");
            isLoading=true;
          });
          print("succes1");
          print(next.response);
          //homeModel = next.response;
          //print("tstttt ${homeModel[1].data.title}");
          isLoading=false;
          //productList = List.generate(2., (index) => null)
          //productList = List.generate(productList.length, (index) => next.response![index]);
          // :List.generate(productList.length, (index) => productList![index]);
          print("Success");
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
       body:
       isLoading
      ?CircularProgressIndicator()


       :SingleChildScrollView(
         physics: AlwaysScrollableScrollPhysics(),
        child:  Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Image.network("https://omanphone.smsoman.com/mobile-admin/uploads/image_614ada079781e.jpg",fit: BoxFit.fill,),
            ),
            SizedBox(height: 6,),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 2,
              shrinkWrap: true,
              itemBuilder: (context,index)
            {
                // if(homeResponseModel?.type=="productlist"){
                  return Container(
                margin: EdgeInsets.all(6),
                padding: EdgeInsets.all(14),
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(productList[index].data?.title ?? "",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        MaterialButton(onPressed: (){},
                          color: CustomColors.red,
                          child: Text("View all",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        )
                      ],
                    ),
                    SizedBox(height: 8,),
                    GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(mainAxisSpacing: 16,
                     // crossAxisSpacing: 13,
                      crossAxisCount: 2,
                      childAspectRatio: 3/4,
                    ),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                            return InkWell(
                              onTap: (){
                                print(productList[index].type);
                                //Get.to(()=>ProductDetailScreen());
                                },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Image.network("http://omanphone.smsoman.com/pub/media/catalog/product//h/t/htc_desire_320.jpg",fit: BoxFit.fill,),
                                    Text("Htc",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                  ],
                                ),
                                //SizedBox(height: 6,),
                                !offer
                                    ?Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  Text("Htc",style: TextStyle(color: CustomColors.red,fontSize: 20,fontWeight: FontWeight.bold),),
                                  SizedBox(width: 4,),
                                  Text("100.22",style: TextStyle(fontSize: 17,color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,decorationColor: Colors.grey,decorationThickness: 2),),
                                ],)
                                    :Text("Htc",style: TextStyle(color: CustomColors.red,fontSize: 20,fontWeight: FontWeight.bold),)

                              ],
                              ),
                            );
                        })
                  ],
                ),
              );
                // else{
                //   return Container(child: Text("data"),);
                // }
            },
            ),
          ],
        ),
      )
    );
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
