import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:study_planner/models/task_model.dart';
import 'package:study_planner/providers/task_provider.dart';
import 'package:study_planner/screens/tasks/edit_task_screen.dart';
import 'package:study_planner/widgets/custom_button.dart';

class TaskDetailsScreen extends StatelessWidget {
  final Task task;

  const TaskDetailsScreen({
    super.key,
    required this.task,
  });

  Color _getSubjectColor(String subject) {
    final colors = {
      'Math': Colors.blue,
      'Science': Colors.green,
      'English': Colors.purple,
      'History': Colors.orange,
      'Physics': Colors.red,
      'Chemistry': Colors.teal,
      'Biology': Colors.lightGreen,
      'Computer Science': Colors.indigo,
      'Other': Colors.grey,
    };
    return colors[subject] ?? Colors.grey;
  }

  void _showDeleteDialog(BuildContext context, TaskProvider taskProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await taskProvider.deleteTask(task.id);
              if (context.mounted) {
                if (success) {
                  Navigator.pop(context); // Go back to previous screen
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Task deleted successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        taskProvider.errorMessage ?? 'Failed to delete task',
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final subjectColor = _getSubjectColor(task.subject);
    final dateFormat = DateFormat('EEEE, MMMM d, yyyy');
    final timeFormat = DateFormat('h:mm a');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTaskScreen(task: task),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subject Badge
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: subjectColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: subjectColor.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                task.subject,
                style: TextStyle(
                  color: subjectColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Title
            Text(
              task.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    decoration: task.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                    color: task.isCompleted
                        ? Colors.grey.shade600
                        : null,
                  ),
            ),
            const SizedBox(height: 24),
            // Completion Status
            Card(
              color: task.isCompleted
                  ? Colors.green.shade50
                  : Colors.orange.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      task.isCompleted
                          ? Icons.check_circle
                          : Icons.pending,
                      color: task.isCompleted
                          ? Colors.green
                          : Colors.orange,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      task.isCompleted ? 'Completed' : 'Pending',
                      style: TextStyle(
                        color: task.isCompleted
                            ? Colors.green.shade700
                            : Colors.orange.shade700,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    Consumer<TaskProvider>(
                      builder: (context, taskProvider, _) {
                        return Switch(
                          value: task.isCompleted,
                          onChanged: (value) {
                            taskProvider.toggleTaskCompletion(task.id, value);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Date and Time
            _buildInfoCard(
              context,
              icon: Icons.calendar_today,
              title: 'Date',
              value: dateFormat.format(task.dateTime),
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              context,
              icon: Icons.access_time,
              title: 'Time',
              value: timeFormat.format(task.dateTime),
            ),
            if (task.notes.isNotEmpty) ...[
              const SizedBox(height: 16),
              _buildInfoCard(
                context,
                icon: Icons.note,
                title: 'Notes',
                value: task.notes,
              ),
            ],
            const SizedBox(height: 32),
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Edit Task',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditTaskScreen(task: task),
                        ),
                      );
                    },
                    icon: Icons.edit,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Consumer<TaskProvider>(
                    builder: (context, taskProvider, _) {
                      return CustomButton(
                        text: 'Delete',
                        onPressed: () => _showDeleteDialog(context, taskProvider),
                        icon: Icons.delete,
                        backgroundColor: Colors.red,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
