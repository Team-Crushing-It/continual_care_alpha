import 'package:continual_care_alpha/log_flow/log_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  late FocusNode myFocusNode;
  late TextEditingController myController;
  @override
  initState() {
    super.initState();

    myFocusNode = FocusNode();
    myController = TextEditingController()
      ..addListener(() {
        context.read<LogBloc>().add(LogNewTaskActionChanged(myController.text));
      });
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final date = context.read<LogBloc>().state.started!;
    final tasks = context.read<LogBloc>().state.tasks!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.maxFinite,
            height: 32,
            child: Text(
              "Tasks",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Color(0xff626262),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: tasks.isEmpty
                  ? [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('no tasks'),
                      )
                    ]
                  : tasks
                      .map<Widget>(
                        (task) => _taskBox(
                          isCompleted: task.isCompleted,
                          action: task.action,
                          onPressed: () {
                            context.read<LogBloc>().add(LogTaskUpdated(task));
                            print(task.action);
                          },
                        ),
                      )
                      .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: TextField(
                      focusNode: myFocusNode,
                      controller: myController,
                      decoration: InputDecoration(
                        hintText: 'Add Task',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: context
                                  .watch<LogBloc>()
                                  .state
                                  .newTaskAction!
                                  .isNotEmpty
                              ? () {
                                  context
                                      .read<LogBloc>()
                                      .add(LogNewTaskAdded());
                                  myController.clear();
                                  myFocusNode.unfocus();
                                }
                              : null,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _taskBox extends StatelessWidget {
  const _taskBox({
    super.key,
    required this.isCompleted,
    required this.action,
    required this.onPressed,
  });

  final bool isCompleted;
  final String action;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Container(
            height: 16,
            width: 16,
            child: Checkbox(
              value: isCompleted,
              onChanged: (value) {
                onPressed();
                print(isCompleted);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(action, style: Theme.of(context).textTheme.bodyText1),
          ),
        ],
      ),
    );
  }
}
