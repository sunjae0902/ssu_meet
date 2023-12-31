import 'dart:convert';
import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:ssu_meet/pages/info_page.dart';
import 'package:ssu_meet/pages/login_page.dart';
import 'package:ssu_meet/pages/my_page.dart';
import 'package:ssu_meet/pages/main_page.dart';

import 'package:http/http.dart' as http;
import 'package:ssu_meet/widgets/desktop_layout.dart';

class ResponsiveWebLayout extends StatefulWidget {
  final int pageIndex;
  const ResponsiveWebLayout({super.key, required this.pageIndex});

  @override
  State<ResponsiveWebLayout> createState() =>
      _ResponsiveWebLayoutState(pageIndex: pageIndex);
}

class _ResponsiveWebLayoutState extends State<ResponsiveWebLayout> {
  int pageIndex;

  _ResponsiveWebLayoutState({required this.pageIndex});

  // int _selectedIndexScreen = 1; // Main Page

  dynamic coins = 0;

  // 서버에서 코인 가져오기
  void getCoinFromServer() async {
    const url = 'https://ssumeet.shop/v1/members/mycoin';

    // 디바이스에 저장된 access token과 refresh token 읽어오기 (존재하지 않으면 null 리턴)
    final accessToken = await storage.read(key: 'access_token');
    // final refreshToken = await storage.read(key: 'refresh_token');
    final http.Response response;
    // print("access token: $accessToken");

    if (accessToken != null) {
      // 엑세스 토큰을 보유한 경우
      try {
        response = await http.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $accessToken',
            'Access-Control-Allow-Origin': '*',
          },
        );

        // 한글 깨짐 현상 해결: utf8.decode(response.bodyBytes)를 사용하여 입력받기
        final responseData = jsonDecode(utf8.decode(response.bodyBytes));
        final message = responseData["message"];

        if (response.statusCode == 200) {
          // 엑세스 토큰이 유효한 경우
          if (responseData["status"] == "SUCCESS") {
            setState(() {
              coins = responseData["data"]["myCoinCount"];
              // print("서버에서 코인 가져옴 ! 현재 코인 개수: $coins");
            });
          } else {
            // Error
            setState(() {
              coins = 0;
            });

            // print("Status is Error !!");
          }
        } else if (response.statusCode == 401) {
          // 엑세스 토큰이 유효하지 않거나 만료된 경우
          if (message == "Token has expired") {
            // 엑세스 토큰이 만료된 경우
            final isSuccessNewToken =
                await getNewAccessToken(); // 리프레시 토큰으로 엑세스 토큰 재발급
            if (isSuccessNewToken == "NewAccessToken") {
              // 엑세스 토큰을 정상적으로 재발급 받은 경우
              getCoinFromServer(); // 코인 가져오기 함수 재실행
            } else if (isSuccessNewToken == "storageDelete") {
              // 리프레시 토큰이 만료된 경우
              setState(() {
                coins = 0;
              });
            } else if (isSuccessNewToken == "tokenError") {
              // 리프레시 토큰이 에러가 발생한 경우
              setState(() {
                coins = 0;
              });
            } else {
              // 네트워크 에러 또는 토큰 재발급 함수 자체에 에러가 발생한 경우
              setState(() async {
                await storage.deleteAll();
                coins = "로그인 후 이용 가능";
              });
            }
          } else {
            // 엑세스 토큰이 유효하지 않은 경우
            setState(() async {
              await storage.deleteAll();
              coins = "로그인 후 이용 가능";
            });
          }
        } else {
          // Network error
          setState(() {
            coins = 0;
          });
          // print('Failed to get data. Error: ${response.statusCode}');
        }
      } catch (e) {
        // 엑세스 토큰이 유효하지 않은 경우
        // print(e);
        setState(() async {
          await storage.deleteAll();
          coins = "로그인 후 이용 가능";
        });
      }
    } else {
      // 엑세스 토큰을 보유하지 않은 경우
      setState(() {
        coins = "로그인 후 이용 가능";
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCoinFromServer();
  }

  final List _children = [
    const InfoPage(),
    const MainPage(),
    const MyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= 540) {
      //태블릿 사이즈 레이아웃 설정
      screenWidth *= 0.7;
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(239, 239, 239, 1),
        shadowColor: const Color.fromRGBO(158, 156, 156, 1),
        flexibleSpace: Padding(
          padding: EdgeInsets.only(right: screenWidth * 0.03),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.05, top: screenWidth * 0.005),
                  child: Container(
                    width: screenWidth * 0.17,
                    height: screenHeight * 0.04,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          "assets/images/ssu_meet_logo.png",
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: coins is int ? screenWidth * 0.23 : screenWidth * 0.4,
                  height: screenWidth * 0.06,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD7D7D7),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: screenWidth * 0.04,
                        height: screenWidth * 0.04,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage("assets/images/currency_dollar.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.002),
                        child: Text(
                          "보유 코인: $coins",
                          style: TextStyle(
                            color: const Color(0xFF1A1A1A),
                            fontFamily: "NanumSquareRoundBold",
                            fontSize: screenWidth * 0.025,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // body: _children[pageIndex],
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 850) {
            // Layout for iPhone-sized screens
            // return const HomePage();
            return _children[pageIndex];
          } else {
            // Layout for computer screens
            return const DesktopLayout();
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(239, 239, 239, 1),
        selectedItemColor: const Color.fromRGBO(24, 24, 27, 1),
        unselectedItemColor: const Color.fromARGB(255, 114, 113, 113),
        currentIndex: pageIndex,
        onTap: (int index) {
          setState(() {
            pageIndex = index;
            getCoinFromServer();
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(
                "assets/images/info_page_icon.png",
              ),
            ),
            label: "설명서",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(
                "assets/images/home_page_icon.png",
              ),
            ),
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(
                "assets/images/my_page_icon.png",
              ),
            ),
            label: "마이페이지",
          ),
        ],
      ),
    );
  }
}
