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
  int screenIndex = 0;
  List<Widget> screenList = [Text('메뉴'), Text('검색'), Text('홈')];

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
            mainIcon(),
          ];
        },
        body: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Row(
                    children: [
                      Column(
                        children: <Widget>[
                          Icon(
                            Icons.local_taxi,
                            size: 50,
                          ),
                          Text("쿠팡택시"),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.home,
                            size: 50,
                          ),
                          Text("쿠팡홈"),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.wallet,
                            size: 50,
                          ),
                          Text("쿠팡지갑"),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Icon(
                            Icons.radio,
                            size: 50,
                          ),
                          Text("쿠팡라디오"),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            }),
      ),
    );
  }

  //로고
  SliverAppBar createLogo() {
    return SliverAppBar(
      backgroundColor: Colors.white,
      expandedHeight: 30.h,
      floating: false,
      elevation: 0,
      flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 30.h),
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
      title: Container(
        // alignment: Alignment.topCenter,
        height: 50.h,
        child: TextField(
          textInputAction: TextInputAction.search,
          textAlignVertical: TextAlignVertical.center,

          decoration: InputDecoration(
            hintText: "쿠팡에서 검색하세요!",
            prefixIcon: Icon(Icons.search, color: Colors.grey,
                size: 15.w),
            // icon: Padding(
            //   padding: EdgeInsets.only(left: 13),
            //   child: Icon(Icons.search),
            // ),
            hintStyle: TextStyle(fontSize: 15.w, color: Color(0xffA3A3A3)),
            contentPadding: EdgeInsets.only(
                left: 10.w, right: 0.w, bottom: 0, top: 0),
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
      backgroundColor: Colors.black,
      //SliverAppBar의 높이 설정
      toolbarHeight: 150.h,
      //SliverAppBar 영역을 고정시킨다. default false
      pinned: false,
      // AppBar가 하단 List 내렸을 때 바로 보여야 한다 -> true
      // List를 최상단으로 올렸을 때만 나와야 한다. -> false
      floating: true,
      title: CarouselSlider(
        options: CarouselOptions(height: 120.h),
        items: [1, 2, 3, 4, 5].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100.h,
                    // margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      '메인슬라이더 $i',
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CarouselIndicator(
                    count: i,
                    index: [i].length,
                  ),
                ],
              );
            },
          );
        }).toList(),
      ),
    );
  }

  //아이콘슬라이더
  SliverAppBar mainIcon() {
    return SliverAppBar(
      backgroundColor: Colors.grey,
      //SliverAppBar의 높이 설정
      toolbarHeight: 200,
      //SliverAppBar 영역을 고정시킨다. default false
      pinned: false,
      // AppBar가 하단 List 내렸을 때 바로 보여야 한다 -> true
      // List를 최상단으로 올렸을 때만 나와야 한다. -> false
      floating: true,
      title: CarouselSlider(
        options: CarouselOptions(height: MediaQuery.of(context).size.height),
        items: [1, 2, 3, 4, 5].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 700,
                    padding: EdgeInsets.all(10),
                    // margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: <Widget>[
                                Icon(
                                  Icons.local_taxi,
                                  size: 30,
                                  color: Colors.black,
                                ),
                                Text("쿠팡택시",
                                  style: TextStyle(color: Colors.black, fontSize: 10),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Icon(
                                  Icons.home,
                                  size: 30,
                                  color: Colors.black,
                                ),
                                Text("쿠팡홈",
                                  style: TextStyle(color: Colors.black, fontSize: 10),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Icon(
                                  Icons.wallet,
                                  size: 30,
                                  color: Colors.black,
                                ),
                                Text("쿠팡지갑",
                                  style: TextStyle(color: Colors.black, fontSize: 10),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Icon(
                                  Icons.radio,
                                  size: 30,
                                  color: Colors.black,
                                ),
                                Text("쿠팡라디오",
                                  style: TextStyle(color: Colors.black, fontSize: 10),),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        }).toList(),
      ),
    );
  }

  //바텀네비게이션
  bottomNavigationBar() {
    BottomNavigationBar(
      currentIndex: screenIndex,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: '메뉴'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: '검색'),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈')
      ],
      onTap: (value) {
        setState(() {
          //상태 갱신이 되지 않으면 동작을 하지 않음
          screenIndex = value;
        });
      },
    );
  }


}
