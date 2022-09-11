import 'package:continual_care_alpha/app/bloc/app_bloc.dart';
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
    final status = context.select((LogBloc bloc) => bloc.state.status);
    final isNewLog = context.select(
      (LogBloc bloc) => bloc.state.isNewLog,
    );
    final theme = Theme.of(context);
    final floatingActionButtonTheme = theme.floatingActionButtonTheme;
    final fabBackgroundColor = floatingActionButtonTheme.backgroundColor ??
        theme.colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isNewLog ? 'Create New Log' : ' Log',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'l10n.editLogSaveButtonTooltip',
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        backgroundColor: status.isLoadingOrSuccess
            ? fabBackgroundColor.withOpacity(0.5)
            : fabBackgroundColor,
        onPressed: status.isLoadingOrSuccess
            ? null
            : () => context.read<LogBloc>().add(const LogSubmitted()),
        child: status.isLoadingOrSuccess
            ? const CupertinoActivityIndicator()
            : const Icon(Icons.check_rounded),
      ),
      body: CupertinoScrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              _ClientField(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ClientField extends StatelessWidget {
  const _ClientField();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LogBloc>().state;
    final hintText = state.initialLog?.id ?? '';

    return Container();
  }
}
