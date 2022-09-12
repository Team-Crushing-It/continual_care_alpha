import 'package:continual_care_alpha/app/bloc/app_bloc.dart';
import 'package:continual_care_alpha/schedule/widgets/date_ios_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:continual_care_alpha/log/log.dart';
import 'package:logs_api/logs_api.dart';
import 'package:logs_repository/logs_repository.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class LogPage extends StatelessWidget {
  const LogPage({super.key});

  static Route<void> route({Log? initialLog}) {
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
          logsRepository: context.read<LogsRepository>(),
          initialLog: initialLog,
        ),
        child: const LogPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogBloc, LogState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == LogStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const LogView(),
    );
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
      body: CupertinoScrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                _Comments(),
                _Todos(),
                _IADLS(),
                _BADLS(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Comments extends StatelessWidget {
  const _Comments();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
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
        BlocBuilder<LogBloc, LogState>(
          builder: (context, state) {
            if (state.comments != null) {
              if (state.comments!.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.comments!.length,
                    itemBuilder: ((context, index) {
                      return Container(
                        child: Text('Comment 1'),
                      );
                    }),
                  ),
                );
              }
            }
            return Text("No comments yet");
          },
        ),
      ],
    );
  }
}

class _Todos extends StatelessWidget {
  const _Todos();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          child: Text(
            "Todos",
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
        BlocBuilder<LogBloc, LogState>(
          builder: (context, state) {
            if (state.todos != null) {
              if (state.todos!.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.todos!.length,
                    itemBuilder: ((context, index) {
                      return Container(
                        child: Text('Todo 1'),
                      );
                    }),
                  ),
                );
              }
            }
            return Text("No Todos yet");
          },
        ),
      ],
    );
  }
}

class _IADLS extends StatelessWidget {
  const _IADLS();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          child: Text(
            "IADLS",
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
        BlocBuilder<LogBloc, LogState>(
          builder: (context, state) {
            if (state.iadls != null) {
              if (state.iadls!.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.iadls!.length,
                    itemBuilder: ((context, index) {
                      return Container(
                        child: Text('iadl 1'),
                      );
                    }),
                  ),
                );
              }
            }
            return Text("No IADLS yet");
          },
        ),
      ],
    );
  }
}

class _BADLS extends StatelessWidget {
  const _BADLS();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          child: Text(
            "BADLS",
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
        BlocBuilder<LogBloc, LogState>(
          builder: (context, state) {
            if (state.badls != null) {
              if (state.badls!.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.badls!.length,
                    itemBuilder: ((context, index) {
                      return Container(
                        child: Text('badl 1'),
                      );
                    }),
                  ),
                );
              }
            }
            return Text("No BADLS yet");
          },
        ),
      ],
    );
  }
}