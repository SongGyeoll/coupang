import 'package:carousel_slider/carousel_slider.dart';
import 'package:coupang_clone/View/banner_page.dart';
import 'package:coupang_clone/View/dont_miss_page.dart';
import 'package:coupang_clone/View/log_in_page.dart';
import 'package:coupang_clone/View/logo_page.dart';
import 'package:coupang_clone/View/need_it_page.dart';
import 'package:coupang_clone/View/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SliderPage extends StatefulWidget {
  const SliderPage({Key? key}) : super(key: key);

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  
  final CarouselController _controller = CarouselController();
  int _current = 0;

  // 상태위젯 상태변수로 선언
  DateTime? currentBackPressTime;

  //자동로그인 토글
  bool _switchValue = false;

  String loginId = '';
  String loginPw = '';
  String _id = '';
  String _pw = '';

  _clearData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      loginId = _prefs.getString('id')!;
      loginPw = _prefs.getString("pw")!;
      // * id,pw 최신 값을 SharedPreferences에 저장
      // _prefs.setString('id', _id);
      // _prefs.setString('pw', _pw);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // inputbox 바깥 탭 시에  "키보드 닫힘"
        //FocusNode = 선택된 위젯을 관리(거의 대부분 텍스트필드를 관리한다_선택됐을 때)
        //new = 클래스명의 인스턴스(생성자)를 만든다.
        //키보드가 닫히는 이유는, 새로운 포커스를 새로 잡기 때문에
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      //주변범위, 불투명 한 대상은 hit test에 의해 hit 될 수 있으므로 둘 다 해당 범위 내에서 이벤트를 수신하고 시각적으로 뒤에 있는 대상도 이벤트를 수신하지 못하도록 한다.
      behavior: HitTestBehavior.opaque,
      child: WillPopScope(
        onWillPop: () async {
          DateTime now = DateTime.now();
          //상태변화가 없거나,새로 상태가 변경됐을 때, 5초간격보다 클 때, [스낵바 띄우기 + "시간 초기화" ]
          if (currentBackPressTime == null ||
              now.difference(currentBackPressTime!) > Duration(seconds: 5)) {
            //시간초기화
            currentBackPressTime = now;
            //백키처리 스낵바
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(
                      Icons.notification_important,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '뒤로가기 버튼을 한 번 더 누르시면 종료됩니다.',
                        //컨텍스트의 주제
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            );
            return Future.value(false);
          }
          return Future.value(true);
        },
        child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
              return <Widget>[
                createLogo(),
                onTextField(),
                _mainSlider(),
                _iconSlider(context),
                _bannerImage(context),
                _prodBannerText(context),
                _specialProd(context),
                _bottomLine(context),
                _needBanner(context),
                _needProd(context),
                _bottomLine2(context),
                _hotToyText(context),
                _hotToy(context),
                _bottomLine3(context),
              ];
            },
            body: SizedBox.shrink()
        ),
      ),
    );
  }


  SliverAppBar _mainSlider() {

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
      floating: false,
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
                  disableCenter: false,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }
              ),
              items: sliderList.map((index) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      height: 140.h,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 1.0),
                      child: PageView(children: [
                        SizedBox(
                          child: Image.asset(
                            index,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ]),
                    );
                  },
                );
              }).toList(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: sliderList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == entry.key? Color(0xffffffff): Colors.blueGrey),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //로고
  SliverAppBar createLogo() {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      // expandedHeight: 30.h,
      toolbarHeight: 50.h,
      floating: false,
      elevation: 0,
      flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: GestureDetector(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (_) => LogoPage()));
                  // Navigator.of(context, rootNavigator: false).push(MaterialPageRoute(builder: (_) => LogoPage()));
                },
                //작은버튼일 때, 정확히 누르기 힘들기 때문에, behavior을 줘서 주변 마진만큼 범위 확장 시킨다.(translucent는 투명한 부분에,투명영역까지 범위) 반대로 오페큐는 딱 아이콘모양만 터치영역
                behavior: HitTestBehavior.translucent,
                child: Container(
                  padding: EdgeInsets.only(top: 40.h),
                  width: MediaQuery.of(context).size.width,
                  // alignment: Alignment.centerRight,
                  // padding: EdgeInsets.only(left: 0,top: 2,right: 1, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 140.w),
                        // height: 35.h,
                        child:
                            Image.asset(
                              'assets/images/logo.png',
                            ),
                      ),

                      //로그아웃
                      GestureDetector(
                        onTap: () async {
                          //로그아웃 다이얼로그
                          logoutDialog(context);

                          bool isAuto = false;
                          SharedPreferences _prefs = await SharedPreferences.getInstance();
                          _prefs.setBool("AUTO_LOGIN", isAuto);
                          setState(() {
                            _clearData();
                          });
                          // Navigator.of(context).pushReplacementNamed(Routes.login);
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (_) => LogInPage()));
                        },
                        child: Container(
                          // height: 32.h,
                          margin: EdgeInsets.only(right: 20.w),
                          child: Icon(Icons.logout, color: Colors.red, size: 30.w),
                          ),
                      ),
                    ],
                  ),
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
      // flexibleSpace: FlexibleSpaceBar(),
      title: Align(
          alignment: Alignment.center,
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
      // ),
    );
  }

