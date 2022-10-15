import 'package:continual_care_alpha/log_flow/log_flow.dart';
import 'package:continual_care_alpha/schedule/widgets/date_ios_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobs_api/jobs_api.dart';

class IadlsPage extends StatefulWidget {
  const IadlsPage({super.key});

  static MaterialPage<void> page() {
    return const MaterialPage<void>(child: IadlsPage());
  }

  @override
  State<IadlsPage> createState() => _IadlsPageState();
}

class _IadlsPageState extends State<IadlsPage> {
  late FocusNode myFocusNode;
  late TextEditingController myController;
  @override
  initState() {
    super.initState();
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
          _IadlsList(),
        ],
      ),
    );
  }
}

class _IadlsList extends StatefulWidget {
  const _IadlsList({super.key});

  @override
  State<_IadlsList> createState() => _IadlsListState();
}

class _IadlsListState extends State<_IadlsList> {
  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final iadls = context.watch<LogBloc>().state.iadls;
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
              "Instrumental ADLs",
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
              children: iadls!.isEmpty
                  ? [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('no iadl yet',
                            style: Theme.of(context).textTheme.bodyText1),
                      )
                    ]
                  : iadls
                      .map<Widget>((adl) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
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
                                          context
                                              .read<LogBloc>()
                                              .add(LogIADLSChanged(adl));
                                        },
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text(adl.name,
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: ContinueButton(
              pressable: pageStatus == PageStatus.updated ? true : false,
              onPressed: () {
                context.read<LogBloc>().add(
                      LogStatusChanged(LogStatus.caregiverCompleted),
                    );
              },
            ),
          ),
        ],
      ),
    );
  }
}
