import 'package:continual_care_alpha/log_flow/log_flow.dart';
import 'package:continual_care_alpha/schedule/widgets/date_ios_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobs_api/jobs_api.dart';

class IadlsPage extends StatelessWidget {
  const IadlsPage({super.key});

  static MaterialPage<void> page() {
    return const MaterialPage<void>(child: IadlsPage());
  }

  @override
  Widget build(BuildContext context) {
    final date = context.read<LogBloc>().state.started!;
    final iadls = context.watch<LogBloc>().state.initialLog!.iadls;

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MainTitle(title: 'Instrumental ADLs'),
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
                        LogStatusChanged(LogStatus.caregiverCompleted),
                      );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ADLCheck extends StatelessWidget {
  const ADLCheck({super.key, required this.adl});

  final ADL adl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 16,
              height: 16,
              child: BlocBuilder<LogBloc, LogState>(
                builder: (context, state) {
                  return Checkbox(
                    value: adl.isIndependent,
                    onChanged: (isChecked) {
                      context.read<LogBloc>().add(LogIADLSChanged(adl));
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child:
                  Text(adl.name, style: Theme.of(context).textTheme.bodyText1),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(adl.independence,
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(adl.dependence,
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
