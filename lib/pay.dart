import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // 천 단위 쉼표를 위해 intl 패키지 사용

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CoinPurchaseScreen(),
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF1F1F1), // body 색상
        colorScheme: ColorScheme.fromSwatch().copyWith(
          surfaceTint: Color(0xFFFFFFFF), // surface tint color
        ),
      ),
    );
  }
}

class CoinPurchaseScreen extends StatefulWidget {
  @override
  _CoinPurchaseScreenState createState() => _CoinPurchaseScreenState();
}

class _CoinPurchaseScreenState extends State<CoinPurchaseScreen> {
  int selectedCoinIndex = -1; // 선택된 코인 상품의 인덱스

  final List<Map<String, dynamic>> coinOptions = [
    {'coin': 50000, 'discount': 20, 'originalPrice': 50000, 'discountedPrice': 42000},
    {'coin': 25000, 'discount': 10, 'originalPrice': 25000, 'discountedPrice': 22500},
    {'coin': 10000, 'discount': 5, 'originalPrice': 10000, 'discountedPrice': 9500},
    {'coin': 5000, 'originalPrice': 5000}, // 5000 코인 상품
  ];

  // 천 단위 쉼표를 찍어주는 함수
  String formatCurrency(int value) {
    final formatter = NumberFormat("#,###");
    return formatter.format(value);
  }

  double gapBetweenPriceAndDiscount = 8.0; // 가격과 할인 텍스트 간 간격 조정 가능

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '와코 코인 구매',
          style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // 현재 나의 코인 정보
          Container(
            color: Color(0xFFC5D3FF),
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '현재 나의 코인',
                  style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Image.asset('assets/coin_icon.png', width: 20, height: 20), // 코인 아이콘
                    SizedBox(width: 8),
                    Text(
                      '99,999', // 임시 코인 수량, 이미 쉼표 있음
                      style: TextStyle(fontSize: 20, color: Color(0xff1A2B63), fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: coinOptions.length,
              itemBuilder: (context, index) {
                bool isSelected = selectedCoinIndex == index;
                Map<String, dynamic> option = coinOptions[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCoinIndex = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 16),
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 16),
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xFFE6E8EF) : Colors.white, // 선택된 경우 색상 C5D3FF, 선택되지 않은 경우 흰색
                      border: Border.all(
                        color: isSelected ? Color(0xFF1A43CA) : Colors.transparent, // 선택된 경우 외곽선 1A43CA
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${formatCurrency(option['coin'])}', // 숫자 부분
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: ' 코인', // '코인' 텍스트 부분
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF777777)),
                                  ),
                                ],
                              ),
                            ),
                            if (index == 3) // 5000 코인 박스는 하단에만 가격 표시
                              SizedBox.shrink()
                            else
                              Text(
                                '${formatCurrency(option['originalPrice'])}', // 가격에 쉼표 적용, '원' 제거
                                style: TextStyle(
                                  fontSize: 14, // 5000 코인 상품 외의 경우
                                  fontWeight: FontWeight.normal,
                                  color: isSelected ? Colors.black45 : Colors.grey,
                                  decoration: option.containsKey('discount') ? TextDecoration.lineThrough : null,
                                ),
                              ),
                          ],
                        ),
                        if (index != 3) ...[
                          SizedBox(height: gapBetweenPriceAndDiscount), // 가격과 할인 텍스트 간 간격
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (option.containsKey('discount'))
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '${option['discount']}%',
                                        style: TextStyle(fontSize: 14, color: Colors.blue), // 할인율 색상
                                      ),
                                      TextSpan(
                                        text: ' 할인 가격으로 충전하기!',
                                        style: TextStyle(fontSize: 14, color: Color(0xFF777777)), // '할인 가격으로 충전하기' 텍스트 색상
                                      ),
                                    ],
                                  ),
                                ),
                              if (option.containsKey('discountedPrice'))
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '${formatCurrency(option['discountedPrice'])}', // 숫자 부분에 쉼표 적용
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                                      ),
                                      TextSpan(
                                        text: ' 원', // '원' 텍스트 부분 색상 적용
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF777777)),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ],
                        if (index == 3) // 5000 코인 상품에만 Align을 이용하여 하단에 가격 표시
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20), // 텍스트를 아래로 더 내림
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${formatCurrency(option['originalPrice'])}', // 5000원 숫자만 표시
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' 원', // '원' 텍스트 추가
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF777777),
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
                );
              },
            ),
          ),
          // 구매하기 버튼 아래 흰색 박스 추가
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: ElevatedButton(
              onPressed: selectedCoinIndex != -1 ? () {
                // 결제 처리 로직 추가
                print('구매하기 버튼 클릭됨!');
              } : null, // 아무것도 선택되지 않으면 버튼 비활성화
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Color(0xff1A2B63),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                '구매하기',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
