import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job/providers/auth_provider.dart';
import 'package:job/providers/job_provider.dart';


class PostJobView extends ConsumerStatefulWidget {
  const PostJobView({super.key});
  @override
  ConsumerState<PostJobView> createState() => _PostJobViewState();
}

class _PostJobViewState extends ConsumerState<PostJobView> {
  final _title = TextEditingController();
  final _company = TextEditingController();
  final _location = TextEditingController();
  final _salary = TextEditingController();
  final _desc = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _title.dispose(); _company.dispose(); _location.dispose(); _salary.dispose(); _desc.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _loading = true);
    final user = ref.read(localAuthProvider);
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login required')));
      setState(() => _loading = false);
      return;
    }
    await ref.read(jobProvider.notifier).addJob(
      recruiterId: user.id,
      title: _title.text.trim(),
      company: _company.text.trim(),
      location: _location.text.trim(),
      salary: _salary.text.trim(),
      description: _desc.text.trim(),
    );
    setState(() => _loading = false);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post Job')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(children: [
            TextField(controller: _title, decoration: const InputDecoration(labelText: 'Job title')),
            TextField(controller: _company, decoration: const InputDecoration(labelText: 'Company')),
            TextField(controller: _location, decoration: const InputDecoration(labelText: 'Location')),
            TextField(controller: _salary, decoration: const InputDecoration(labelText: 'Salary')),
            TextField(controller: _desc, decoration: const InputDecoration(labelText: 'Description'), maxLines: 5),
            const SizedBox(height: 12),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _loading ? null : _submit, child: Text(_loading ? 'Posting...' : 'Post Job'))),
          ]),
        ),
      ),
    );
  }
}
