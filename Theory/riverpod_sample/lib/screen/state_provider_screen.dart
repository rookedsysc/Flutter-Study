import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/layout/default_layout.dart';
import 'package:riverpod_sample/riverpod/state_provider.dart';

class StateRiverpodScreen extends ConsumerWidget {
  const StateRiverpodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // watch, read, listen만 씀
    final provider = ref.watch(numberProvider);

    return DefaultLayout(
      title: 'State Riverpod Screen', 
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              provider.toString(),
            ),
            ElevatedButton(
                onPressed: () {
                  ref.read(numberProvider.notifier).update((state) => state + 1);
                },
                child: Text('Up')),
                ElevatedButton(onPressed:() {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => _NextScreen())
                  );
                }, child: Text('Push'))
          ],
        ),
      ),
    );
  }
}

class _NextScreen extends ConsumerWidget{
  const _NextScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(numberProvider);
    return DefaultLayout(
      title: 'Next Screen', 
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              provider.toString(),
            ),
            ElevatedButton(
                onPressed: () {
                  ref.read(numberProvider.notifier).update((state) => state + 1);
                },
                child: Text('Up'))
          ],
        ),
      ),
    );
  }
}
