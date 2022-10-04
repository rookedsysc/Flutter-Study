import 'package:flutter/material.dart';

class ScheduleBottomSheet extends StatelessWidget {
  const ScheduleBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // viewInset: 시스템 UI가 차지하는 크기
    final bottomInsets = MediaQuery.of(context).viewInsets.bottom;

    return Container(
        height: MediaQuery.of(context).size.height / 2,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomInsets),
          child: Column(
            children: [TextField()],
          ),
        ));
  }
}
