import 'package:flutter/material.dart';

class LoginMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("로그인 완료"),
      ),
      body: Text("아이디 : ID, 비밀번호 : PW"),
    );
  }
}