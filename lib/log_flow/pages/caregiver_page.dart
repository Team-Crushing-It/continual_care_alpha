import 'package:continual_care_alpha/log_flow/log_flow.dart';
import 'package:continual_care_alpha/log_flow/widgets/progress.dart';
import 'package:continual_care_alpha/schedule/widgets/date_ios_format.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CaregiverPage extends StatelessWidget {
  const CaregiverPage({super.key});

  static MaterialPage<void> page() {
    return const MaterialPage<void>(child: CaregiverPage());
  }

  @override
  Widget build(BuildContext context) {
    final date = context.read<LogBloc>().state.started!;
    final pageStatus = context.select((LogBloc bloc) => bloc.state.pageStatus);

    return Scaffold(
      appBar: AppBar(
        title: Text(date.dateIosFormat()!),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            context.flow<LogState>().complete();
          },
        ),
      ),
      body: Column(
        children: [
          LogProgress(),
          MoodPicker(
            prompt: 'How are you doing today?',
          ),
          ContinueButton(
            pressable: pageStatus == PageStatus.updated ? true : false,
            onPressed: () {
              context.read<LogBloc>().add(
                    LogStatusChanged(LogStatus.caregiverCompleted),
                  );
            },
          )
        ],
      ),
    );
  }
}
