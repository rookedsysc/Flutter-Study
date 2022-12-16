import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lv2_actual/common/const/colors.dart';
import 'package:collection/collection.dart';

class RatingCard extends StatelessWidget {
  // 프로필 사진
  final ImageProvider avatarImage;
  // 리스트로 위젯 이미지를 보여줄 때
  final List<Image> images;
  // 별점
  final int rating;
  // 이메일
  final String email;
  // 리뷰 내용
  final String content;
  const RatingCard(
      {
      // 프로필 사진
      required this.avatarImage,
      // 리스트로 위젯 이미지를 보여줄 때
      required this.images,
      // 별점
      required this.rating,
      // 이메일
      required this.email,
      // 리뷰 내용
      required this.content,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _header(),
        const SizedBox(
          height: 8.0,
        ),
        _body(),
        if (images.length > 0) SizedBox(height: 100.0, child: _images())
      ],
    );
  }

  Widget _header() {
    return Row(
      children: [
        CircleAvatar(backgroundImage: avatarImage),
        SizedBox(width: 16.0),
        Expanded(
          child: Text(
            email,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.w500),
          ),
        ),
        ...List.generate(
          5,
          (index) => index < rating
              ? Icon(
                  Icons.star,
                  color: PRIMARY_COLOR,
                )
              : Icon(
                  Icons.star_border_outlined,
                  color: PRIMARY_COLOR,
                ),
        ),
      ],
    );
  }

  Widget _body() {
    return Row(
      children: [
        Flexible(
          child: Text(content, style: TextStyle(color: BODY_TEXT_COLOR, fontSize:14.0),),
        ),
      ],
    );
  }

  Widget _images() {
    return ListView(
      physics: const PageScrollPhysics(),
      // 좌우 스크롤로 변경하는 순간 높이를 지정해줘야 함
      scrollDirection: Axis.horizontal,
      children: [
        ...images.mapIndexed(
          (index, e) => Padding(
            // 마지막 이미지를 제외한 이미지에 패딩을 줌
            padding: EdgeInsets.all(index == images.length - 1 ? 0.0 : 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: e,
            ),
          ),
        ).toList(),


      ],
    );
  }
}
