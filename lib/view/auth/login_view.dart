import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job/view/auth/sign_up_view.dart';

import '../../providers/auth_provider.dart';


class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});
  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose(); _password.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() => _loading = true);
    final err = await ref.read(localAuthProvider.notifier).signIn(email: _email.text.trim(), password: _password.text);
    setState(() => _loading = false);
    if (err == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login successful')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email')),
          TextField(controller: _password, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
          const SizedBox(height: 12),
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _loading ? null : _login, child: Text(_loading ? 'Please wait...' : 'Login'))),
          TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SignupView())), child: const Text('No account? Sign up'))
        ]),
      ),
    );
  }
}
