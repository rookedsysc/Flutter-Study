import 'package:flutter/material.dart';
import 'package:live_video_chat/screen/cam_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100]!,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(child: _Logo()),
              Expanded(child: _Imgae()),
              Expanded(child: _EntryButton()),
            ],
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius:
              BorderRadius.circular(16.0), // 둥글게 해줌, 숫자가 크면 클수록 더 둥글어짐.
          // 그림자 넣을 수 있음.
          boxShadow: [
            BoxShadow(
              color: Colors.blue[300]!,
              blurRadius: 12.0, // blur가 형성되는 크기
              spreadRadius: 2.0, // 그림자가 퍼지는 정도
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.videocam,
                color: Colors.white,
                size: 40.0,
              ),
              SizedBox(
                width: 12.0,
              ),
              Text(
                'LIVE',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    letterSpacing: 4.0 // 글자 사이의 간격
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Imgae extends StatelessWidget {
  const _Imgae({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset('asset/img/home_img.png'),
    );
  }
}

class _EntryButton extends StatelessWidget {
  const _EntryButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CamScreen(),
                ),
              );
            },
            child: Text('입장하기')),
      ],
    );
  }
}
