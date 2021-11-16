import 'package:flutter/material.dart';
import 'package:intertoons/screen/home/home.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  int bottomSelectedIndex = 0;
  PageController pageController=PageController(initialPage: 0,);
  void pageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 79,
        child: BottomNavigationBar(backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined,
                  color: selectedIndex == 0
                      ? const Color(0xFFD42828)
                      : const Color(0xFFB0ADAD),
                ),
                title: Text("Home")),
            BottomNavigationBarItem(
                icon: Icon(Icons.search,
                  color: selectedIndex == 1
                      ? const Color(0xFFD42828)
                      : const Color(0xFFB0ADAD),
                ),
                title: Text("Search")),
            BottomNavigationBarItem(
                icon: Icon(Icons.category_outlined,semanticLabel: "Text",
                  color: selectedIndex == 2
                      ? const Color(0xFFD42828)
                      : const Color(0xFFB0ADAD),
                ),
                title:Text( 'Notification')),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined,
                  color: selectedIndex == 3
                      ? const Color(0xFFD42828)
                      : const Color(0xFFB0ADAD),
                ),title: Text("Cart"),
                ),
          ],
          currentIndex: selectedIndex,
          onTap:(index){
            bottomTapped(index);
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          elevation: 4,
        ),
      ),
      body: PageView(controller: pageController,physics: NeverScrollableScrollPhysics(),
          onPageChanged:  (index) {
            pageChanged(index);
          },
          children: const <Widget>[
            Home(),
            Center(child: Text("Search"),),
            Center(child: Text("Category"),),
            Center(child: Text("Cart"),),
          ]

      ),
    );
  }
}
