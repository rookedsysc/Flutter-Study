import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/layout/default_layout.dart';
import 'package:riverpod_sample/riverpod/stream_provider.dart';

class StreamProviderScreen extends ConsumerWidget{
  const StreamProviderScreen ({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(multipleStreamProvider);

    return DefaultLayout(
      title: 'Stream Provier Screen',
      body: Center(
          child: state.when(
        data: (data) {
          return Text(data.toString());
        },
        error: (err, Stack) {
          return Text(err.toString());
        },
        loading: (() => CircularProgressIndicator()),
      )),
    );
  }
}
