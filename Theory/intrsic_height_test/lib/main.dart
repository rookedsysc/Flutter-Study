import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        renderCard(),
      ],
    ));
  }

  Widget renderCard() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: TestCard(),
          );
        }, childCount: 10),
      ),
    );
  }
}

class TestCard extends StatelessWidget {
  const TestCard({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset('asset/img/food/pizza_ddeok_bok_gi.jpg',
                width: 100, height: 100, fit: BoxFit.cover),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "떡볶이",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                Text(
                  "정말 맛있는 떡볶이 입니다!!",
                  maxLines: 2,
                  // ellipsis: '...',
                  // clip: 초과한 문자열 자름
                  // fade: 초과한 문자열을 흐릿하게 만듬A
                  // visible: 넘어가는 문자열 보이게 만듬
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  '₩ 9000',
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
