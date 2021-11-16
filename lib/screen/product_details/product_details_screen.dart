import 'package:flutter/material.dart';
import 'package:intertoons/core/constant/custom_colors.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool offer=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
    title: const Text("Product Details"),
    centerTitle: true,

      ),
          body:  Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network("http://omanphone.smsoman.com/pub/media/catalog/product//h/t/htc_desire_320.jpg",fit: BoxFit.fill,),
                Positioned(child: Icon(Icons.category_outlined,size: 30,),
                right: 25,
                  top: 25,
                )
              ],
            ),
            Container(padding: const EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Htc",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(16)),
                    padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                    
                    child: Row(mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star,color: Colors.white,size: 16,),
                        Text("3.4",style:TextStyle(color:Colors.white,fontSize: 16,fontWeight: FontWeight.bold) ,),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  !offer
                      ?Row(
                   //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Htc",style: TextStyle(color: CustomColors.red,fontSize: 20,fontWeight: FontWeight.bold),),
                      SizedBox(width:14,),
                      Text("100.22",style: TextStyle(fontSize: 17,color: Colors.grey,
                          decoration: TextDecoration.lineThrough,decorationColor: Colors.grey,decorationThickness: 2),),
                    ],)
                      :Text("Htc",style: TextStyle(color: CustomColors.red,fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.all(16),
                    color: Colors.grey,
                    width: MediaQuery.of(context).size.width,
                    child: Text("SASA"),
                  )
                ],
              ),
            ),
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
  }
}
