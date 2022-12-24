import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lv2_actual/user/provider/user_me_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen ({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return Center(
      child: ElevatedButton(onPressed: (){
        debugPrint('로그아웃 버튼 클릭');
        ref.read(userMeProvider.notifier).logout();
      }, child: const Text('로그아웃')),
    );
  }
}