//아이콘슬라이더
  Widget _iconSlider(BuildContext context) {
    List<String> iconList = [
      "assets/images/prod1.jpg",
      "assets/images/prod2.jpg",
      "assets/images/prod3.jpg",
      "assets/images/prod4.jpg",
      "assets/images/prod5.jpg",
      "assets/images/prod6.jpg",
      "assets/images/prod7.jpg",
      "assets/images/prod8.jpg",
      "assets/images/prod9.jpg",
    ];

    List<String> iconList2 = [
      "assets/images/prod9.jpg",
      "assets/images/prod8.jpg",
      "assets/images/prod7.jpg",
      "assets/images/prod6.jpg",
      "assets/images/prod5.jpg",
      "assets/images/prod4.jpg",
      "assets/images/prod3.jpg",
      "assets/images/prod2.jpg",
      "assets/images/prod1.jpg",
    ];

    List<String> iconName = [
      "쿠팡라면",
      "쿠팡김",
      "쿠팡귤",
      "큐팡수박",
      "쿠팡포도",
      "쿠팡사과",
      "쿠팡호두",
      "쿠팡바나나",
      "쿠팡딸기",
    ];

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
            child: ListView.builder(
              // 스크롤 방향 설정. 수평적으로 스크롤되도록 설정
              scrollDirection: Axis.horizontal,
              // 컨테이너들을 ListView의 자식들로 추가
              itemCount: iconList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => BannerPage()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 15, right: 10),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 50.h,
                                  width: 50.w,
                                  child: Image.asset(
                                    iconList[index],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Text(
                                  iconName[index].toString(),
                                  // "${icon_List[index]['name']}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 50.h,
                                      width: 50.w,
                                      child: Image.asset(
                                        iconList2[index],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Text(
                                      iconName[index].toString(),
                                      // "${icon_List[index]['name']}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
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
        title: GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => BannerPage()));
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.topCenter,
            child: SizedBox(child: Image.asset('assets/images/banner.jpg')),
          ),
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
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                height: 32.h,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => DontMissPage()));
                  },
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
    List<String> specialList = [
      "assets/images/prod1.jpg",
      "assets/images/prod2.jpg",
      "assets/images/prod3.jpg",
      "assets/images/prod4.jpg",
      "assets/images/prod5.jpg",
      "assets/images/prod6.jpg",
      "assets/images/prod7.jpg",
      "assets/images/prod8.jpg",
      "assets/images/prod9.jpg",
    ];

    List<String> specialList2 = [
      "assets/images/prod9.jpg",
      "assets/images/prod8.jpg",
      "assets/images/prod7.jpg",
      "assets/images/prod6.jpg",
      "assets/images/prod3.jpg",
      "assets/images/prod5.jpg",
      "assets/images/prod4.jpg",
      "assets/images/prod2.jpg",
      "assets/images/prod1.jpg",
    ];
    List<String> specialName = [
      "깊고진한풍미",
      "김은재래김",
      "한라봉인 줄",
      "수박박수",
      "꿀사과",
      "포도포도",
      "라면인건가",
      "쿠팡바나나",
      "쿠팡딸기",
    ];

    List<String> saleText = [
      "28%",
      "30%",
      "50%",
      "100%",
      "10%",
      "25%",
      "0%",
      "40%",
      "50%",
    ];

    return SliverAppBar(
      // expandedHeight: 500,
      backgroundColor: Colors.transparent,
      toolbarHeight: 400.h,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsetsDirectional.only(
          top: 1,
          // bottom: 1,
          start: 1,
          end: 1,
        ),
        title: ListView.builder(
              // 스크롤 방향 설정. 수평적으로 스크롤되도록 설정
              scrollDirection: Axis.horizontal,
              // 컨테이너들을 ListView의 자식들로 추가
              itemCount: specialList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => BannerPage()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 150.h,
                                  width: 120.w,
                                  child: Image.asset(
                                    specialList[index],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Text(
                                  specialName[index].toString(),
                                  style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                                ),
                                Text(
                                  "% 지금 ${saleText[index]} 할인 중",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 150.h,
                                      width: 120.w,
                                      child: Image.asset(
                                        specialList2[index],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Text(
                                      specialName[index].toString(),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                    Text(
                                      "% 지금 ${saleText[index]} 할인 중",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
      );
  }

//섹션별 바텀구분선
  SliverAppBar _bottomLine(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 20.h,
      pinned: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsetsDirectional.only(
          top: 5,
          bottom: 5,
          start: 0,
          end: 0,
        ),
        title: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.topRight,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 25.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "추천광고",
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    SizedBox(
                      width: 20.w,
                    )
                  ],
                ),
              ),
              Container(
                height: 5.h,
                color: Colors.blueGrey[50],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //지금 이 상품이 필요하신가요?
  SliverAppBar _needBanner(BuildContext context) {
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
                    Text(
                      "지금 이 상품이 필요하신가요?",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                height: 32.h,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => NeedItPage()));
                  },
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

//지금 이 상품이 필요하신가요? 슬라이더
  Widget _needProd(BuildContext context) {
    List<String> specialList = [
      "assets/images/prod1.jpg",
      "assets/images/prod2.jpg",
      "assets/images/prod3.jpg",
      "assets/images/prod4.jpg",
      "assets/images/prod5.jpg",
      "assets/images/prod6.jpg",
      "assets/images/prod7.jpg",
      "assets/images/prod8.jpg",
      "assets/images/prod9.jpg",
    ];

    List<String> specialList2 = [
      "assets/images/prod9.jpg",
      "assets/images/prod8.jpg",
      "assets/images/prod7.jpg",
      "assets/images/prod6.jpg",
      "assets/images/prod3.jpg",
      "assets/images/prod5.jpg",
      "assets/images/prod4.jpg",
      "assets/images/prod2.jpg",
      "assets/images/prod1.jpg",
    ];
    List<String> specialName = [
      "깊고진한풍미",
      "김은재래김",
      "한라봉인 줄",
      "수박박수",
      "꿀사과",
      "포도포도",
      "라면인건가",
      "쿠팡바나나",
      "쿠팡딸기",
    ];

    List<String> priceText = [
      "24,600",
      "16,450",
      "6,800",
      "11,160",
      "28,500",
      "25,900",
      "24,600",
      "16,450",
      "6,800",
    ];

    return SliverAppBar(
      // expandedHeight: 500,
      backgroundColor: Colors.transparent,
      toolbarHeight: 190.h,
      flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsetsDirectional.only(
            top: 1,
            // bottom: 1,
            start: 1,
            end: 1,
          ),
          title: ListView.builder(
            // 스크롤 방향 설정. 수평적으로 스크롤되도록 설정
            scrollDirection: Axis.horizontal,
            // 컨테이너들을 ListView의 자식들로 추가
            itemCount: specialList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => BannerPage()));
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: <Widget>[
                              SizedBox(
                                height: 130.h,
                                width: 110.w,
                                child: Image.asset(
                                  specialList[index],
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Text(
                                specialName[index].toString(),
                                style:
                                TextStyle(color: Colors.black, fontSize: 12),
                              ),
                              Text(
                                "${priceText[index]}원",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                        child: Icon(Icons.rocket_launch_outlined),
                                    ),
                                    TextSpan(
                                      text: "로켓배송",
                                      style: TextStyle(
                                          color: Colors.lightBlueAccent,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }


//섹션별 바텀구분선
  SliverAppBar _bottomLine2 (BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 20.h,
      pinned: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsetsDirectional.only(
          top: 5,
          bottom: 5,
          start: 0,
          end: 0,
        ),
        title: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.topRight,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 25.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "추천광고",
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    SizedBox(
                      width: 20.w,
                    )
                  ],
                ),
              ),
              Container(
                height: 5.h,
                color: Colors.blueGrey[50],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //요즘 뜨는 기타멜로디완구
  SliverAppBar _hotToyText (BuildContext context) {
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
                    RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(Icons.bar_chart,
                            color: Colors.pinkAccent,
                            ),
                          ),
                          TextSpan(
                            text: " 요즘 뜨는 기타멜로디완구",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //요즘 뜨는 기타 멜로디완구
  Widget _hotToy (BuildContext context) {


    List<String> toyList = [
      "assets/images/duck.jpg",
      "assets/images/dog.jpg",
      "assets/images/dance.jpg",
    ];
    List<String> toyName = [
      "포원밀리언 말하는 선인장",
      "1073편 콘텐츠 요미몬",
      "베이비 요미몬 콘텐츠",
    ];

    List<String> saleText = [
      "28%",
      "30%",
      "50%",
    ];

    return SliverAppBar(
      // expandedHeight: 500,
      backgroundColor: Colors.transparent,
      toolbarHeight: 170.h,
      flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsetsDirectional.only(
            top: 2,
            // bottom: 1,
            start: 3,
            end: 1,
          ),
          title: ListView.builder(
            // 스크롤 방향 설정. 수평적으로 스크롤되도록 설정
            scrollDirection: Axis.horizontal,
            // 컨테이너들을 ListView의 자식들로 추가
            itemCount: toyList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => BannerPage()));
                },
                child: Container(
                  width: 250.w,
                  margin: EdgeInsets.only(left: 10, right: 10),
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
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 150.h,
                        width: 120.w,
                        child: Image.asset(
                          toyList[index],
                          fit: BoxFit.fill,
                        ),
                      ),
                          Container(
                            height: 150.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[

                                Text(
                                  toyName[index].toString(),
                                  style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                                ),
                                Text(
                                  "% 지금 ${saleText[index]} 할인 중",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ),
              );

            },
          )),
    );
  }

//섹션별 바텀구분선
  SliverAppBar _bottomLine3(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 20.h,
      pinned: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsetsDirectional.only(
          top: 5,
          bottom: 5,
          start: 0,
          end: 0,
        ),
        title: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.topRight,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 25.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "추천광고",
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    SizedBox(
                      width: 20.w,
                    )
                  ],
                ),
              ),
              Container(
                height: 5.h,
                color: Colors.blueGrey[50],
              ),
            ],
          ),
        ),
      ),
    );
  }





}
//로그아웃 다이얼로그
void logoutDialog(BuildContext context) {
  showDialog(
      context: context,
      //Dialog를 제외한 다른 화면 터치 x
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          //Dialog 화면 모서리 둥글게 조절
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)),
          title: Column(
            children: <Widget>[
              Text(
                "로그아웃 확인.",
                style: TextStyle(
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
                "로그아웃 하시겠습니까?",
                style: TextStyle(
                    fontSize: 15.w,
                    color: Color(0xff333333)),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Column(
                children: [
                  Text(
                    "확 인",
                    style: TextStyle(
                        fontFamily: 'NMFont',
                        fontSize: 15.w,
                        color: Colors.white),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.amberAccent,
              ),
              //다이얼로그종료
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(Routes.login);
                // Navigator.of(context).pop();
                //Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: Column(
                children: [
                  Text(
                    "취 소",
                    style: TextStyle(
                        fontFamily: 'NMFont',
                        fontSize: 15.w,
                        color: Colors.white),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.amberAccent,
              ),
              //다이얼로그종료
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}
