import 'package:flutter/material.dart';
import 'package:lv2_actual/common/const/colors.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'asset/img/food/ddeok_bok_gi.jpg',
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '떡볶이',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                Text(
                  '전톡 떡볶이의 정석\n맛있습니다.dskjfhdskjf hsadjkfhsdajkfhewajrfhukas dfhkajsd fhdsaklfhasjkl fhwaekjlfgeasulf gauewlfhajslfd haskl haskl fhwilek gfkjeahf kjlshf kjsafh lkwsfh ewi hfueaksfhsauk',
                  maxLines: 2,
                  // ellipsis: '...',
                  // clip: 초과한 문자열 자름
                  // fade: 초과한 문자열을 흐릿하게 만듬A
                  // visible: 넘어가는 문자열 보이게 만듬
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: BODY_TEXT_COLOR,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  '10000',
                  style: TextStyle(
                      color: PRIMARY_COLOR,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
