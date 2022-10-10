import 'package:continual_care_alpha/app/bloc/app_bloc.dart';
import 'package:continual_care_alpha/schedule/widgets/date_ios_format.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:continual_care_alpha/log_flow/log_flow.dart';
import 'package:jobs_api/jobs_api.dart';
import 'package:jobs_repository/jobs_repository.dart';

class LogOverviewPage extends StatelessWidget {
  const LogOverviewPage({super.key});

  static Route<void> route({required initialLog}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => LogBloc(
          user: User(
            id: context.read<AppBloc>().state.user.id,
            name: context.read<AppBloc>().state.user.name,
            email: context.read<AppBloc>().state.user.email,
            photo: context.read<AppBloc>().state.user.photo,
          ),
          jobsRepository: context.read<JobsRepository>(),
          initialLog: initialLog,
          job: Job(),
        ),
        child: const LogOverviewPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LogView();
  }
}

class LogView extends StatelessWidget {
  const LogView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LogBloc>().state;
    final isNewLog = context.select(
      (LogBloc bloc) => bloc.state.isNewLog,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isNewLog
              ? 'Create New Log'
              : '${state.initialLog!.completed.dateIosFormat()}',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              if (!isNewLog) _Comments(),
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
              _Tasks(),
              Container(
                width: double.maxFinite,
                height: 32,
                child: Text(
                  "Instrumental ADLS",
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
              _IADLS(),
              Container(
                width: double.maxFinite,
                height: 32,
                child: Text(
                  "Basic ADLS",
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
              _BADLS(),
              if (isNewLog) _Comments(),
              if (isNewLog)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: double.infinity,
                      child: Center(
                        child: Text('Save Log',
                            style: Theme.of(context).textTheme.bodyText1),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Comments extends StatelessWidget {
  _Comments();
  final TextEditingController textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final state = context.watch<LogBloc>().state;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
            height: 32,
            child: Text(
              "Comments",
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
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<LogBloc, LogState>(
              buildWhen: (previous, current) {
                return previous.comments!.length != current.comments!.length;
              },
              builder: (context, state) {
                if (state.comments != null) {
                  if (state.comments!.isNotEmpty) {
                    return Container(
                      width: double.maxFinite,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.comments!.length,
                        itemBuilder: ((context, index) {
                          return CommentTile(
                            comment: state.comments![index],
                          );
                        }),
                      ),
                    );
                  }
                }
                return Column(
                  children: [
                    CommentTile(
                      comment: Comment(
                          username: "mahmoud", comment: "it's all good"),
                    ),
                  ],
                );
              },
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                      child: Text('Y',
                          style: TextStyle(color: Colors.white, fontSize: 12))),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: textFieldController,
                  decoration: InputDecoration(
                    enabled: !state.status.isLoadingOrSuccess,
                    hintText: 'Add a comment',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        context.read<LogBloc>().add(LogCommentsChanged(Comment(
                            username: "testing",
                            comment: textFieldController.text)));
                      },
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _Tasks extends StatelessWidget {
  const _Tasks();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: BlocBuilder<LogBloc, LogState>(
        builder: (context, state) {
          if (state.tasks == null) {
            if (state.tasks!.isNotEmpty) {
              return Expanded(
                child: ListView.builder(
                  itemCount: state.tasks!.length,
                  itemBuilder: ((context, index) {
                    return CheckTile(
                      text: state.tasks![index].action,
                      onTap: (value) {},
                    );
                  }),
                ),
              );
            }
          }
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            // child: Column(
            //   children: [
            //     // CheckTile(text: 'Assist individual to bathroom'),
            //     // CheckTile(text: 'Assist individual with getting dressed'),
            //     // CheckTile(text: 'Prepare breakfast'),
            //     // CheckTile(text: 'Clean kitchen'),
            //     // CheckTile(text: 'Make bed'),
            //   ],
            // ),
          );
        },
      ),
    );
  }
}

class _IADLS extends StatelessWidget {
  const _IADLS();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: BlocBuilder<LogBloc, LogState>(
        buildWhen: ((previous, current) {
          return !listEquals(previous.iadls, current.iadls);
        }),
        builder: (context, state) {
          print("helo");
          if (state.iadls != null) {
            if (state.iadls!.isNotEmpty) {
              return SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.iadls!.length,
                  itemBuilder: ((context, index) {
                    final iadl = state.iadls![index];
                    print(iadl.name);
                    return Container(
                      child: CheckTile(
                          text: iadl.name,
                          onTap: (value) {
                            context
                                .read<LogBloc>()
                                .add(LogIADLSChanged(index));
                          },
                          isChecked: iadl.isIndependent),
                    );
                  }),
                ),
              );
            }
          }
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                // CheckTile(text: 'Transportation'),
                // CheckTile(text: 'Finances'),
                // CheckTile(text: 'Meal'),
                // CheckTile(text: 'Housecleaning'),
                // CheckTile(text: 'Communication'),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _BADLS extends StatelessWidget {
  const _BADLS();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: BlocBuilder<LogBloc, LogState>(
        buildWhen: ((previous, current) {
          return !listEquals(previous.badls, current.badls);
        }),
        builder: (context, state) {
          if (state.badls != null) {
            if (state.badls!.isNotEmpty) {
              return SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.badls!.length,
                  itemBuilder: ((context, index) {
                    final badl = state.badls![index];
                    return Container(
                      child: CheckTile(
                          text: badl.name,
                          onTap: (value) {
                            context.read<LogBloc>().add(LogBADLSChanged(index));
                          },
                          isChecked: badl.isIndependent),
                    );
                  }),
                ),
              );
            }
          }
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                // CheckTile(text: 'Bathing'),
                // CheckTile(text: 'Dressing'),
                // CheckTile(text: 'Toileting'),
                // CheckTile(text: 'Transferring'),
                // CheckTile(text: 'Continence'),
                // CheckTile(text: 'Feeding'),
              ],
            ),
          );
        },
      ),
    );
  }
}
