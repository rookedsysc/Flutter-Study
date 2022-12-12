import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Logger extends ProviderObserver {
  @override
  // update 되었을 때 호출되는 Provider
  void didUpdateProvider(ProviderBase provider, Object? previousValue, Object? newValue, ProviderContainer container) {
    debugPrint('[Provider Updated] provider: $provider, previousValue: $previousValue, newValue: $newValue, container: $container');
  }

  @override
  // 프로바이더를 추가하면 불리는 함수
  void didAddProvider(ProviderBase provider, Object? value, ProviderContainer container) {
    debugPrint("[Provider Added] provider: $provider, value: $value, container: $container");
  }
  

  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
    debugPrint("[Provider Disposed] provider: $provider, container: $container");
  }

  
}