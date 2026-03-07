import 'package:flutter/material.dart';

import '../models/target_goal.dart';

class TargetScreen extends StatefulWidget {
  final List<TargetGoal> targets;
  final void Function(TargetGoal target) onAddTarget;

  const TargetScreen({
    super.key,
    required this.targets,
    required this.onAddTarget,
  });

  @override
  State<TargetScreen> createState() => _TargetScreenState();
}

class _TargetScreenState extends State<TargetScreen> {
  final _titleController = TextEditingController();
  final _categoryController = TextEditingController();
  final _countController = TextEditingController();
  final _tagsController = TextEditingController();
  TargetFrequency _frequency = TargetFrequency.daily;
  IconData _icon = Icons.flag;

  final _iconOptions = const {
    'YouTube': Icons.play_circle,
    'LeetCode': Icons.code,
    'Manual': Icons.check_circle,
    'Book': Icons.menu_book,
  };

  @override
  void dispose() {
    _titleController.dispose();
    _categoryController.dispose();
    _countController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Add Target', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: _titleController,
          decoration: const InputDecoration(labelText: 'Target title', border: OutlineInputBorder()),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _categoryController,
          decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<TargetFrequency>(
          value: _frequency,
          decoration: const InputDecoration(labelText: 'Frequency', border: OutlineInputBorder()),
          items: const [
            DropdownMenuItem(value: TargetFrequency.daily, child: Text('Daily')),
            DropdownMenuItem(value: TargetFrequency.weekly, child: Text('Weekly')),
            DropdownMenuItem(value: TargetFrequency.manual, child: Text('Manual')),
          ],
          onChanged: (value) => setState(() => _frequency = value ?? TargetFrequency.daily),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _countController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Count (example: 3 for weekly YouTube posts)',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _tagsController,
          decoration: const InputDecoration(labelText: 'Tags (comma separated)', border: OutlineInputBorder()),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<IconData>(
          value: _icon,
          decoration: const InputDecoration(labelText: 'Icon', border: OutlineInputBorder()),
          items: _iconOptions.entries
              .map((e) => DropdownMenuItem(value: e.value, child: Row(children: [Icon(e.value), const SizedBox(width: 8), Text(e.key)])))
              .toList(),
          onChanged: (value) => setState(() => _icon = value ?? Icons.flag),
        ),
        const SizedBox(height: 10),
        FilledButton(
          onPressed: () {
            final title = _titleController.text.trim();
            final category = _categoryController.text.trim();
            if (title.isEmpty || category.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Title and category are required')));
              return;
            }
            widget.onAddTarget(
              TargetGoal(
                title: title,
                category: category,
                frequency: _frequency,
                count: int.tryParse(_countController.text.trim()),
                tags: _tagsController.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
                icon: _icon,
              ),
            );
            _titleController.clear();
            _categoryController.clear();
            _countController.clear();
            _tagsController.clear();
          },
          child: const Text('Add Target'),
        ),
        const SizedBox(height: 16),
        const Text('Your Targets', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ...widget.targets.map(
          (target) => Card(
            child: ListTile(
              leading: Icon(target.icon),
              title: Text(target.title),
              subtitle: Text('${target.category} • ${target.frequencyLabel}${target.count != null ? ' • ${target.count}' : ''}'),
              trailing: Wrap(
                spacing: 4,
                children: target.tags.map((tag) => Chip(label: Text(tag))).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
