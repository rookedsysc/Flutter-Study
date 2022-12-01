import 'package:flutter/material.dart';
import 'package:lv2_actual/common/const/colors.dart';
import 'package:lv2_actual/common/layout/default_layout.dart';

class RootTab extends StatelessWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Center(
        child: Text('Root Tabk'),
      ),
    );
  }
}

