import 'package:flutter/material.dart';

class UsersScreen extends StatefulWidget {
  final List<String> users;
  final Set<String> following;
  final void Function(String username) onAddUser;
  final void Function(String username) onToggleFollow;

  const UsersScreen({
    super.key,
    required this.users,
    required this.following,
    required this.onAddUser,
    required this.onToggleFollow,
  });

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Add User', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Enter username',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            FilledButton(
              onPressed: () {
                final username = _controller.text.trim();
                if (username.isEmpty) return;
                widget.onAddUser(username);
                _controller.clear();
              },
              child: const Text('Add'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('People', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ...widget.users.map(
          (user) => Card(
            child: SwitchListTile(
              title: Text(user),
              subtitle: Text(widget.following.contains(user) ? 'Following' : 'Not following'),
              value: widget.following.contains(user),
              onChanged: (_) => widget.onToggleFollow(user),
            ),
          ),
        ),
      ],
    );
  }
}
