import 'package:coupang_clone/Util/logger.dart';
import 'package:coupang_clone/View/slider_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MembershipPage extends StatefulWidget {
  const MembershipPage({Key? key}) : super(key: key);

  @override
  State<MembershipPage> createState() => _MembershipPageState();
}

enum Gender { MAN, WOMEN }

class _MembershipPageState extends State<MembershipPage> {
  //텍스트필트 빈 값을 저장할 변수
  String inputText = "";

  //특정 이벤트가 발생하였을 때, 현재 입력된 값에 접근하고 싶을 때도 있다. 이때 사용하는 것이 TextEditingController.
  TextEditingController textController = TextEditingController();

  // 텍스트를 받아오기 위한 선언
  final idController = TextEditingController();
  final pwController = TextEditingController();

  //자동로그인 토글
  bool _switchValue = true;
  final formKey = GlobalKey<FormState>();

  int _counter = 0;
  var _isChecked = false;

  Gender _gender = Gender.MAN;

  // 캐싱을 위한 선언
  String _id = '';
  String _pw = '';
  late SharedPreferences _prefs;

  // 위젯이 생성될 때 처음으로 호출되고, 단 한번만 호출된다.
  @override
  void initState() {
    super.initState(); // initState()를 사용할 때 반드시 사용해야 한다.
    _loadId();
  }

// 캐시에 있는 데이터를 불러오는 함수
  // 이 함수의 기능으로, 어플을 끄고 켜도 데이터가 유지된다.
  _loadId() async {
    _prefs = await SharedPreferences.getInstance(); // 캐시에 저장되어있는 값을 불러온다.
    setState(() {
      // 캐시에 저장된 값을 반영하여 현재 상태를 설정한다.
      // SharedPreferences에 id, pw로 저장된 값을 읽어 필드에 저장. 없을 경우 0으로 대입
      _id = (_prefs.getString('id') ?? '');
      _pw = (_prefs.getString('pw') ?? '');
      print(_id);
      print(_pw);
    });
  }

