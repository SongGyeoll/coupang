import 'package:coupang_clone/Models/icon_item.dart';
import 'package:coupang_clone/View/banner_page.dart';
import 'package:coupang_clone/View/logo_page.dart';
import 'package:coupang_clone/View/routes.dart';
import 'package:coupang_clone/View/slider_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'dont_miss_page.dart';
import 'menu_page.dart';


class CoupangeHome extends StatefulWidget {
  @override
  _CoupangeHomeState createState() => _CoupangeHomeState();
}

class _CoupangeHomeState extends State<CoupangeHome> {
  // 상태위젯 상태변수로 선언
  DateTime? currentBackPressTime;

  //텍스트필트 빈 값을 저장할 변수
  String inputText = "";
  TextEditingController textController = TextEditingController();

  //바텀네비게이션 초기화 변수(SliderPage로 첫 화면 설정)
  int _selectedIndex = 2;
  List<Widget> _widgetOptions = [
    MenuPage(),
    Container(child: Text("INDEX ::: 1"),),
    SliderPage(),
    Container(child: Text("INDEX ::: 3"),),
    Container(child: Text("INDEX ::: 4"),),
  ];

  //바텀네비게이션 _onItemTapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int currentPos = 0;

  @override
  Widget build(BuildContext context) {
    //상태바 색상변경
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      //바텀네비게이션
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.lightBlue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.add_shopping_cart_rounded), label: ""),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        //클릭시 효과 없애기
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}