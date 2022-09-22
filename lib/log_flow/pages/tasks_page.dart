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
          // TasksView(),
        ],
      ),
    );
  }
}
