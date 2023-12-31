import 'package:flutter/material.dart';
import 'package:ssu_meet/dialogs/main_post_it_dialog.dart';

Scaffold MainPagePostIt(
  double screenHeight,
  AsyncSnapshot<List<dynamic>> snapshot,
  double screenWidth,
) {
  return Scaffold(
    body: SizedBox(
      height: screenHeight * 0.7,
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: snapshot.data!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
          childAspectRatio: 1 / 1, //item 의 가로 1, 세로 1 의 비율
          mainAxisSpacing: 10, //수평 Padding
          crossAxisSpacing: 10,
          //수직 Padding
        ),
        itemBuilder: (BuildContext context, int index) {
          var postIt = snapshot.data![index];
          var stickyId = postIt["stickyId"];
          // var sex = postIt["stickyData"]["sex"];
          // var birthDate = postIt["stickyData"]["birthDate"];
          var age = postIt["stickyData"]["age"];
          // var college = postIt["stickyData"]["college"];
          var major = postIt["stickyData"]["major"];
          var height = postIt["stickyData"]["height"];
          var instaId = postIt["stickyData"]["instaId"];
          var kakaoId = postIt["stickyData"]["kakaoId"];
          var phoneNumber = postIt["stickyData"]["phoneNumber"];
          var nickname = postIt["stickyData"]["nickname"];
          var mbti = postIt["stickyData"]["mbti"];
          var hobbies = postIt["stickyData"]["hobbies"];
          var ideals = postIt["stickyData"]["ideals"];
          var introduce = postIt["stickyData"]["introduce"];
          // return Text(index.toString());
          // Future<String> nickname = getPostItFrontNickname(index);
          // var age = getPostItFrontData(index)["age"];
          // var mbti = getPostItFrontData(index)["mbti"];
          // var hobby = getPostItFrontData(index)["hobby"];
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return MainPostItDialog(
                    stickyId: stickyId,
                    nickname: nickname,
                    age: age,
                    major: major,
                    mbti: mbti,
                    height: height,
                    hobbies: hobbies,
                    introduce: introduce,
                    instaId: instaId,
                    kakaoId: kakaoId,
                    phoneNumber: phoneNumber,
                    ideals: ideals,
                  );
                },
              );
              // print("Tapped Post It (id: $stickyId)");
              // print("Tapped Post It (age: $age)");
              // print("Tapped Post It (instaId: $instaId)");
            },
            child: Center(
              child: Container(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    // First image

                    Image(
                      image: const AssetImage(
                          "assets/images/images2/yellowpostit.png"),
                      width: screenWidth * 0.4,
                      height: screenWidth * 0.4,
                    ),

                    // Second image overlapped on top of the first image
                    Positioned(
                      left: screenWidth * 0.1,
                      top: screenWidth * -0.07,
                      child: Image(
                        width: screenWidth * 0.2,
                        height: screenWidth * 0.2,
                        image: const AssetImage(
                            "assets/images/images2/tape10.png"),
                      ),
                    ),
                    Positioned(
                      top: screenWidth * 0.1,
                      left: screenWidth * 0.1,
                      child: SizedBox(
                        height: screenWidth * 0.2,
                        width: screenWidth * 0.2,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "닉네임: $nickname",
                                style: TextStyle(
                                  fontFamily: "Nanum_Ogbice",
                                  fontSize: screenWidth * 0.04,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "나이: $age",
                                style: TextStyle(
                                  fontFamily: "Nanum_Ogbice",
                                  fontSize: screenWidth * 0.04,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "MBTI: $mbti",
                                style: TextStyle(
                                  fontFamily: "Nanum_Ogbice",
                                  fontSize: screenWidth * 0.04,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "취미 1: ${hobbies.length >= 1 ? hobbies[0] : 'x'}",
                                style: TextStyle(
                                  fontFamily: "Nanum_Ogbice",
                                  fontSize: screenWidth * 0.04,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "취미 2: ${hobbies.length >= 2 ? hobbies[1] : 'x'}",
                                style: TextStyle(
                                  fontFamily: "Nanum_Ogbice",
                                  fontSize: screenWidth * 0.04,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "취미 3: ${hobbies.length >= 3 ? hobbies[2] : 'x'}",
                                style: TextStyle(
                                  fontFamily: "Nanum_Ogbice",
                                  fontSize: screenWidth * 0.04,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}
