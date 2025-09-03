import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job/view/auth/login_view.dart';

import 'core/app_theme.dart';


void main() {

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
 
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Job Portal',
      theme: AppTheme.light,
      home: LoginView(),
    );
  }
}
