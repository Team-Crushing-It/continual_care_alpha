import 'package:continual_care_alpha/app/bloc/app_bloc.dart';
import 'package:continual_care_alpha/log/log.dart';
import 'package:continual_care_alpha/log/pages/pages.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logs_api/logs_api.dart';
import 'package:logs_repository/logs_repository.dart';

List<Page> onGenerateLocationPages(LogState state, List<Page> pages) {
  return [CaregiverPage.page()];
}

class LogFlow extends StatelessWidget {
  const LogFlow({super.key});

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
        child: const LogFlow(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LogBloc(
          user: User(
            id: context.read<AppBloc>().state.user.id,
            name: context.read<AppBloc>().state.user.name,
            email: context.read<AppBloc>().state.user.email,
            photo: context.read<AppBloc>().state.user.photo,
          ),
          logsRepository: context.read<LogsRepository>(),
          initialLog: null,
        );
      },
      child: const _buildLogFlow(),
    );
  }
}

class _buildLogFlow extends StatelessWidget {
  const _buildLogFlow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<LogState>(
      state: context.select((LogBloc bloc) => bloc.state),
      onGeneratePages: onGenerateLocationPages,
    );
  }
}
