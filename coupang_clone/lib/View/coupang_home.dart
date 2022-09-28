
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_indicator/carousel_indicator.dart';

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

  //바텀네비게이션 초기화 변수
  int _selectedIndex = 0;

  //바텀네비게이션 _onItemTapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //메인슬라이더 아이템
  final items = [
    Image.asset("assets/images/noodle.jpg"),
    Image.asset("assets/images/bag.jpg"),
  ];


  @override
  Widget build(BuildContext context) {
    //상태바 색상변경
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
          return <Widget>[
            createLogo(),
            onTextField(),
            _mainSlider(),
            _iconSlider(context),
            _bannerImage(context),
            _specialProd(context),
            // mainIcon(context),
          ];
        },
        body:
        _prodBannerText(context),

      ),

      //바텀네비게이션
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.lightBlue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: "",
            // backgroundColor: Colors.grey
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.add_shopping_cart_rounded), label: ""),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

//로고
SliverAppBar createLogo() {
  return SliverAppBar(
    backgroundColor: Colors.white,
    expandedHeight: 30.h,
    floating: false,
    elevation: 0,
toolbarHeight: 70.h,
    flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Container(
          color: Colors.white,
          padding: EdgeInsetsDirectional.only(top: 40.h,bottom: 1.h),
          alignment: Alignment.topCenter,
          child: Image.asset(
            'assets/images/logo.png',
          ),
        ),
      );
    }),
  );
}

//텍스트필드
SliverAppBar onTextField() {
  return SliverAppBar(
    backgroundColor: Colors.white,
    pinned: false,
    toolbarHeight: 50.h,
    flexibleSpace: FlexibleSpaceBar(

    ),
    title: Container(
      // alignment: Alignment.topCenter,
      height: 50.h,
      child: TextField(
        textInputAction: TextInputAction.search,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: "쿠팡에서 검색하세요!",
          prefixIcon: Icon(Icons.search, color: Colors.grey, size: 15.w),

          hintStyle: TextStyle(fontSize: 15.w, color: Color(0xffA3A3A3)),
          contentPadding:
              EdgeInsets.only(left: 10.w),
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
  );
}

//메인슬라이더
SliverAppBar _mainSlider() {
  return SliverAppBar(
    // expandedHeight: 100,
    //transparent 배경투명
    backgroundColor: Colors.transparent,
    //SliverAppBar의 높이 설정
    toolbarHeight: 170.h,
    // collapsedHeight: 150,
    //SliverAppBar 영역을 고정시킨다. default false
    pinned: false,
    // AppBar가 하단 List 내렸을 때 바로 보여야 한다 -> true
    // List를 최상단으로 올렸을 때만 나와야 한다. -> false
    floating: true,
  //   flexibleSpace: FlexibleSpaceBar(
  //     titlePadding: EdgeInsetsDirectional.only(
  //     top: 5,
  //     bottom: 1,
  //     start: 5,
  //     end: 0,
  // ),

    title: Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            // height: 150.h,
            autoPlay: true,
          ),

          items: [1, 2, 3, 4, 5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 170.h,
                      margin: EdgeInsets.symmetric(horizontal: 2.0),
                      child: SizedBox(
                        // height: 50,
                        // width: 100,
                        child: Image.asset(
                          "assets/images/noodle.jpg",
                          fit: BoxFit.fill,
                          // '메인슬라이더 $i',
                        ),
                      ),
                    ),
                    //메인슬라이더 인디케이터 사이 여백
                    SizedBox(
                      height: 5,
                    ),
                    //인디케이터
                    CarouselIndicator(
                      count: i,
                      index: [i].length,
                      color: Colors.black,
                    ),
                  ],
                );
              },
            );
          }).toList(),
        ),
      ],
    ),
    // ),
  );
}

