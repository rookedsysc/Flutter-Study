import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class CamScreen extends StatefulWidget {
  const CamScreen({Key? key}) : super(key: key);

  @override
  State<CamScreen> createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
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
            return Center(
              child: Text("권한이 있습니다."),
            );
          }),
    );
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
    return true;
  }
}
