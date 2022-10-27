import 'package:continual_care_alpha/log_flow/log_flow.dart';
import 'package:continual_care_alpha/schedule/widgets/date_ios_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobs_api/jobs_api.dart';

class BadlsPage extends StatelessWidget {
  const BadlsPage({super.key});

  static MaterialPage<void> page() {
    return const MaterialPage<void>(child: BadlsPage());
  }

  @override
  Widget build(BuildContext context) {
    final date = context.read<LogBloc>().state.started!;
    final iadls = context.watch<LogBloc>().state.badls;

    return Scaffold(
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MainTitle(title: 'Basic ADLs'),
                          for (final iadl in iadls!) ADLCheck(adl: iadl),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32.0),
                      child: ContinueButton(
                        pressable: true,
                        onPressed: () {
                          context.read<LogBloc>().add(
                                LogStatusChanged(LogStatus.badlsCompleted),
                              );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
