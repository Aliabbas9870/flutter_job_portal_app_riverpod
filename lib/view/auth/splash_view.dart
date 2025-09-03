import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job/providers/auth_provider.dart';
import 'package:job/view/auth/login_view.dart';
import 'package:job/view/home/home_view.dart';



class SplashView extends ConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(localAuthProvider);
    // If null → show Login, else Home
    if (user == null) {
      return const LoginView();
    } else {
      return const HomeView();
    }
  }
}
