import 'package:continual_care_alpha/log_flow/log_flow.dart';
import 'package:continual_care_alpha/schedule/widgets/date_ios_format.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage({super.key});

  static MaterialPage<void> page() {
    return const MaterialPage<void>(child: CommentsPage());
  }

  @override
  Widget build(BuildContext context) {
    final date = context.read<LogBloc>().state.started!;
    final client = context.watch<LogBloc>().state.client;

    return BlocListener<LogBloc, LogState>(
      listener: (context, state) {
        if (state.status == LogStatus.success) {
          context.flow<LogState>().complete();
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(date.dateIosFormat()!),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                context
                    .read<LogBloc>()
                    .add(LogStatusChanged(LogStatus.tasksCompleted));
              },
            ),
          ),
          body: Column(
            children: [
              LogProgress(),
              Expanded(
                  child: Column(
                children: [
                  MoodPicker(
                    prompt: 'How was $client today?',
                  ),
                  Comments(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32.0),
                    child: ContinueButton(
                      pressable: true,
                      onPressed: () {
                        print('complete flow');

                        // call the event to submit new log
                        context.read<LogBloc>().add(
                              LogSubmitted(),
                            );
                        // once the event is complete, then complete the flow
                        context.flow<LogState>().complete();
                      },
                    ),
                  )
                ],
              )),
            ],
          )),
    );
  }
}
