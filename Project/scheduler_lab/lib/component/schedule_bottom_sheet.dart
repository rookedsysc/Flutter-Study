import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:scheduler_lab/component/custom_text_field.dart';
import 'package:scheduler_lab/const/colors.dart';

class ScheduleBottomSheet extends StatelessWidget {
  const ScheduleBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // viewInset: 시스템 UI가 차지하는 크기
    final bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    print('bottomInsets : $bottomInsets');

    return Container(
      // container 높이에도 키보드 사이즈만큼 늘려줘야 함.
      height: MediaQuery.of(context).size.height / 2 + bottomInsets,
      color: Colors.white,
      child: Padding(
        // 키보드 만큼의 바텀 패딩을 줌.
        padding: EdgeInsets.only(bottom: bottomInsets),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Time(),
            SizedBox(
              height: 8.0,
            ),
            _Content(),
            SizedBox(
              height: 8,
            ),
            _ColorPicker(),
            SizedBox(height: 4.0,),
            _SaveButton()
          ],
        ),
      ),
    );
  }
}

class _Time extends StatelessWidget {
  const _Time({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CustomTextField(
              label: '시작 시간',
            )),
        SizedBox(
          width: 8.0,
        ),
        Expanded(
            child: CustomTextField(
              label: '마감 시간',
            ))

      ],
    );
  }
}
class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: '내용',
    );
  }
}
class _ColorPicker extends StatelessWidget {
  const _ColorPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0, // child 사이사이의 간격.
      runSpacing: 8.0, // 위 아래 간격.
      children: [
        renderColor(Colors.red),
        renderColor(Colors.orange),
        renderColor(Colors.yellow),
        renderColor(Colors.orange),
        renderColor(Colors.green),
        renderColor(Colors.blue),
        renderColor(Colors.indigo),
      ],
    );
  }
  Widget renderColor(Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle

      ),
      width: 32, height: 32,
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Row(
        children: [
          Expanded(
              child: ElevatedButton(
                  onPressed: () {},
                  style:
                      ElevatedButton.styleFrom(primary: PRIMARY_COLOR),
                  child: Text('Save'))),
        ],
      ),
    );
  }
}