//아이콘슬라이더
Widget _iconSlider(BuildContext context) {
  return SliverAppBar(
    backgroundColor: Colors.transparent,
    toolbarHeight: 150.h,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsetsDirectional.only(
        top: 5,
        bottom: 1,
        start: 5,
        end: 5,
    ),
    title: Stack(
      // fit: StackFit.loose,
      children: [
            Container(
            padding: EdgeInsets.all(5),
        alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 0, bottom: 20.h),
            // 컨테이너의 높이를 200으로 설정
            height: 150.h,
            // 리스트뷰 추가
            child: ListView(
              // 스크롤 방향 설정. 수평적으로 스크롤되도록 설정
              scrollDirection: Axis.horizontal,
              // 컨테이너들을 ListView의 자식들로 추가
              children: <Widget>[
                Container(
                  // height: 200.h,
                  width: 500.w,
                  // width: MediaQuery.of(context).size.width,
                  // padding: EdgeInsets.all(10),
                  // margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      //1단
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: <Widget>[
                              Icon(
                                Icons.icecream,
                                size: 50,
                                color: Colors.red,
                              ),
                              Text(
                                "쿠팡",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Icon(
                                Icons.mail,
                                size: 50,
                                color: Colors.blue,
                              ),
                              Text(
                                "쿠팡메일",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Icon(
                                Icons.local_taxi,
                                size: 50,
                                color: Colors.yellow,
                              ),
                              Text(
                                "쿠팡택시",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.home,
                                size: 50,
                                color: Colors.pink,
                              ),
                              Text(
                                "쿠팡홈",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.wallet,
                                size: 50,
                                color: Colors.orange,
                              ),
                              Text(
                                "쿠팡지갑",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Icon(
                                Icons.radio,
                                size: 50,
                                color: Colors.green,
                              ),
                              Text(
                                "쿠팡라디오",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
                      //2단
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: <Widget>[
                              Icon(
                                Icons.icecream,
                                size: 50,
                                color: Colors.deepPurple,
                              ),
                              Text(
                                "쿠팡",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Icon(
                                Icons.mail,
                                size: 50,
                                color: Colors.tealAccent,
                              ),
                              Text(
                                "쿠팡메일",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Icon(
                                Icons.local_taxi,
                                size: 50,
                                color: Colors.black,
                              ),
                              Text(
                                "쿠팡택시",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.home,
                                size: 50,
                                color: Colors.lime,
                              ),
                              Text(
                                "쿠팡홈",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.wallet,
                                size: 50,
                                color: Colors.brown,
                              ),
                              Text(
                                "쿠팡지갑",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Icon(
                                Icons.radio,
                                size: 50,
                                color: Colors.grey,
                              ),
                              Text(
                                "쿠팡라디오",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ],
    ),
      ),
  );
}


//배너이미지
SliverAppBar _bannerImage(BuildContext context) {
  return SliverAppBar(
    toolbarHeight: 70.h,
    pinned: false,
    backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
      titlePadding: EdgeInsetsDirectional.only(
      top: 1,
      // bottom: 1,
        start: 1,
        end: 1,
  ),

    title: Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topCenter,
      child: SizedBox
        (
          child: Image.asset('assets/images/banner.jpg')),
    ),
  ),
  );
}

//이 상품을 놓치지마세요
Widget _prodBannerText(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topCenter,
      child: Text("이 상품 놓치지마세요!")
    );
}

//이 상품을 놓치지마세요 상품
Widget _specialProd(BuildContext context) {
  return SliverAppBar(
    // expandedHeight: 500,
    toolbarHeight: 500.h,
    title: Container(
        // padding: EdgeInsets.symmetric(vertical: 50.0),
        // 컨테이너의 높이를 200으로 설정
        height: 400.0,
        // 리스트뷰 추가
        child: ListView(
          // 스크롤 방향 설정. 수평적으로 스크롤되도록 설정
          scrollDirection: Axis.horizontal,
          // 컨테이너들을 ListView의 자식들로 추가
          children: <Widget>[
            Container(
              height: 500,
              width: 700,
              // width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              // margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [

                  //1단
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: <Widget>[
                          Container(
                            height: 150,
                            width: 358.w,
                            // width: MediaQuery.of(con).size.width,
                            padding: EdgeInsets.only(
                                left: 16.w, top: 21.h, bottom: 20.h, right: 16.w),
                            decoration: (BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x22000029),
                                  spreadRadius: 0,
                                  blurRadius: 2,
                                  offset: Offset(0,5), // changes position of shadow
                                ),
                              ],
                              // border: Border.all(),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                            )),
                            child: Column(
                              // mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.icecream,
                                  size: 50,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  "쿠팡",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            height: 150,
                            width: 358.w,
                            // width: MediaQuery.of(con).size.width,
                            padding: EdgeInsets.only(
                                left: 16.w, top: 21.h, bottom: 20.h, right: 16.w),
                            margin: EdgeInsets.only(bottom: 30.h),
                            decoration: (BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x22000029),
                                  spreadRadius: 0,
                                  blurRadius: 2,
                                  offset: Offset(0,5), // changes position of shadow
                                ),
                              ],
                              // border: Border.all(),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                            )),
                            child: Column(
                              // mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.icecream,
                                  size: 50,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  "쿠팡",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Icon(
                            Icons.mail,
                            size: 50,
                            color: Colors.black,
                          ),
                          Text(
                            "쿠팡메일",
                            style: TextStyle(
                                color: Colors.black, fontSize: 10),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Icon(
                            Icons.local_taxi,
                            size: 50,
                            color: Colors.black,
                          ),
                          Text(
                            "쿠팡택시",
                            style: TextStyle(
                                color: Colors.black, fontSize: 10),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.home,
                            size: 50,
                            color: Colors.black,
                          ),
                          Text(
                            "쿠팡홈",
                            style: TextStyle(
                                color: Colors.black, fontSize: 10),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.wallet,
                            size: 50,
                            color: Colors.black,
                          ),
                          Text(
                            "쿠팡지갑",
                            style: TextStyle(
                                color: Colors.black, fontSize: 10),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Icon(
                            Icons.radio,
                            size: 50,
                            color: Colors.black,
                          ),
                          Text(
                            "쿠팡라디오",
                            style: TextStyle(
                                color: Colors.black, fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),


                  //2단
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Column(
                  //       children: <Widget>[
                  //         Icon(
                  //           Icons.icecream,
                  //           size: 50,
                  //           color: Colors.black,
                  //         ),
                  //         Text(
                  //           "쿠팡",
                  //           style: TextStyle(
                  //               color: Colors.black, fontSize: 10),
                  //         ),
                  //       ],
                  //     ),
                  //     Column(
                  //       children: <Widget>[
                  //         Icon(
                  //           Icons.mail,
                  //           size: 50,
                  //           color: Colors.black,
                  //         ),
                  //         Text(
                  //           "쿠팡메일",
                  //           style: TextStyle(
                  //               color: Colors.black, fontSize: 10),
                  //         ),
                  //       ],
                  //     ),
                  //     Column(
                  //       children: <Widget>[
                  //         Icon(
                  //           Icons.local_taxi,
                  //           size: 50,
                  //           color: Colors.black,
                  //         ),
                  //         Text(
                  //           "쿠팡택시",
                  //           style: TextStyle(
                  //               color: Colors.black, fontSize: 10),
                  //         ),
                  //       ],
                  //     ),
                  //     Column(
                  //       children: [
                  //         Icon(
                  //           Icons.home,
                  //           size: 50,
                  //           color: Colors.black,
                  //         ),
                  //         Text(
                  //           "쿠팡홈",
                  //           style: TextStyle(
                  //               color: Colors.black, fontSize: 10),
                  //         ),
                  //       ],
                  //     ),
                  //     Column(
                  //       children: [
                  //         Icon(
                  //           Icons.wallet,
                  //           size: 50,
                  //           color: Colors.black,
                  //         ),
                  //         Text(
                  //           "쿠팡지갑",
                  //           style: TextStyle(
                  //               color: Colors.black, fontSize: 10),
                  //         ),
                  //       ],
                  //     ),
                  //     Column(
                  //       children: <Widget>[
                  //         Icon(
                  //           Icons.radio,
                  //           size: 50,
                  //           color: Colors.black,
                  //         ),
                  //         Text(
                  //           "쿠팡라디오",
                  //           style: TextStyle(
                  //               color: Colors.black, fontSize: 10),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        )),
  );
}





