import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

final supportedLocales = [
  const Locale('en', 'US'),
  const Locale('ko', 'KR'),
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 초기화
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: supportedLocales,
        path: 'assets/translations',
        fallbackLocale: const Locale('en','US'),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,

      home: const HomeScreen(),
    );
  }
}


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Apple'.tr(),
            textAlign: TextAlign.center,
          ),
          Text(
            'example.world'.tr(),
            textAlign: TextAlign.center,
          ),
          Text(
            'example.helloWorld'.tr(),
            textAlign: TextAlign.center,
          ),
          Text(
            'needs'.tr(args: ['젓가락']),
            textAlign: TextAlign.center,
          ),

        ],
      ),
    );
  }
}
