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
    final badls = context.watch<LogBloc>().state.badls;

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
                          for (final badl in badls!) ADLCheck(adl: badl),
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

class ADLCheck extends StatelessWidget {
  const ADLCheck({super.key, required this.adl});

  final ADL adl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: Colors.black,
            width: 1.0,
          ))),
          child: Row(
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
                child: Text(adl.name,
                    style: Theme.of(context).textTheme.bodyText1),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Independence",
                      style: TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Text(adl.independence,
                        style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Dependence",
                        style: TextStyle(
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      Text(adl.dependence,
                          style: Theme.of(context).textTheme.bodyText1),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
