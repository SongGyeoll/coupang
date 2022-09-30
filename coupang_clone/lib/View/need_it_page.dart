import 'package:flutter/material.dart';

class NeedItPage extends StatefulWidget {
  const NeedItPage({Key? key}) : super(key: key);

  @override
  State<NeedItPage> createState() => _NeedItPageState();
}

class _NeedItPageState extends State<NeedItPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('지금 이 상품이 필요하신가요?'),
    );
  }
}
