import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/layout/default_layout.dart';
import 'package:riverpod_sample/riverpod/future_provider.dart';

class FutureProviderScreen extends ConsumerWidget{
  const FutureProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(multipleFutureProvider);

    return DefaultLayout(
      title: 'FutureProviderScreen', 
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // date - 로딩이 끝나서 데이터가 있을 때 / error - 에러가 있을 때 / loading - 로딩 중일 때 실행
          state.when(data: (date) {
                  return Text(
                    date.toString(),
                    textAlign: TextAlign.center,
                  );
                },
                error: (err, Stack) => Text(err.toString()),
                loading: (() => const Center(child: CircularProgressIndicator())))
        ],
      )

    );
  }
}