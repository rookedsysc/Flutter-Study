import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/layout/default_layout.dart';
import 'package:riverpod_sample/riverpod/select_provider.dart';

class SelectProviderScreen extends ConsumerWidget{
  const SelectProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build');
    final state = ref.watch(selectProvider.select((value) => value.isSpicy));
    ref.listen(selectProvider.select((value) => value.hasBought), (previous, next) { 
      print("previoud : $previous, next : $next");
    });

    return DefaultLayout(
      title: 'Select Provider Screen', 
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            // select로 선택이 되어 있기 때문에 state는 isSpicy 값임
            Text(state.toString()), 
            /* Text(state.name),
            Text(state.isSpicy.toString()),
            Text(state.hasBought.toString()), */
            ElevatedButton(onPressed: (){
              ref.read(selectProvider.notifier).toggleIsSpicy();
            }, child: Text('Spicy Toggle')),
            ElevatedButton(onPressed: (){
                ref.read(selectProvider.notifier).toggleHasBought();
              }, child: Text('Bought Toggle')) 
          ],
        ),
      )
      );
  }
}
