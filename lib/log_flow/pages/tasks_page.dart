import 'package:continual_care_alpha/log_flow/log_flow.dart';
import 'package:continual_care_alpha/schedule/widgets/date_ios_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  static MaterialPage<void> page() {
    return const MaterialPage<void>(child: TasksPage());
  }

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
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

    // myController.text = context.watch<LogBloc>().state.newTaskAction!;

    return Scaffold(
      appBar: AppBar(
        title: Text(date.dateIosFormat()!),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.read<LogBloc>().add(LogStatusChanged(LogStatus.initial));
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LogProgress(),
          _TasksList(),
        ],
      ),
    );
  }
}

class _TasksList extends StatefulWidget {
  const _TasksList({super.key});

  @override
  State<_TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<_TasksList> {
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
    final tasks = context.watch<LogBloc>().state.tasks;
    final pageStatus = context.select((LogBloc bloc) => bloc.state.pageStatus);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
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
              children: tasks!.isEmpty
                  ? [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('no tasks yet',
                            style: Theme.of(context).textTheme.bodyText1),
                      )
                    ]
                  : tasks
                      .map<Widget>((task) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  child: Checkbox(
                                    value: context
                                        .watch<LogBloc>()
                                        .state
                                        .tasks!
                                        .firstWhere(
                                            (element) => element.id == task.id)
                                        .isCompleted,
                                    onChanged: (isChecked) {
                                      context
                                          .read<LogBloc>()
                                          .add(LogTaskUpdated(task));
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text(task.action,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
            ),
          ),
          Row(
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
                                context.read<LogBloc>().add(LogNewTaskAdded());
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: ContinueButton(
              pressable: pageStatus == PageStatus.updated ? true : false,
              onPressed: () {
                context.read<LogBloc>().add(
                      LogStatusChanged(LogStatus.tasksCompleted),
                    );
              },
            ),
          ),
        ],
      ),
    );
  }
}
