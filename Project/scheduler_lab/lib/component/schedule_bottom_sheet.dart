import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_time_patterns.dart';
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

    return SafeArea(
      child: Container(
        // container 높이에도 키보드 사이즈만큼 늘려줘야 함.
        height: MediaQuery.of(context).size.height / 2 + bottomInsets,
        // color: Colors.white,
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
      ),
    );
  }
}

class _Time extends StatefulWidget {
  const _Time({Key? key}) : super(key: key);

  @override
  State<_Time> createState() => _TimeState();
}

class _TimeState extends State<_Time> {
  DateTime? minimumDay = DateTime.now();
  DateTime? maximumDay = DateTime(3000);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Row(
        children: [
          _CompactDatePicker(true, ),
          SizedBox(
            width: 8.0,
          ),
          _CompactDatePicker(false,)
        ],
      ),
    );
  }

  Widget _CompactDatePicker(bool isStart) {
    return Expanded(
        child: Column(children: [
          DateTimePicker(
            // Design
            decoration: InputDecoration(
              icon: Icon(
                Icons.event,
                color: PRIMARY_COLOR,
              ),
              focusColor: PRIMARY_COLOR,
              // 입력시 밑 줄 색상 변경
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: PRIMARY_COLOR)),
              labelStyle: TextStyle(),
            ),
            dateLabelText: isStart ? '시작일' : '마감일',
            cursorColor: PRIMARY_COLOR,
            // 캘린더 선택 위에 글자 입력할 수 있는 Edit Buttom 사라짐.
            initialEntryMode: DatePickerEntryMode.calendarOnly,

            type: DateTimePickerType.date,
            dateMask: 'yyyy-MM-dd',
            initialDate: minimumDay,
            firstDate: isStart ? DateTime.now() : minimumDay,
            lastDate: isStart ? maximumDay : DateTime(3000),
            onChanged: (val) {
              print('value : $val');
              DateTime selectedDay = DateTime(
                // 문자열 int로 치환.
                int.parse(val.split('-')[0]), // 년
                int.parse(val.split('-')[1]), // 월
                int.parse(val.split('-')[2]), // 일
              );
              setState(() {
                // 시작일의 lastDate가 마감일의 lastDate를 넘지 않게 해줌.
                if (!isStart) {
                  maximumDay = selectedDay;
                }

                // 마감일의 firstDate가 시작일의 firstDate보다 작지 않게 해줌.
                minimumDay = selectedDay;
              });
        },
      ),
    ]));
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: '내용',
      isTime:false,
    );
  }
}
class _ColorPicker extends StatelessWidget {
  const _ColorPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Wrap(
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
      ),
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

