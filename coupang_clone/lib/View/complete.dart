import 'package:coupang_clone/Util/logger.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompletePage extends StatefulWidget {
  const CompletePage({Key? key}) : super(key: key);

  @override
  State<CompletePage> createState() => _CompletePageState();
}

class _CompletePageState extends State<CompletePage> {

  String loginId = '';
  String loginPw = '';

  // 위젯이 생성될 때 처음으로 호출되고, 단 한번만 호출된다.
  @override
  void initState() {
    super.initState(); // initState()를 사용할 때 반드시 사용해야 한다.
    _setData();
  }


  _setData() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      loginId = _prefs.getString('id')!;
      loginPw = _prefs.getString("pw")!;
      // * id,pw 최신 값을 SharedPreferences에 저장
      _prefs.setString('id', loginId);
      _prefs.setString('pw', loginPw);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("로그인 완료"),
      ),
      body: Text("아이디 : ${loginId}, 비밀번호 : ${loginPw}"),
    );
  }
}
