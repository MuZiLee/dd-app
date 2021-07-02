import 'package:demo2020/Controller/TabBar/Home/Shop/Addres/AddressManagerViewController.dart';
import 'package:demo2020/Controller/TabBar/Home/Shop/ShopCartViewController.dart';
import 'package:demo2020/Controller/TabBar/Home/Shop/ShopCategoryViewController.dart';
import 'package:demo2020/Controller/TabBar/Home/Shop/ShopHomeViewController.dart';
import 'package:demo2020/Provider/AddresManager.dart';
import 'package:demo2020/Views/Bases/BaseScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';

/**
 * 商城
 */
class ShopViewController extends StatefulWidget {
  @override
  _ShopViewControllerState createState() => _ShopViewControllerState();
}

class _ShopViewControllerState extends State<ShopViewController> {
  List _viewControllers = [];
  List<BottomNavigationBarItem> _items = [];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await AddresManager.getAddreslist();
          routePush(ShopCartViewController());
        },
        tooltip: '购物车',
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepOrangeAccent,
        child: Icon(Icons.shopping_cart),
      ),
      appBar: AppBar(
        title:
            Text("购物商城", style: TextStyle(color: Colors.black, fontSize: 17)),
        backgroundColor: Colors.white,
        centerTitle: true,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
        textTheme: TextTheme(
          title: TextStyle(color: Colors.black),
          subtitle: TextStyle(color: Colors.black38),
        ),
      ),
      body: _viewControllers[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 8.0,
        backgroundColor: Colors.white,
        items: _items,
        onTap: (value) async {
          setState(() {
            _currentIndex = value;
          });
        },
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.grey,
        unselectedIconTheme: IconThemeData(
          color: Colors.grey,
        ),
        fixedColor: Colors.deepOrange,
        iconSize: 21,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  _init() {
    ShopHomeViewController home = new ShopHomeViewController();
    ShopCategoryViewController category = new ShopCategoryViewController();


    _viewControllers.add(home);
    _viewControllers.add(category);


    BottomNavigationBarItem homeItem =
        new BottomNavigationBarItem(icon: Icon(Icons.shop), title: Text("商城"));
    BottomNavigationBarItem chatItem = new BottomNavigationBarItem(
        icon: Icon(Icons.category), title: Text("类别"));


    _items.add(homeItem);
    _items.add(chatItem);

  }
}
