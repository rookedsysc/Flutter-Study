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
      return AspectRatio(
        // 비디오의 원래 화면 비율 구현.
        aspectRatio: videoController!.value.aspectRatio,
        // Stack은 처음으로 들어간 값 위에다가 화면을 덧 씌워주는 Widget임.
        child: Stack(
          children: [
            VideoPlayer(
              videoController!,
            ),
            _Controls(
              onPlayPressed: onPlayPressed,
              onForwardPressed: onForwardPressed,
              onReversePressed: onReversePressed,
              isPlaying: videoController!.value.isPlaying,
            ),
            // Stack 내부에서 정렬할 때 사용.
            Positioned(
                right: 0, // 오른쪽 끝에 배치.
                child: IconButton(
                    onPressed: () {},
                    color: Colors.white,
                    iconSize: 30.0,
                    icon: Icon(Icons.photo_camera_back))),
          ],
        ),
      );
    }
  }

  void onReversePressed() {
    final currentPosition = videoController!.value.position;
    print(currentPosition);

    // 0초를 대입해줌.
    Duration position = Duration();
    if(currentPosition.inSeconds > 3) { // 3초보다 시간이 더 긴 경우에는
      position = currentPosition - Duration(seconds: 3); // 현재 길이보다 3초 더 짧은 position에 전달
    }

    // seeTo(Duration) : 해당하는 Duration의 위치로 영상 이동
    videoController!.seekTo(position);  // 해당 Duration(현재 시간보다 3초 더 이른 position)의 위치로 비디오 이동.
  }

  void onForwardPressed() {
    final currentPosition = videoController!.value.position;
    final maxPosition = videoController!.value.duration; // 영상 전체 길이 가져옴.
    print('maxPosition : $maxPosition');

    // 0초를 대입해줌.
    Duration position = maxPosition;
    if((maxPosition - Duration(seconds: 3)).inSeconds > currentPosition.inSeconds) { // (영상 전체 길이 - 3초)보다 현재 위치가 더 짧으면
      position = currentPosition + Duration(seconds: 3); // 현재 시간보다 3초 늦은 시간을 position에 대입해줌.
    }

    videoController!.seekTo(position);  // 해당 Duration(현재 시간보다 3초 더 늦은 시간)의 위치로 비디오 이동.
  }

  void onPlayPressed() {
    // 이미 실행중이면 중지
    // 실행중이 아니면 실행, 값이 변할 때 마다 setState((){})에 넣어서 실행해줌.
    setState(() {
      if (videoController!.value.isPlaying) {
        videoController!.pause();
      } else {
        videoController!.play();
      }
    });
  }
}

class _Controls extends StatelessWidget {
  final VoidCallback onPlayPressed;
  final VoidCallback onReversePressed;
  final VoidCallback onForwardPressed;
  final bool isPlaying;

  const _Controls(
      {required this.onPlayPressed,
      required this.onForwardPressed,
      required this.onReversePressed,
      required this.isPlaying,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5), // withOpacity : 투명도를 추가함.
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          renderIconButton(
            onPressed: onReversePressed,
            iconData: Icons.rotate_left,
          ),
          renderIconButton(
            onPressed: onPlayPressed,
            iconData: isPlaying ? Icons.pause : Icons.play_arrow,
          ),
          renderIconButton(
            onPressed: onForwardPressed,
            iconData: Icons.rotate_right,
          ),
        ],
      ),
    );
  }

  Widget renderIconButton(
      {required VoidCallback onPressed, required IconData iconData}) {
    return IconButton(
      onPressed: onPressed,
      iconSize: 30.0,
      color: Colors.white,
      icon: Icon(iconData),
    );
  }
}
