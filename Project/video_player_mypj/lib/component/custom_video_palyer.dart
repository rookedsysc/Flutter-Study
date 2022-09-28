import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

// 비디오 플레이어를 받아와서 화면에 띄워주는 Class
class CustomVideoPlayer extends StatefulWidget {
  // Image Picker에서 사용하는 Custom File Type
  final XFile video;
  final VoidCallback onNewVideoPressed; // 외부에서 실행시킬 비디오 파일의 path를 받아옴

  const CustomVideoPlayer({required this.video, required this.onNewVideoPressed, Key? key}) : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? videoController;
  Duration currentPosition = Duration();
  bool showControls = false; // 동영상 시작시에만 Stack 화면 보이게 구현

  @override
  void initState() {
    super.initState();

    // initState는 initializeController를 실행만하고 끝날 때 까지 기다리지 않음.
    initializeController();
  }

  @override
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget){
    super.didUpdateWidget(oldWidget);

    // oldWidget에 있던 video의 path와 현재 widget의 video의 path가 다르면 initializeController 재실행
    // 이는 동영상 실행창에 떠 있는 onNewVideoPressed에서 Video를 선택했을 때 initState()가 재실행되지 않아서(initState는 State를 생성할 때만 딱 한번 실행되기 때문)
    // 발생하는 버그를 고치기 위함임.
    if(oldWidget.video.path != widget.video.path) {
      initializeController(); //
    }

  }

  // initState()에서 실행할 함수.
  initializeController() async {
    // 새로운 영상 틀었을 때 Duration 새로 넣어줌.
    currentPosition = Duration();
    // 여기서 등장하는 file은 File 타입임.(File file)
    videoController = VideoPlayerController.file(
      // dart.io import 해줘야 사용 가능.
      // File은 String.path 형태인데 XFile에서 .path를 통해서 이를 추출할 수 있음.
      File(widget.video.path),
    );
    await videoController!.initialize();

    // 비디오 컨트롤러가 값이 바뀔 때마다 실행이 됨.
    // 슬라이더가 움직이지 않는 것을 해결해줌.
    videoController!.addListener(() {
      // 컨트롤러에서 가져온 position 값을 현재 값에 저장해줌.
      final currentPosition = videoController!.value.position;

      setState(() {
        this.currentPosition = currentPosition;
      });
    });
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
        child: GestureDetector(
          // 클릭하면 활성화 상태일 때 > 비활성화, 비활성화 상태일 때 > 활성화
          onTap: () {
            setState(() {
              showControls = !showControls;
            });
          },
          // Stack은 처음으로 들어간 값 위에다가 화면을 덧 씌워주는 Widget임.
          child: Stack(
            children: [
              VideoPlayer(
                videoController!,
              ),
              if (showControls) // if showControls가 true일 때만 아래 버튼 활성화
                _Controls(
                  onPlayPressed: onPlayPressed,
                  onForwardPressed: onForwardPressed,
                  onReversePressed: onReversePressed,
                  isPlaying: videoController!.value.isPlaying,
                ),
              if (showControls) _NewVideo(onPressed: widget.onNewVideoPressed), // showControls가 true일 때만 _NewVideo 실행
              _SliderBottom(
                  currentPosition: currentPosition,
                  maxPosition: videoController!.value.duration,
                  onSliderChanged: onSliderChanged)
            ],
          ),
        ),
      );
    }
  }

  void onSliderChanged(double context) {
    videoController!.seekTo(
      Duration(
        seconds: context.toInt(),
      ),
    );
  }
  void onReversePressed() {
    final currentPosition = videoController!.value.position;
    print(currentPosition);

    // 0초를 대입해줌.
    Duration position = Duration();
    if (currentPosition.inSeconds > 3) {
      // 3초보다 시간이 더 긴 경우에는
      position = currentPosition -
          Duration(seconds: 3); // 현재 길이보다 3초 더 짧은 position에 전달
    }

    // seeTo(Duration) : 해당하는 Duration의 위치로 영상 이동
    videoController!
        .seekTo(position); // 해당 Duration(현재 시간보다 3초 더 이른 position)의 위치로 비디오 이동.
  }

  void onForwardPressed() {
    final currentPosition = videoController!.value.position;
    final maxPosition = videoController!.value.duration; // 영상 전체 길이 가져옴.
    print('maxPosition : $maxPosition');

    // 0초를 대입해줌.
    Duration position = maxPosition;
    if ((maxPosition - Duration(seconds: 3)).inSeconds >
        currentPosition.inSeconds) {
      // (영상 전체 길이 - 3초)보다 현재 위치가 더 짧으면
      position = currentPosition +
          Duration(seconds: 3); // 현재 시간보다 3초 늦은 시간을 position에 대입해줌.
    }

    videoController!
        .seekTo(position); // 해당 Duration(현재 시간보다 3초 더 늦은 시간)의 위치로 비디오 이동.
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
      color: Colors.black.withOpacity(0.5),
      // withOpacity : 투명도를 추가함.
      // 이전 버전에서 버튼 이외의 곳을 눌러도 버튼이 동작하는 버그가 있었음. AxisAlignment의 Stretch로 인한 버그라 픽스함.
      height: MediaQuery.of(context).size.height,
      child: Row(
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

class _NewVideo extends StatelessWidget {
  const _NewVideo({required this.onPressed, Key? key}) : super(key: key);
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // Stack 내부에서 정렬할 때 사용.
    return Positioned(
      right: 0, // 오른쪽 끝에 배치.
      child: IconButton(
        onPressed: onPressed,
        color: Colors.white,
        iconSize: 30.0,
        icon: Icon(Icons.photo_camera_back),
      ),
    );
  }
}

class _SliderBottom extends StatelessWidget {
  const _SliderBottom(
      {required this.currentPosition,
      required this.maxPosition,
      required this.onSliderChanged,
      Key? key})
      : super(key: key);
  final Duration currentPosition;
  final Duration maxPosition;
  final ValueChanged<double> onSliderChanged;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      // 슬라이더 생성
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Row(
          children: [
            Text(
              // padLeft(minNumber, padding) : 글자에 패딩 넣어줌 첫번째 인스턴스에 들어간 숫자가 최소 글자의 길이고 만약 그 길이를 채우지 못하면 남은 글자를 padding으로 채워줌.
              '${currentPosition.inMinutes}:${(currentPosition.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(color: Colors.white),
            ),
            Expanded(
              child: Slider(
                value: currentPosition.inSeconds.toDouble(),
                onChanged: onSliderChanged,
                max: maxPosition.inSeconds.toDouble(),
                min: 0,
              ),
            ),
            Text(
              // padLeft(minNumber, padding) : 글자에 패딩 넣어줌 첫번째 인스턴스에 들어간 숫자가 최소 글자의 길이고 만약 그 길이를 채우지 못하면 남은 글자를 padding으로 채워줌.
              '${maxPosition.inMinutes}:${(maxPosition.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
