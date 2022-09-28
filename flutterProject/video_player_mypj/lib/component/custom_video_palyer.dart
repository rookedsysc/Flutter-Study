import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

// 비디오 플레이어를 받아와서 화면에 띄워주는 Class
class CustomVideoPlayer extends StatefulWidget {
  // Image Picker에서 사용하는 Custom File Type
  final XFile video;

  const CustomVideoPlayer({required this.video, Key? key}) : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? videoController;

  @override
  void initState() {
    super.initState();

    // initState는 initializeController를 실행만하고 끝날 때 까지 기다리지 않음.
    initializeController();
  }

  // initState()에서 실행할 함수.
  initializeController() async {
    // 여기서 등장하는 file은 File 타입임.(File file)
    videoController = VideoPlayerController.file(

      // dart.io import 해줘야 사용 가능.
      // File은 String.path 형태인데 XFile에서 .path를 통해서 이를 추출할 수 있음.
      File(widget.video.path),
    );
    await videoController!.initialize();

    // 비디오 컨트롤러에 맞게 UI 컨트롤 해주기 위함.
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (videoController == null) {
      // videoController가 비어있으면 로딩바 띄워줌
      return CircularProgressIndicator();
    } else {
      return VideoPlayer(
        videoController!,
      );
    }
  }
}
