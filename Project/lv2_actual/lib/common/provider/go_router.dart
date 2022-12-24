import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lv2_actual/user/provider/auth_provider.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // 실제로 auth provider안에 의미 잇는 값이 변경되지는 않기 때문에 watch를 사용해도 되지만
  // 똑같은 GoRouter 인스턴스를 사용하고 있는게 중요하기 때문에 read를 사용함
  final provider = ref.read(authProvider);
  return GoRouter(
      routes: provider.routes,
      initialLocation: '/splash',
      refreshListenable: provider,
      redirect: provider.redirectLogic);
});