  //화면이 죽을 때 dispose돈다
  @override
  void dispose() {
    super.dispose();
    //상태바 다시 흰색으로.
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark));
  }


  @override
  Widget build(BuildContext context) {
    //상태바 색상 설정
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.amberAccent));
    return Form(
      key: this.formKey,
      child: Material(
        color: Color(0xffF5F5F5),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              //MediaQuery는 반응형(앱에 사이즈에 맞는 가로나,세로의 값을 가져온다.)
              //MediaQuery.of(context).size.height = 앱 디바이스의 높이
              height: MediaQuery.of(context).size.height,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Container(
                      height: 150.h - MediaQuery.of(context).padding.top,
                      width: 390.w,
                      alignment: Alignment.topCenter,
                      decoration: (const BoxDecoration(
                        color: Colors.amberAccent,
                      )),
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 32.h + MediaQuery.of(context).padding.top),
                        child: Row(
                          children: [
                            //큰차이점 = Inkwell은 터치시 이벤트 효과가 들어간다.
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context, "C");
                                },
                                //작은버튼일 때, 정확히 누르기 힘들기 때문에, behavior을 줘서 주변 마진만큼 범위 확장 시킨다.(translucent는 투명한 부분에,투명영역까지 범위) 반대로 오페큐는 딱 아이콘모양만 터치영역
                                behavior: HitTestBehavior.translucent,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 16.w, right: 24.77.w),
                                  child:
                                      Image.asset('assets/images/backkey.png'),
                                )),


                            Container(
                              // alignment: Alignment.center,
                              margin: EdgeInsets.only(left: 60.w),
                              child: Text(
                                "회원가입",
                                style: TextStyle(
                                    fontSize: 25.h,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 15.w, bottom: 20.w),
                            child: Text("아이디"),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 15.w),
                            height: 60.h,
                            width: 250.w,
                            child: TextFormField(
                              //autovalidateMode 는 FormField가 가지고 있는 속성을 상속받은 것인데, validator에 지정된 유효성 검사에서 반환된 에러 메시지를 자동으로 띄워주는 역할을 한다.
                              // (사실 validator만 설정하면 되는 줄 알고 엄청 헤맸는데, autovalidateMode의 기본값은 autovalidateMode.disabled였다...)
                              autovalidateMode: AutovalidateMode.always,
                              validator: (String? val) {
                                if(val!.length < 1) {
                                  return "아이디 필수";

                                }
                                if(val.length < 2) {
                                  return '아이디는 두 글자 이상 입력.';
                                }
                                return null;
                              },
                              scrollPadding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              textInputAction: TextInputAction.next,
                              textAlignVertical: TextAlignVertical.center,
                              controller: idController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[a-z0-9]'))
                              ],
                              decoration: InputDecoration(
                                hintText: "아이디를 입력하세요.",
                                hintStyle: TextStyle(
                                    fontSize: 15.w, color: Color(0xffA3A3A3)),
                                contentPadding: EdgeInsets.only(left: 10.w),
                                //테두리두께
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2.0)),
                                ),

                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffCBCBCB), width: 2.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),

                                //텍스트필드 선택시 포커스 라인
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffCBCBCB), width: 2.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                              ),
                              maxLines: 1,
                              minLines: 1,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15.w, bottom: 20.w),
                          child: Text("비밀번호"),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 15.w),
                          height: 60.h,
                          width: 250.w,
                          child: TextFormField(
                            onSaved: (String? val) {},
                            onChanged: (text) {
                              _pw = text;
                            },
                            autovalidateMode: AutovalidateMode.always,
                            validator: (String? val) {
                              if(val!.length < 1) {
                                return "비밀번호 필수";
                              }
                              if(val.length < 4) {
                                return '비밀번호는 네 글자 이상 입력.';
                              }
                              return null;
                            },
                            scrollPadding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            textInputAction: TextInputAction.next,
                            textAlignVertical: TextAlignVertical.center,
                            controller: pwController,
                            decoration: InputDecoration(
                              hintText: "비밀번호를 입력하세요.",
                              hintStyle: TextStyle(
                                  fontSize: 15.w, color: Color(0xffA3A3A3)),
                              contentPadding: EdgeInsets.only(left: 10.w),
                              //테두리두께
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2.0)),
                              ),

                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCBCBCB), width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),

                              //텍스트필드 선택시 포커스 라인
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCBCBCB), width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                            ),
                            maxLines: 1,
                            minLines: 1,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15.w, bottom: 20.w),
                          child: Text("비밀번호 확인"),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 15.w),
                          height: 60.h,
                          width: 250.w,
                          child: TextFormField(
                            onSaved: (String? val) {},
                            autovalidateMode: AutovalidateMode.always,
                            validator: (String? val) {
                              if(val != _pw) {
                                return "비밀번호는 같아야 합니다.";
                              } else {
                                return "확인완료";
                              }
                              return null;
                            },
                            scrollPadding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            textInputAction: TextInputAction.next,
                            textAlignVertical: TextAlignVertical.center,
                            controller: textController,
                            decoration: InputDecoration(
                              hintText: "비밀번호 확인.",
                              hintStyle: TextStyle(
                                  fontSize: 15.w, color: Color(0xffA3A3A3)),
                              contentPadding: EdgeInsets.only(left: 10.w),
                              //테두리두께
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2.0)),
                              ),

                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCBCBCB), width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),

                              //텍스트필드 선택시 포커스 라인
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCBCBCB), width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                            ),
                            maxLines: 1,
                            minLines: 1,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15.w),
                          child: Text("이 름"),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 15.w),
                          height: 50.h,
                          width: 250.w,
                          child: TextField(
                            scrollPadding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            textInputAction: TextInputAction.next,
                            textAlignVertical: TextAlignVertical.center,
                            // controller: textController,
                            // inputFormatters: [
                            //   FilteringTextInputFormatter.allow(
                            //       RegExp('[ㄱ-ㅎ가-힣]'))
                            // ],
                            decoration: InputDecoration(
                              hintText: "실명을 입력하세요.",
                              hintStyle: TextStyle(
                                  fontSize: 15.w, color: Color(0xffA3A3A3)),
                              contentPadding: EdgeInsets.only(left: 10.w),
                              //테두리두께
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2.0)),
                              ),

                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCBCBCB), width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),

                              //텍스트필드 선택시 포커스 라인
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCBCBCB), width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                            ),
                            maxLines: 1,
                            minLines: 1,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15.w),
                          child: Text("휴대폰 번호"),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 15.w),
                          height: 50.h,
                          width: 250.w,
                          child: TextFormField(
                            scrollPadding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            textInputAction: TextInputAction.next,
                            textAlignVertical: TextAlignVertical.center,
                            // controller: textController,
                            keyboardType: TextInputType.phone,

                            // inputFormatters: [
                            //   FilteringTextInputFormatter.allow(
                            //       RegExp(r'^([0-9]{3})-?([0-9]{4})-?([0-9]{4})$'))
                            // ],
                            //11자리 제한
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(11)
                            ],
                            decoration: InputDecoration(
                              hintText: " '-' 구분 없이 입력.",
                              hintStyle: TextStyle(
                                  fontSize: 15.w, color: Color(0xffA3A3A3)),
                              contentPadding: EdgeInsets.only(left: 10.w),
                              //테두리두께
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2.0)),
                              ),

                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCBCBCB), width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),

                              //텍스트필드 선택시 포커스 라인
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCBCBCB), width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                            ),
                            maxLines: 1,
                            minLines: 1,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15.w),
                          child: Text("E-MAIL"),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 15.w),
                          height: 50.h,
                          width: 250.w,
                          child: TextFormField(
                            onSaved: (String? val) {},
                            autovalidateMode: AutovalidateMode.always,
                            validator: (String? val) {
                              validateEmail(val);
                              // if(val == null || val.isEmpty) {
                              //   return "이메일을 입력해주세요";
                              // }
                              // return null;
                            },
                            scrollPadding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            textInputAction: TextInputAction.next,
                            textAlignVertical: TextAlignVertical.center,
                            // controller: textController,
                            // inputFormatters: [
                            //   FilteringTextInputFormatter.allow(
                            //       RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'))
                            // ],
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: " @ ",
                              hintStyle: TextStyle(
                                  fontSize: 15.w, color: Color(0xffA3A3A3)),
                              contentPadding: EdgeInsets.only(left: 10.w),
                              //테두리두께
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2.0)),
                              ),

                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCBCBCB), width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),

                              //텍스트필드 선택시 포커스 라인
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCBCBCB), width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                            ),
                            maxLines: 1,
                            minLines: 1,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15.w),
                          child: Text("성 별"),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 15.w),
                          height: 150.h,
                          width: 250.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              //오류의 원인은 마지막 onChanged의 value가 Object?의 형식인데 String형식인 _selectedValue에 넣은 것이다. 그러므로 다음의 두가지를 해결해주면 오류는 없어지게 된다.
                              // value가 Object가 아닌 String으로 만들기
                              // value가 null인지 아닌지 체크하기 (null safety)
                              RadioListTile (
                                  title: Text("남자"),
                                  value: Gender.MAN,
                                  groupValue: _gender,
                                  onChanged: (value) {
                                setState(() {
                                  _gender = value as Gender;
                                });
                              }),
                              RadioListTile (
                                  title: Text("여자"),
                                  value: Gender.WOMEN,
                                  groupValue: _gender,
                                  onChanged: (value) {
                                    setState(() {
                                      _gender = value as Gender;
                                    });
                                  }),

                              Text(
                                '아이디: $_id 비밀번호: $_pw',
                              ), // 어플을 재시작해도 데이터가 보존되는지 확인하기 위한 Text창
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Container(
              height: 70.h,
              color: Colors.blueAccent,
              child: ElevatedButton(
                child: Text(
                  "회 원 가 입 하 기",
                  style: TextStyle(
                      fontSize: 20.w,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent,
                ),
                //회원가입 설정
                onPressed: () {
                  _id = idController.text; // _id 에 입력받은 값 넣어줌
                  _pw = pwController.text; // _pw 에 입력받은 값 넣어줌
                  _prefs.setString(
                      'id', _id); // id를 키로 가지고 있는 값에 입력받은 _id를 넣어줌. = 캐시에 넣어줌

                  _prefs.setString(
                      'pw', _pw); // pw를 키로 가지고 있는 값에 입력받은 _pw를 넣어줌. = 캐시에 넣어줌
                  logger.d("id===== ${_id = idController.text}");
                  logger.d("pw===== ${_pw = pwController.text}");
                  showDialog(
                      // 버튼을 눌렀음을 확인시키기 위한 창 띄우기
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            content: Text(
                          '가입이 완료됐습니다.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ));
                      });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String? validateEmail(String? value) {
  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty || !regex.hasMatch(value))
    return 'Enter a valid email address';
  else
    return null;
}