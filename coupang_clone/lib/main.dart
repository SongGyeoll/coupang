import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'View/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  //**화면 정방향 세로 고정**
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        //글자크기를 최소로 맞추겠다.
        minTextAdapt: true,
        //화면나누기 사용하겠다.
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
          title: 'FreshGo VM Location',
          routes: Routes.routes,
          //첫화면
          initialRoute: '/splash',
          onUnknownRoute: (RouteSettings settings) {
            return MaterialPageRoute(
              builder: (BuildContext context) => UnknownScreen(),
            );
          },
          //ThemeData 테마설정,제어(위젯에 대한 색상,글꼴,모양 등)
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          builder: (context, widget) {
            // ScreenUtil.registerToBuild(context);context
            // ScreenUtil.setContext(context);
            //MediaQueryData를 하위 항목에 제공하는 위젯을 만듭니다.
            return MediaQuery(data: MediaQuery.of(context), child: widget!);
          },
        ));
  }
}

class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Not Found!'),
      ),
      body: Center(
        child: Text('You seem to have been list'),
      ),
    );
  }
}
