import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job/model/user_profile.dart';
import 'package:job/providers/auth_provider.dart';



class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});
  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  final _name = TextEditingController();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    final user = ref.read(localAuthProvider);
    _name.text = user?.fullName ?? '';
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _loading = true);
    final current = ref.read(localAuthProvider);
    if (current == null) return;
    final updated = UserProfile(
      id: current.id,
      email: current.email,
      password: current.password,
      fullName: _name.text.trim(),
      role: current.role,
      createdAt: current.createdAt,
    );
    // await ref.read(localAuthProvider.notifier).updateProfile(updated);
    await ref.read(localAuthProvider.notifier).refresh();
    setState(() => _loading = false);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated')));
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(localAuthProvider);
    if (user == null) return const Scaffold(body: Center(child: Text('Not logged in')));
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Text('Email: ${user.email}'),
          const SizedBox(height: 8),
          TextField(controller: _name, decoration: const InputDecoration(labelText: 'Full name')),
          const SizedBox(height: 12),
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _loading ? null : _save, child: Text(_loading ? 'Saving...' : 'Save'))),
        ]),
      ),
    );
  }
}
