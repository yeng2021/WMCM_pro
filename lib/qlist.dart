import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnswerQuestionScreen(),
    );
  }
}

class AnswerQuestionScreen extends StatefulWidget {
  @override
  _AnswerQuestionScreenState createState() => _AnswerQuestionScreenState();
}

class _AnswerQuestionScreenState extends State<AnswerQuestionScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> questions = [
    {'category': '보디빌딩', 'title': '가슴 운동 시에 어깨 통증을 어떻게 해결해야 할까요?', 'user': '서초동핫가이', 'time': '23분 전', 'isUrgent': true},
    {'category': '러닝', 'title': '질문 제목이 좀 길어서 박스가 두 줄이 됩니다.', 'user': '서초동핫가이', 'time': '20분 전', 'isUrgent': false},
    {'category': '보디빌딩', 'title': '질문 제목 ...', 'user': '서초동핫가이', 'time': '25분 전', 'isUrgent': false},
    {'category': '러닝', 'title': '질문 제목 ...', 'user': '서초동핫가이', 'time': '22분 전', 'isUrgent': true},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '답변하기',
          style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 13, weight: 30,),
          onPressed: () {
            // 뒤로가기 동작 추가
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Stack(
            children: [
              TabBar(
                controller: _tabController,
                labelColor: Color(0xff1A2B63),
                unselectedLabelColor: Colors.grey,
                indicatorColor: Color(0xff1A2B63),
                indicatorSize: TabBarIndicatorSize.tab, // 각 탭의 범위만큼 막대 표시
                tabs: [
                  Tab(text: '일반 질문'),
                  Tab(text: '빠른 질문'),
                  Tab(text: '지정 질문'),
                ],
              ),
              Positioned(
                right: MediaQuery.of(context).size.width / 30, // 탭 옆으로 이동
                top: 0, // 원이 상단에 걸리지 않도록 조정
                child: CircleAvatar(
                  radius: 10, // 동그라미 크기
                  backgroundColor: Color(0xff1A2B63),
                  child: Text(
                    '12',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 1,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildQuestionList(), // 일반 질문
                _buildQuestionList(), // 빠른 질문
                _buildQuestionList(), // 지정 질문
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionList() {
    List<Map<String, dynamic>> sortedQuestions = List.from(questions)
      ..sort((a, b) => b['isUrgent'] == true ? 1 : -1);

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: sortedQuestions.length,
      itemBuilder: (context, index) {
        var question = sortedQuestions[index];
        bool isUrgent = question['isUrgent'];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isUrgent ? Colors.red[50] : Colors.white,
              border: Border.all(
                color: isUrgent ? Colors.red : Colors.grey.shade300,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center, // y축 가운데 정렬
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isUrgent)
                        Text(
                          '🔥 답변 시간 임박 질문',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      Text(
                        question['category'],
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        question['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            question['user'],
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          SizedBox(width: 10),
                          Text(
                            question['time'],
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey[300], // 임시 이미지 박스
                  child: Icon(Icons.image, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
