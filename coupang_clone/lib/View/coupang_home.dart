import 'package:coupang_clone/Models/icon_item.dart';
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


  int currentPos = 0;
  List<String> sliderList = [
    "assets/images/bag.jpg",
    "assets/images/bomb.jpg",
    "assets/images/cola.jpg",
    "assets/images/noodle.jpg",
    "assets/images/star.jpg",
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
            _prodBannerText(context),
            _specialProd(context),
          ];
        },
        body: _prodBannerText2(context),
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
      ),
    );
  }
}

//로고
SliverAppBar createLogo() {
  return SliverAppBar(
    backgroundColor: Colors.transparent,
    // expandedHeight: 30.h,
    floating: false,
    elevation: 0,
    // toolbarHeight: 70.h,
    flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Container(
          width: double.infinity,
          color: Colors.white,
          padding: EdgeInsetsDirectional.only(top: 40.h, bottom: 1.h),
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
    toolbarHeight: 60.h,
    flexibleSpace: FlexibleSpaceBar(),
    title: Container(
      // alignment: Alignment.topCenter,
      height: 45.h,
      child: TextField(
        textInputAction: TextInputAction.search,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: "쿠팡에서 검색하세요!",
          prefixIcon: Icon(Icons.search, color: Colors.grey, size: 15.w),

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
  );
}

//메인슬라이더
SliverAppBar _mainSlider() {


  int currentPos = 0;

  List<String> sliderList = [
    "assets/images/bag.jpg",
    "assets/images/bomb.jpg",
    "assets/images/cola.jpg",
    "assets/images/noodle.jpg",
    "assets/images/star.jpg",
  ];

  return SliverAppBar(
    // expandedHeight: 200.h,
    backgroundColor: Colors.transparent,
    //SliverAppBar의 높이 설정
    toolbarHeight: 150.h,
    // collapsedHeight: 250,
    //SliverAppBar 영역을 고정시킨다. default false
    pinned: false,
    // AppBar가 하단 List 내렸을 때 바로 보여야 한다 -> true
    // List를 최상단으로 올렸을 때만 나와야 한다. -> false
    // floating: true = 스크롤시 위치 보임
    floating: true,
    flexibleSpace: FlexibleSpaceBar(
      titlePadding: EdgeInsetsDirectional.only(
        top: 5,
        bottom: 5,
        start: 1,
        end: 1,
      ),
      title: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              height: 220.h,
              // disableCenter: false,
              viewportFraction: 1,
              // onPageChanged: (index) {
              //   setState(() { // setState() 추가???
              //     currentPos = index;
              //   });
              // },
            ),

            items: sliderList.map((index) {
              return Builder(
                builder: (BuildContext context) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Container(
                        height: 140.h,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 1.0),
                        child: PageView(
                          children: [
                            SizedBox(
                            child: Image.asset(
                              index,
                              fit: BoxFit.fill,
                            ),
                          ),
                          ]
                        ),
                      ),
//메인슬라이더 인디케이터 사이 여백
                      SizedBox(
                        height: 5,
                      ),
//인디케이터
                      CarouselIndicator(
                        count: sliderList.length,
                        index: currentPos,
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
    ),
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
      title: Container(
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
                width: MediaQuery.of(context).size.width,
                // width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 10, right: 10),
                // margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //1단
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 40),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.icecream,
                                // Icons.(${iconList[index]["name"]}),
                                size: 40,
                                color: Colors.red,
                              ),
                              Text(
                                "쿠팡플레이",
                                // "${icon_List[index]['name']}",
                                style:
                                    TextStyle(color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 40),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.mail,
                                size: 40,
                                color: Colors.blue,
                              ),
                              Text(
                                "쿠팡메일",
                                style:
                                    TextStyle(color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 40),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.local_taxi,
                                size: 40,
                                color: Colors.yellow,
                              ),
                              Text(
                                "쿠팡택시",
                                style:
                                    TextStyle(color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 40),
                          child: Column(
                            children: [
                              Icon(
                                Icons.home,
                                size: 40,
                                color: Colors.pink,
                              ),
                              Text(
                                "쿠팡홈",
                                style:
                                    TextStyle(color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 40),
                          child: Column(
                            children: [
                              Icon(
                                Icons.wallet,
                                size: 40,
                                color: Colors.orange,
                              ),
                              Text(
                                "쿠팡지갑",
                                style:
                                    TextStyle(color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 40),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.radio,
                                size: 40,
                                color: Colors.green,
                              ),
                              Text(
                                "쿠팡라디오",
                                style:
                                    TextStyle(color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),



                    //2단
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.icecream,
                                size: 40,
                                color: Colors.deepPurple,
                              ),
                              Text(
                                "쿠팡골드",
                                style:
                                    TextStyle(color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.mail,
                                size: 40,
                                color: Colors.tealAccent,
                              ),
                              Text(
                                "쿠팡편지",
                                style:
                                    TextStyle(color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.local_taxi,
                                size: 40,
                                color: Colors.black,
                              ),
                              Text(
                                "쿠팡배송",
                                style:
                                    TextStyle(color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Column(
                            children: [
                              Icon(
                                Icons.home,
                                size: 40,
                                color: Colors.lime,
                              ),
                              Text(
                                "쿠팡집",
                                style:
                                    TextStyle(color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Column(
                            children: [
                              Icon(
                                Icons.wallet,
                                size: 40,
                                color: Colors.brown,
                              ),
                              Text(
                                "쿠팡돈",
                                style:
                                    TextStyle(color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Icon(
                              Icons.radio,
                              size: 40,
                              color: Colors.grey,
                            ),
                            Text(
                              "쿠팡라디오",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 50,
                              width: 40,
                              child: TextButton(
                                onPressed: () {},
                                child: Text("● ● ●"),
                                style: TextButton.styleFrom(
                                    primary: Colors.black,
                                    // padding: EdgeInsets
                                    //     .symmetric(
                                    //     horizontal:
                                    //     11.w,
                                    //     vertical:
                                    //     14.h),
                                    textStyle: TextStyle(
                                        fontFamily: 'NMFont',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 5.h,
                                        color: Color(0xffA3A3A3))),
                              ),
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
        child: SizedBox(child: Image.asset('assets/images/banner.jpg')),
      ),
    ),
  );
}

//이 상품을 놓치지마세요
SliverAppBar _prodBannerText(BuildContext context) {
  return SliverAppBar(
    toolbarHeight: 20.h,
    pinned: false,
    backgroundColor: Colors.transparent,
    flexibleSpace: FlexibleSpaceBar(
      titlePadding: EdgeInsetsDirectional.only(
        top: 5,
        bottom: 5,
        start: 20,
        end: 20,
      ),
      title: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.centerLeft,
        // padding: EdgeInsets.only(left: 0,top: 2,right: 1, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 25.h,
              child: Row(
                children: [
                  Icon(Icons.shopping_bag, color: Colors.pinkAccent),
                  Text(
                    "  이 상품 놓치지마세요!",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ],
              ),
            ),
            Container(
              height: 32.h,
              child: TextButton(
                onPressed: () {},
                child: Text("더보기 >"),
                style: TextButton.styleFrom(
                  primary: Colors.blueAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}



//이 상품을 놓치지마세요 아이콘슬라이더
Widget _specialProd(BuildContext context) {
  return SliverAppBar(
    // expandedHeight: 500,
    toolbarHeight: 500.h,
    flexibleSpace: FlexibleSpaceBar(
      titlePadding: EdgeInsetsDirectional.only(
        top: 1,
        // bottom: 1,
        start: 1,
        end: 1,
      ),
      title: Container(
          // padding: EdgeInsets.symmetric(vertical: 50.0),
          // 컨테이너의 높이를 200으로 설정
          height: 500.0,
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
                ),
                child: Column(
                  children: [
                    //1단
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 200,
                              width: 120,
                              child: Image.asset(
                                "assets/images/prod1.jpg",
                                // fit: BoxFit.fill,
                                // '메인슬라이더 $i',
                              ),
                            ),
                            Text(
                              "깊고 진항 풍미",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                            Text(
                              "지금 28% 할인중",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 200,
                              width: 120,
                              child: Image.asset(
                                "assets/images/prod2.jpg",
                                // fit: BoxFit.fill,
                                // '메인슬라이더 $i',
                              ),
                            ),
                            Text(
                              "김은 재개김",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                            Text(
                              "지금 19% 할인중",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 200,
                              width: 120,
                              child: Image.asset(
                                "assets/images/prod3.jpg",
                                // fit: BoxFit.fill,
                                // '메인슬라이더 $i',
                              ),
                            ),
                            Text(
                              "한라봉인줄 알았던 귤",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                            Text(
                              "지금 50% 할인중",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 200,
                              width: 120,
                              child: Image.asset(
                                "assets/images/prod4.jpg",
                                // fit: BoxFit.fill,
                                // '메인슬라이더 $i',
                              ),
                            ),
                            Text(
                              "쿠팡홈",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                            Text(
                              "지금 50% 할인중",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                            Text(
                              "지금 30% 할인중",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                            Text(
                              "지금 20% 할인중",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
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
                            SizedBox(
                              height: 200,
                              width: 120,
                              child: Image.asset(
                                "assets/images/prod6.jpg",
                                // fit: BoxFit.fill,
                                // '메인슬라이더 $i',
                              ),
                            ),
                            Text(
                              "꿀사과",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                            Text(
                              "지금 50% 할인중",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 200,
                              width: 120,
                              child: Image.asset(
                                "assets/images/prod5.jpg",
                                // fit: BoxFit.fill,
                                // '메인슬라이더 $i',
                              ),
                            ),
                            Text(
                              "포도포도",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                            Text(
                              "지금 35% 할인중",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 200,
                              width: 120,
                              child: Image.asset(
                                "assets/images/prod4.jpg",
                                // fit: BoxFit.fill,
                                // '메인슬라이더 $i',
                              ),
                            ),
                            Text(
                              "여름엔 역시 수박",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                            Text(
                              "지금 40% 할인중",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 200,
                              width: 120,
                              child: Image.asset(
                                "assets/images/prod1.jpg",
                                // fit: BoxFit.fill,
                                // '메인슬라이더 $i',
                              ),
                            ),
                            Text(
                              "쿠팡홈",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
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
    ),
  );
}

//이 상품을 놓치지마세요
Widget _prodBannerText2(BuildContext context) {
  return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topCenter,
      child: Text("바디잡기"));
}

//아이콘
// Widget _iconSlider(BuildContext context) {
//   return SliverAppBar(
//     backgroundColor: Colors.transparent,
//     toolbarHeight: 150.h,
//     flexibleSpace: FlexibleSpaceBar(
//       titlePadding: EdgeInsetsDirectional.only(
//         top: 5,
//         bottom: 1,
//         start: 5,
//         end: 5,
//       ),
//       title: Container(
//           padding: EdgeInsets.all(5),
//           alignment: Alignment.topCenter,
//           margin: EdgeInsets.only(top: 0, bottom: 20.h),
//           // 컨테이너의 높이를 200으로 설정
//           height: 150.h,
//           // 리스트뷰 추가
//           child: ListView(
//             // 스크롤 방향 설정. 수평적으로 스크롤되도록 설정
//             scrollDirection: Axis.horizontal,
//             // 컨테이너들을 ListView의 자식들로 추가
//             children: <Widget>[
//               Container(
//                 // height: 200.h,
//                 width: 450.w,
//                 // width: MediaQuery.of(context).size.width,
//                 padding: EdgeInsets.only(left: 10, right: 10),
//                 // margin: EdgeInsets.symmetric(horizontal: 5.0),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     //1단
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           children: <Widget>[
//                             Icon(
//                               Icons.icecream,
//                               size: 40,
//                               color: Colors.red,
//                             ),
//                             Text(
//                               "쿠팡플레이",
//                               style:
//                               TextStyle(color: Colors.black, fontSize: 10),
//                             ),
//                           ],
//                         ),
//                         Column(
//                           children: <Widget>[
//                             Icon(
//                               Icons.mail,
//                               size: 40,
//                               color: Colors.blue,
//                             ),
//                             Text(
//                               "쿠팡메일",
//                               style:
//                               TextStyle(color: Colors.black, fontSize: 10),
//                             ),
//                           ],
//                         ),
//                         Column(
//                           children: <Widget>[
//                             Icon(
//                               Icons.local_taxi,
//                               size: 40,
//                               color: Colors.yellow,
//                             ),
//                             Text(
//                               "쿠팡택시",
//                               style:
//                               TextStyle(color: Colors.black, fontSize: 10),
//                             ),
//                           ],
//                         ),
//                         Column(
//                           children: [
//                             Icon(
//                               Icons.home,
//                               size: 40,
//                               color: Colors.pink,
//                             ),
//                             Text(
//                               "쿠팡홈",
//                               style:
//                               TextStyle(color: Colors.black, fontSize: 10),
//                             ),
//                           ],
//                         ),
//                         Column(
//                           children: [
//                             Icon(
//                               Icons.wallet,
//                               size: 40,
//                               color: Colors.orange,
//                             ),
//                             Text(
//                               "쿠팡지갑",
//                               style:
//                               TextStyle(color: Colors.black, fontSize: 10),
//                             ),
//                           ],
//                         ),
//                         Column(
//                           children: <Widget>[
//                             Icon(
//                               Icons.radio,
//                               size: 40,
//                               color: Colors.green,
//                             ),
//                             Text(
//                               "쿠팡라디오",
//                               style:
//                               TextStyle(color: Colors.black, fontSize: 10),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     //2단
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           children: <Widget>[
//                             Icon(
//                               Icons.icecream,
//                               size: 40,
//                               color: Colors.deepPurple,
//                             ),
//                             Text(
//                               "쿠팡골드",
//                               style:
//                               TextStyle(color: Colors.black, fontSize: 10),
//                             ),
//                           ],
//                         ),
//                         Column(
//                           children: <Widget>[
//                             Icon(
//                               Icons.mail,
//                               size: 40,
//                               color: Colors.tealAccent,
//                             ),
//                             Text(
//                               "쿠팡편지",
//                               style:
//                               TextStyle(color: Colors.black, fontSize: 10),
//                             ),
//                           ],
//                         ),
//                         Column(
//                           children: <Widget>[
//                             Icon(
//                               Icons.local_taxi,
//                               size: 40,
//                               color: Colors.black,
//                             ),
//                             Text(
//                               "쿠팡로켓배송",
//                               style:
//                               TextStyle(color: Colors.black, fontSize: 10),
//                             ),
//                           ],
//                         ),
//                         Column(
//                           children: [
//                             Icon(
//                               Icons.home,
//                               size: 40,
//                               color: Colors.lime,
//                             ),
//                             Text(
//                               "쿠팡집",
//                               style:
//                               TextStyle(color: Colors.black, fontSize: 10),
//                             ),
//                           ],
//                         ),
//                         Column(
//                           children: [
//                             Icon(
//                               Icons.wallet,
//                               size: 40,
//                               color: Colors.brown,
//                             ),
//                             Text(
//                               "쿠팡돈",
//                               style:
//                               TextStyle(color: Colors.black, fontSize: 10),
//                             ),
//                           ],
//                         ),
//                         Column(
//                           children: <Widget>[
//                             Icon(
//                               Icons.radio,
//                               size: 40,
//                               color: Colors.grey,
//                             ),
//                             Text(
//                               "쿠팡라디오",
//                               style:
//                               TextStyle(color: Colors.black, fontSize: 10),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             SizedBox(
//                               height: 50,
//                               width: 40,
//                               child: TextButton(
//                                 onPressed: () {},
//                                 child: Text("● ● ●"),
//                                 style: TextButton.styleFrom(
//                                     primary: Colors.black,
//                                     // padding: EdgeInsets
//                                     //     .symmetric(
//                                     //     horizontal:
//                                     //     11.w,
//                                     //     vertical:
//                                     //     14.h),
//                                     textStyle: TextStyle(
//                                         fontFamily: 'NMFont',
//                                         fontWeight: FontWeight.w700,
//                                         fontSize: 5.h,
//                                         color: Color(0xffA3A3A3))),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           )),
//     ),
//   );
// }