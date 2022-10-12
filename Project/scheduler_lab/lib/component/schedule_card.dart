import 'package:flutter/material.dart';
import 'package:scheduler_lab/const/colors.dart';

class ScheduleCard extends StatelessWidget {
  final int startTime;
  final int endTime;
  final String content;
  final Color color;
  const ScheduleCard({
    required this.color,
    required this.content,
    required this.startTime,
    required this.endTime, Key? key
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0, color: PRIMARY_COLOR
        ),
        borderRadius: BorderRadius.circular(8.0)
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: IntrinsicHeight( // Row에서 가장 높은 높이로 제한함.
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Time(startTime: startTime, endTime: endTime),
              SizedBox(height: 8,),
              _Content(content: content),
              _Category(color: color)
            ],
          ),
        ),
      ),
    );
  }
}

class _Time extends StatelessWidget {
  final int startTime;
  final int endTime;
  const _Time({required this.startTime, required this.endTime, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: PRIMARY_COLOR,
      fontSize: 12.0
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // padLeft(최대 글자 개수, '채워 넣을 글자)
        Text(
          '${startTime.toString().padLeft(2, '0')}:00',
          style: textStyle,
        ),
        Text(
          '${endTime.toString().padLeft(2, '0')}:00',
          style: textStyle.copyWith(fontSize: 8.0),
        )
      ],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.content, Key? key}) : super(key: key);
  final String content;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(content, style: TextStyle(fontSize: 16),),
    ));
  }
}

class _Category extends StatelessWidget {
  const _Category({required this.color, Key? key}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle
      ),
      width: 16.0,
        height: 16.0,
    );
  }
}
