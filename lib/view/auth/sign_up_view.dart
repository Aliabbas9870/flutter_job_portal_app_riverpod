import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job/view/home/home_view.dart';

import '../../providers/auth_provider.dart';

class SignupView extends ConsumerStatefulWidget {
  const SignupView({super.key});
  @override
  ConsumerState<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends ConsumerState<SignupView> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  String _role = 'jobseeker';
  bool _loading = false;

  @override
  void dispose() {
    _name.dispose(); _email.dispose(); _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _loading = true);
    final res = await ref.read(localAuthProvider.notifier).signUp(
      email: _email.text.trim(),
      password: _password.text,
      fullName: _name.text.trim(),
      role: _role,
    );
    setState(() => _loading = false);
    if (res == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Signup success")));
      Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeView()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(controller: _name, decoration: const InputDecoration(labelText: 'Full name')),
          TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email')),
          TextField(controller: _password, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
          const SizedBox(height: 8),
          DropdownButton<String>(
            value: _role,
            onChanged: (v) => setState(() => _role = v!),
            items: const [
              DropdownMenuItem(value: 'jobseeker', child: Text('Job Seeker')),
              DropdownMenuItem(value: 'recruiter', child: Text('Recruiter')),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _loading ? null : _submit, child: Text(_loading ? 'Please wait...' : 'Sign Up'))),
        ]),
      ),
    );
  }
}
