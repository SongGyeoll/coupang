import 'dart:async';
import 'package:coupang_clone/View/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




class SlpashScreen extends StatefulWidget {
  @override
  _SlpashScreenState createState() => _SlpashScreenState();

}

class _SlpashScreenState extends State<SlpashScreen> {

  @override
  void initState(){
    startTimer();
  }



  //Timer_3초 후 navigate실행
  startTimer() {
    var _duration = Duration(milliseconds: 1500);
    return Timer(_duration, navigate);
  }

  //navegate_화면전환
  navigate() async {
    //pushReplacementNamed pushRelacementNamed 메서드는 현재 페이지가 대체
    Navigator.of(context).pushReplacementNamed(Routes.coupang);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
          //Scaffold 프로퍼티 확인
          backgroundColor: Colors.white,
          //가운데정렬
          body: Center(
            child: Column(
              //중앙정렬
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    child: Image.asset('assets/images/logo.png', width: ScreenUtil().setWidth(199.32.h), height: 199.32.w,)),
              ],
            ),
          ),
        ));
  }
}
