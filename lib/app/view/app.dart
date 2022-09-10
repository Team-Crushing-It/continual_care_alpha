import 'package:authentication_repository/authentication_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:continual_care_alpha/app/app.dart';
import 'package:continual_care_alpha/theme/theme.dart';
import 'package:jobs_repository/jobs_repository.dart';
import 'package:logs_repository/logs_repository.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
    required JobsRepository jobsRepository,
    required LogsRepository logsRepository,
  })  : _authenticationRepository = authenticationRepository,
        _jobsRepository = jobsRepository,
        _logsRepository = logsRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;
  final JobsRepository _jobsRepository;
  final LogsRepository _logsRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authenticationRepository),
        RepositoryProvider.value(value: _jobsRepository),
        RepositoryProvider.value(value: _logsRepository),
      ],
      child: BlocProvider(
        create: (_) => AppBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FlutterJobsTheme.light,
      darkTheme: FlutterJobsTheme.dark,
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
