import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job/core/app_color.dart';
import 'package:job/providers/auth_provider.dart';
import 'package:job/view/auth/login_view.dart';
import 'package:job/view/home/home_view.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _scaleAnim = Tween<double>(begin: 0.7, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    Timer(const Duration(seconds: 3), () {
      final user = ref.read(localAuthProvider);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => user == null ? const LoginView() : const HomeView(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary,
              AppColors.secondary,
              AppColors.background,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: ScaleTransition(
              scale: _scaleAnim,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 🔹 App Logo
                  const Icon(Icons.work, size: 100, color: AppColors.accent),

                  const SizedBox(height: 20),

                  // 🔹 App Name
                  const Text(
                    "Job Portal",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // 🔹 Tagline
                  const Text(
                    "Find your dream job easily",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
