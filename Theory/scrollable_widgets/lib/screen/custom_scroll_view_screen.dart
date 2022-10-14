import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_widgets/component/render_color_container.dart';
import 'package:scrollable_widgets/const/colors.dart';

class CustomScrollViewScreen extends StatelessWidget {
  const CustomScrollViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            renderSliverAppBar(),
            renderHeader(),
            renderBox(),
            renderHeader(),
            renderBuilderSliverList(),
            renderHeader(),
            renderSliverGrid(),
                      ],
        ),
      ),
    );
  }

  SliverToBoxAdapter renderBox() {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        height: 50,
        child: Text(
          '이건 되지롱 !!!!!',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }


  SliverList renderBuilderSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return RenderColorContainer(
              index: index, color: rainbowColors[index % rainbowColors.length]);
        },
        childCount: 14, // itemCount와 유사함
      ),
    );
  }

  SliverGrid renderSliverGrid() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return RenderColorContainer(
              index: index, color: rainbowColors[index % rainbowColors.length]);
        },
        childCount: 100, // itemCount와 유사함
      ),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    );
  }

  SliverPersistentHeader renderHeader() {
    return SliverPersistentHeader(
      pinned: true, //
      delegate: _SliverFixedHeaderDelegate(
          child: Container(
            color: Colors.black,
            child: Center(
              child: Text(
                '신기하지~',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          maxHeight: 200,
          minHeigt: 50),
    );
  }

  SliverAppBar renderSliverAppBar() {
    return SliverAppBar(
      // true로 하면위로 잠깐 스크롤하면 AppBar 나타남.
      floating: true,
      // flaoting True 상태로 사용, true시 조금만 스크롤해도 AppBar 움직임.
      snap: true,

      // 맨 위에서 한계 이상으로 스크롤 했을 때 Scaffold 대신 Appbar가 차지함.
      stretch: true,
      // true로 하면 위에 AppBar 고정됨.
      pinned: false,

      expandedHeight: 400,
      // 최대로 늘어나는 사이즈
      collapsedHeight: 100,
      // 접혔을 때 사이즈
      // 늘어났을 때 보여지는 공간
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset('asset/img/image_1.jpeg', fit: BoxFit.cover),
        title: Text(
          'FlexibleSpaceBar',
          style: TextStyle(color: Colors.black),
        ),
      ),
      title: Text('Custom Scroll View Screen'),
    );
  }
}

class _SliverFixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeigt;

  _SliverFixedHeaderDelegate({
    required this.child,
    required this.maxHeight,
    required this.minHeigt,
  });

  // 실제로 build 하는 부분
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  // 최대 높이
  @override
  double get maxExtent => maxHeight;

  // 최소 높이
  @override
  double get minExtent => minHeigt;

  // oldDelegate - build가 실행이 됐을 때 이전 Delegate
  // return 값이 true면 재빌드 함
  @override
  bool shouldRebuild(_SliverFixedHeaderDelegate oldDelegate) {
    return oldDelegate.minHeigt != minHeigt ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.child != child;
  }
}
