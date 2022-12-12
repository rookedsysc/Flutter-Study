import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod/riverpod.dart';


final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return FlutterSecureStorage();
});