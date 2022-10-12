import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:live_video_chat/const/agora.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

class CamScreen extends StatefulWidget {
  const CamScreen({Key? key}) : super(key: key);

  @override
  State<CamScreen> createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  RtcEngine? engine; // 아고라 api의 controller
  int? uid;
  int? othreUid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LIVE'),
      ),
      body: FutureBuilder(
          future: init(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                ),
              );
            }

            // 에러가 없는 상태인데 데이터도 없음.
            // 첫 실행 상태(첫 실행 이후엔 init에서 어떠한 데이터든 받아 왓을 것임.)
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            ;
            // 정상적으로 API가 호출된 경우
            return Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  renderMainView(),
                  // 나가기
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                        onPressed: () async {
                          if (engine != null) {
                            // 채널 나가기
                            await engine!.leaveChannel();
                          }

                          Navigator.of(context).pop();
                        },
                        child: Text('나가기 ')),
                  )
                ],
              ),
            );
          }),
    );
  }

  Widget renderMainView() {
    if (uid == null) {
      return Center(child: Text('채널에 입장하여주세요.'));
    } else {
      return RtcLocalView.SurfaceView();
    }
  }

  // 모든 권한을 여기서 컨트롤 함.
  Future<bool> init() async {
    // 리스트로 권한을 한 번에 요청함.
    // 권한을 요청할 수 있는 상황이라면 권한을 요청해주고 그게 아니라면 가지고 있는 권한을 return 해줌.
    final resp = await [Permission.camera, Permission.microphone].request();

    final cameraPermission = resp[Permission.camera];
    final micPermission = resp[Permission.microphone];

    if (cameraPermission != PermissionStatus.granted ||
        micPermission != PermissionStatus.granted) {
      throw '카메라 또는 마이크 권한이 없습니다.';
    }

    if (engine == null) {
      // Agora API 넣어줌.
      RtcEngineContext context = RtcEngineContext(myAppID);
      engine = await RtcEngine.createWithContext(context);
      // 특정 기능이 실행 되었을 때 특정 함수를 실행할 수 있음.(stream같은 기능)
      engine!.setEventHandler(
        RtcEngineEventHandler(
          joinChannelSuccess: (channel, uid, elapsed) {
            print("채널에 입장했습니다. uid : $uid");
            setState(() {
              this.uid = uid;
            });
          },
          leaveChannel: (state) {
            print('채널퇴장');
            setState(() {
              this.uid = null;
            });
          },
          userJoined: (uid, elapsed) {
            print('상대가 채널에 입장했습니다. uid : $uid');

            setState(() {
              this.othreUid = uid;
            });
          },
          userOffline: (uid, reason) {
            // reason : 유저가 나간 이유
            print('상대가 채널에서 나갔습니다. uid : $uid');
            setState(() {
              this.othreUid = null;
            });
          },
        ),
      );

      // 비디오 활성화
      await engine!.enableVideo();
      // 채널에 들어가기
      await engine!.joinChannel(myToken, myChannelName, null, 0);
    }
    return true;
  }
}
