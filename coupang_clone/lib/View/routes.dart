import 'package:coupang_clone/View/log_in_page.dart';
import 'package:coupang_clone/View/menu_page.dart';
import 'package:coupang_clone/View/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'coupang_home.dart';

//라우트(Route)란? 화면간 이동,
// Flutter 앱에서는 스크린이나 페이지를 라우트(Route)라고 부른다.
class Routes {
  Routes._();

  static String splash = '/splash';
  static String coupang = '/coupang';
  static String menu = '/menu';
  static String login = "/login";


  static final routes = <String, WidgetBuilder>{
    splash: (context) => SlpashScreen(),
    coupang: (context) => CoupangeHome(),
    menu: (context) => MenuPage(),
    login: (context) => LogInPage(),
  };
}
