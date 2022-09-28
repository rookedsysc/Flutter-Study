import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../component/custom_video_palyer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: video == null ? renderEmpty() : renderVideo(),
    );
  }

  Widget renderVideo() {
    return Center(
      child: CustomVideoPlayer(
        // 애초에 실행되는 타이밍이 null이 아닐 경우에 실행되는 함수이므로 !를 붙여줌.
        video: video!,
      ),
    );
  }

  // 비어있는 상태일 때 표현되는 위젯
  Widget renderEmpty() {
    return Container(
      width: MediaQuery.of(context).size.width,
      // decoration과 color를 같이 사용하면 error 발생함.
      decoration: getBoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _Logo(
            onTap: onLogoTap,
          ),
          SizedBox(
            height: 30,
          ), // Padding 대신 사용.
          _AppName(),
        ],
      ),
    );
  }

  void onLogoTap() async {
    // 앱에서 사진을 선택할 때까지 기다려야 하므로 await 사용.
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);

    if(video != null) {
      setState(() {
        this.video = video; // video를 선택해줫으면 넣어줌.
      });
    }
  }

  BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      // RadialGradient는 가운데서부터 동그랗게 퍼지는 색상.
      gradient: LinearGradient(
        begin: Alignment.topCenter, // 어디서부터 시작하는지
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF2A3A7c), // 위에서부터 시작되는 색상
          Color(0xFF0001118) // 아래의 마지막 색상
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  final VoidCallback onTap;

  const _Logo({required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        'asset/image/logo.png',
        alignment: Alignment.center,
      ),
    );
  }
}

class _AppName extends StatelessWidget {
  const _AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
      fontWeight: FontWeight.w300,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "VIDEO",
          style: textStyle,
        ),
        Text(
          'PLAYER',
          // copyWith 덮어씌우기
          style: textStyle.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
