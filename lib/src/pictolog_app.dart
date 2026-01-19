import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pictolog/src/constants/app_color.dart';
import 'package:pictolog/src/router/app_router.dart';

class PictologApp extends HookConsumerWidget {
  const PictologApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
      theme: ThemeData(
        scaffoldBackgroundColor: context.colors.background,
      ),
    );
  }
}
