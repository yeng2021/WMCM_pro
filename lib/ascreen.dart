import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnswerScreen(),
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

class AnswerScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // 사진 첨부 버튼 동작
                          },
                          icon: Icon(Icons.image, color: Colors.white),
                          label: Row(
                            children: [
                              Text(
                                '사진 첨부',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold, // 굵게 설정
                                  fontSize: 16, // 기존 크기 유지
                                ),
                              ),
                              SizedBox(width: 5), // 텍스트 간격 조절
                              Text(
                                '(최대 3장)',
                                style: TextStyle(
                                  fontSize: 8, // 더 작은 크기로 설정
                                ),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff1A2B63), // 배경 색상
                            foregroundColor: Colors.white, // 글자 색상
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8), // 모서리 둥글기 조절
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 12, // 위아래 여백
                              horizontal: 10, // 양옆 여백
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10), // 버튼 간 간격 추가
                      Flexible(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // 영상 첨부 버튼 동작
                          },
                          icon: Icon(Icons.videocam, color: Colors.white),
                          label: Row(
                            children: [
                              Text(
                                '영상 첨부',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold, // 굵게 설정
                                  fontSize: 16, // 기존 크기 유지
                                ),
                              ),
                              SizedBox(width: 5), // 텍스트 간격 조절
                              Text(
                                '(최대 30초)',
                                style: TextStyle(
                                  fontSize: 8, // 더 작은 크기로 설정
                                ),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff1A2B63), // 배경 색상
                            foregroundColor: Colors.white, // 글자 색상
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8), // 모서리 둥글기 조절
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 12, // 위아래 여백
                              horizontal: 9, // 양옆 여백
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 200, // 원하는 높이를 설정 (예: 200)
                    child: TextFormField(
                      controller: _controller,
                      maxLines: null, // 자동으로 줄바꿈이 되도록 설정
                      expands: true, // 부모의 높이에 맞게 확장
                      decoration: InputDecoration(
                        hintText:
                        '질문에 대한 답변을 입력해주세요!\n(최소 100자 이상 작성해주셔야 합니다.)',
                        hintStyle: TextStyle(
                          fontSize: 14, // 원하는 글자 크기
                          color: Colors.grey, // 원하는 색상
                        ),
                        fillColor: Colors.white, // 배경색을 흰색으로 설정
                        filled: true, // 배경색 활성화
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff1A2B63), // 외곽선 색상
                            width: 2.0, // 외곽선 두께
                          ),
                        ),
                        alignLabelWithHint: true, // 힌트 텍스트가 위쪽에 오도록 설정
                        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0), // 텍스트 필드 안에서 좌측 상단 배치
                      ),
                      textAlignVertical: TextAlignVertical.top, // 텍스트가 좌측 상단에 배치되도록 설정
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '전문가 본인이 아닌 경우, 부적절한 답변, 욕설, 성적 수치심을 주는 말 등은 규정에 따라 이용 제재 및 처벌을 받을 수 있으므로 성실한 답변 부탁드립니다.',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80, // 박스 높이
        width: 393, // 박스 너비
        color: Colors.white, // 박스 배경색 흰색
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              // 답변하기 버튼 동작
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
