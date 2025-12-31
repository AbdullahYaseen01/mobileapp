import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:study_planner/providers/task_provider.dart';
import 'package:study_planner/models/task_model.dart';
import 'package:study_planner/widgets/task_card.dart';
import 'package:study_planner/widgets/empty_state_widget.dart';
import 'package:study_planner/screens/tasks/add_task_screen.dart';
import 'package:study_planner/screens/tasks/edit_task_screen.dart';
import 'package:study_planner/screens/tasks/task_details_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    
    // Initialize tasks when calendar loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      taskProvider.initializeTasks();
    });
  }

  List<Task> _getTasksForDay(DateTime day, List<Task> allTasks) {
    final dayStart = DateTime(day.year, day.month, day.day);
    final dayEnd = DateTime(day.year, day.month, day.day, 23, 59, 59);
    
    return allTasks.where((task) {
      return task.dateTime.isAfter(dayStart.subtract(const Duration(seconds: 1))) &&
             task.dateTime.isBefore(dayEnd.add(const Duration(seconds: 1)));
    }).toList();
  }

  Map<DateTime, List<Task>> _getTasksMap(List<Task> tasks) {
    final Map<DateTime, List<Task>> tasksMap = {};
    
    for (var task in tasks) {
      final taskDate = DateTime(
        task.dateTime.year,
        task.dateTime.month,
        task.dateTime.day,
      );
      
      if (tasksMap.containsKey(taskDate)) {
        tasksMap[taskDate]!.add(task);
      } else {
        tasksMap[taskDate] = [task];
      }
    }
    
    return tasksMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, _) {
          final tasksMap = _getTasksMap(taskProvider.tasks);
          final selectedDayTasks = _selectedDay != null
              ? _getTasksForDay(_selectedDay!, taskProvider.tasks)
              : <Task>[];

          return Column(
            children: [
              // Calendar Widget
              Card(
                margin: const EdgeInsets.all(16),
                child: TableCalendar<Task>(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  calendarFormat: _calendarFormat,
                  eventLoader: (day) {
                    final taskDate = DateTime(day.year, day.month, day.day);
                    return tasksMap[taskDate] ?? [];
                  },
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                    weekendTextStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    markerDecoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: BoxShape.circle,
                    ),
                    markersMaxCount: 3,
                    markerSize: 6,
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: true,
                    titleCentered: true,
                    formatButtonShowsNext: false,
                    formatButtonDecoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    formatButtonTextStyle: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
              ),
              // Selected Day Tasks
              Expanded(
                child: _selectedDay == null
                    ? const Center(
                        child: Text('Select a date to view tasks'),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  DateFormat('EEEE, MMMM d, yyyy')
                                      .format(_selectedDay!),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  '${selectedDayTasks.length} task${selectedDayTasks.length != 1 ? 's' : ''}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Colors.grey.shade600,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: selectedDayTasks.isEmpty
                                ? EmptyStateWidget(
                                    icon: Icons.task_alt,
                                    title: 'No tasks for this day',
                                    message: 'Tap the + button to add a task',
                                  )
                                : ListView.builder(
                                    itemCount: selectedDayTasks.length,
                                    itemBuilder: (context, index) {
                                      final task = selectedDayTasks[index];
                                      return TaskCard(
                                        task: task,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TaskDetailsScreen(
                                                task: task,
                                              ),
                                            ),
                                          );
                                        },
                                        onToggleComplete: (value) {
                                          taskProvider.toggleTaskCompletion(
                                            task.id,
                                            value,
                                          );
                                        },
                                        onEdit: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditTaskScreen(
                                                task: task,
                                              ),
                                            ),
                                          );
                                        },
                                        onDelete: () {
                                          _showDeleteDialog(
                                            context,
                                            taskProvider,
                                            task,
                                          );
                                        },
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTaskScreen(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Task'),
      ),
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    TaskProvider taskProvider,
    Task task,
  ) {
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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      success
                          ? 'Task deleted successfully'
                          : 'Failed to delete task',
                    ),
                    backgroundColor: success ? Colors.green : Colors.red,
                  ),
                );
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
}
