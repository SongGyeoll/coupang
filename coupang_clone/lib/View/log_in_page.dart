import 'package:coupang_clone/View/membership_page.dart';
import 'package:coupang_clone/View/slider_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {

  String _id = '';
  String _pw = '';
  late SharedPreferences _prefs;

  //텍스트필트 빈 값을 저장할 변수
  String inputText = "";
  //특정 이벤트가 발생하였을 때, 현재 입력된 값에 접근하고 싶을 때도 있다. 이때 사용하는 것이 TextEditingController.
  TextEditingController idtextController = TextEditingController();
  TextEditingController pwtextController = TextEditingController();

  //자동로그인 토글
  bool _switchValue = true;

  final formKey = GlobalKey<FormState>();





  @override
  Widget build(BuildContext context) {
    return Form(
      key: this.formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
          body: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 150.h),
                    child: Text("쿠팡 로그인 화면",
                    style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 100.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.email,
                            size: 40.h
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.w),
                              height: 50.h,
                              width: 250.w,
                              child: TextField(
                                scrollPadding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).viewInsets.bottom
                                ),
                              onSubmitted: (text) {

                              },
                              textInputAction: TextInputAction.next,
                              textAlignVertical: TextAlignVertical.center,
                              controller: idtextController,
                              inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-z0-9]'))],
                              keyboardType: TextInputType.emailAddress,

                              decoration: InputDecoration(
                                hintText: "아이디를 입력하세요.",
                                hintStyle: TextStyle(fontSize: 15.w, color: Color(0xffA3A3A3)),
                                contentPadding: EdgeInsets.only(left: 10.w),
                                //테두리두께
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                ),

                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffCBCBCB), width: 2.0),
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                ),

                                //텍스트필드 선택시 포커스 라인
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffCBCBCB), width: 2.0),
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                ),
                              ),
                              maxLines: 1,
                              minLines: 1,
                            ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 20.h,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.lock,
                            size: 40.h
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.w),
                              height: 50.h,
                              width: 250.w,
                              child: TextField(
                                scrollPadding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).viewInsets.bottom
                                ),
                                textInputAction: TextInputAction.go,
                                textAlignVertical: TextAlignVertical.center,
                                controller: pwtextController,
                                //문자입력 *처리
                                obscureText: true,
                                keyboardType: TextInputType.emailAddress,

                                decoration: InputDecoration(
                                  hintText: "비밀번호를 입력하세요.",
                                  hintStyle: TextStyle(fontSize: 15.w, color: Color(0xffA3A3A3)),
                                  contentPadding: EdgeInsets.only(left: 10.w),
                                  //테두리두께
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                  ),

                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xffCBCBCB), width: 2.0),
                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  ),

                                  //텍스트필드 선택시 포커스 라인
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xffCBCBCB), width: 2.0),
                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                ),
                                maxLines: 1,
                                minLines: 1,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 100.h,
                        ),

                        Container(
                          height: 50.h,
                          width: MediaQuery.of(context).size.width,
                          // color: Colors.amber,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("자동",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,),
                              ),
                              CupertinoSwitch(value: _switchValue, onChanged: (value) {
                                setState(() {
                                  _switchValue = value;
                                });
                              }),
                              ElevatedButton(
                                child: Text(
                                  "로 그 인",
                                  style: TextStyle(
                                      fontSize: 20.w,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blueAccent,
                                ),
                                //로그인화면 전환
                                onPressed: () {
                                  setState(() {
                                    inputText = idtextController.text.trim();
                                    inputText = pwtextController.text.trim();
                                  });
                                  if (inputText.isEmpty) {
                                    emptyTextDialog(context);
                                  } else {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) => MembershipPage()));
                                    //Navigator.pop(context);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

        bottomNavigationBar: BottomAppBar (
          child: Container(
              height: 70.h,
              color: Colors.blueAccent,
             child: ElevatedButton(
              child: Text(
                "회 원 가 입",
                style: TextStyle(
                    fontSize: 20.w,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
              ),
              //회원가입 화면 전환
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => MembershipPage()));
                //Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    );
  }

  //빈텍스트 다이얼로그
  void emptyTextDialog(BuildContext context) {
    showDialog(
        context: context,
        //Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext bcontext) {
          return AlertDialog(
            //Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Column(
              children: <Widget>[
                Text(
                  "아이디 또는 비밀번호를 입력해 주세요.",
                  style: TextStyle(
                      fontFamily: 'BMFont',
                      fontSize: 20.w,
                      color: Color(0xff333333)),
                ),
              ],
            ),
            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "아이디 또는 비밀번호를 입력해주세요.",
                  style: TextStyle(
                      fontFamily: 'BMFont',
                      fontSize: 15.w,
                      color: Color(0xff333333)),
                ),
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text(
                  "확 인",
                  style: TextStyle(
                      fontFamily: 'NMFont',
                      fontSize: 15.w,
                      color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.amberAccent,
                ),
                //다이얼로그종료
                onPressed: () {
                  Navigator.of(context).pop();
                  //Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }



}
