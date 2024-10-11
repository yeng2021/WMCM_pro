import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuestionScreen(),
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff1A2B63), // 버튼 배경 색상
            foregroundColor: Colors.white, // 버튼 글자 색상
          ),
        ),
      ),
    );
  }
}

class QuestionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '답변하기',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.black, // 텍스트 색상을 검정으로 설정
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white, // AppBar 배경색을 흰색으로 설정
        elevation: 0, // AppBar의 기본 그림자 제거
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 15, color: Colors.black), // 아이콘 색상도 검정으로 변경
          onPressed: () {
            // 뒤로가기 동작 추가
          },
        ),
      ),
      body: Column(
        children: [
          // AppBar 밑에 그림자 효과를 주기 위한 Container
          Container(
            height: 1,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // 그림자 색상
                  spreadRadius: 1,
                  blurRadius: 10, // 그림자 흐림 정도
                  offset: Offset(0, 2), // 그림자의 위치
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Color(0xFFF1F1F1), // body 배경 색상 F1F1F1
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white, // 흰색 박스
                      borderRadius: BorderRadius.circular(0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 프로필 사진, 아이디, 날짜 및 시간
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey[300], // 프로필 사진 자리
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '서초동핫가이', // 아이디
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '02/04 16:24', // 작성 날짜와 시간
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16),

                        // 질문 제목
                        Text(
                          '가슴 운동 시에 어깨 통증을 어떻게 해결할까요?', // 질문 제목
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 8),

                        // 질문 내용
                        Text(
                          '첨부한 영상과 같이 가슴운동을 수행할 때 왼쪽 어깨가 조금 뜨는 느낌과 동시에 양쪽 어깨에 통증이 있습니다. 해당 머신이 제 몸이 맞지 않는 것인지 자세의 문제인지 답변 부탁드립니다.', // 질문 내용
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black45,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 16),

                        // 첨부된 영상의 미리보기
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: AssetImage('assets/video_preview.jpg'), // 임시 미리보기 이미지
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Icon(
                            Icons.play_circle_outline,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80, // 박스 높이
        width: double.infinity, // 박스 너비
        color: Colors.white, // 박스 배경색 흰색
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              // 답변하기를 누르면 팝업이 뜨는 부분
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    title: Center(
                      child: Text(
                        '답변을 배정받고 답변하지 않을 경우\n패널티가 부여됩니다.',
                        textAlign: TextAlign.center, // 텍스트 가운데 정렬
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    contentPadding: EdgeInsets.only(bottom: 10), // 텍스트 간 간격 줄이기 위해 패딩 조정
                    content: Text(
                      '답변 등록을 진행하시겠습니까?',
                      textAlign: TextAlign.center, // 텍스트 가운데 정렬
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    actionsAlignment: MainAxisAlignment.center, // 버튼 가운데 정렬
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: SizedBox(
                              width: 140, // 버튼 크기를 임의로 키움
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // 팝업 닫기
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(180, 50), // 취소 버튼 크기 설정
                                  backgroundColor: Colors.grey[300], // 취소 버튼 색상
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: Text(
                                  '취소',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), // 취소 버튼 텍스트 색상
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10), // 버튼 사이 간격
                          Flexible(
                            child: SizedBox(
                              width: 140, // 버튼 크기를 임의로 키움
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // 팝업 닫기
                                  // 이후 원래 답변 화면으로 이동하는 로직 추가 가능
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(180, 50), // 답변하기 버튼 크기 설정
                                  backgroundColor: Color(0xff1A2B63), // 답변하기 버튼 색상
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: Text(
                                  '답변하기',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), // 답변하기 버튼 텍스트 색상
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
            child: Text(
              '답변하기',
              style: TextStyle(fontWeight: FontWeight.bold), // 굵게 설정
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(325, 50), // 답변하기 버튼 크기 조정
              backgroundColor: Color(0xff1A2B63), // 배경 색상
              foregroundColor: Colors.white, // 글자 색상
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // 모서리 둥글기 조절
              ),
            ),
          ),
        ),
      ),
    );
  }
}
