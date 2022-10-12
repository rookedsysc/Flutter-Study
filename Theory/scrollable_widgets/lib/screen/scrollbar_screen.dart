import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_widgets/component/render_color_container.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

import '../component/render_numbers.dart';

class ScrollbarScreen extends StatelessWidget {
  const ScrollbarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "Scrollbar Screen",
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: renderNumbers
                .map(
                  (e) => RenderColorContainer(
                    index: e,
                    color: rainbowColors[e % rainbowColors.length],
                  ),
                )
                .toList(),
          ),
        ),
    ),
    );
  }
}
