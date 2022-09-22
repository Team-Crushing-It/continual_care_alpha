import 'package:continual_care_alpha/app/bloc/app_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:continual_care_alpha/edit_job/edit_job.dart';
import 'package:jobs_api/jobs_api.dart';
import 'package:jobs_repository/jobs_repository.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class EditJobPage extends StatelessWidget {
  const EditJobPage({super.key});

  static Route<void> route({Job? initialJob}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => EditJobBloc(
          coordinator: User(
            id: context.read<AppBloc>().state.user.id,
            name: context.read<AppBloc>().state.user.name,
            email: context.read<AppBloc>().state.user.email,
            photo: context.read<AppBloc>().state.user.photo,
          ),
          jobsRepository: context.read<JobsRepository>(),
          initialJob: initialJob,
        ),
        child: const EditJobPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditJobBloc, EditJobState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == EditJobStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const EditJobView(),
    );
  }
}

class EditJobView extends StatelessWidget {
  const EditJobView({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select((EditJobBloc bloc) => bloc.state.status);
    final isNewJob = context.select(
      (EditJobBloc bloc) => bloc.state.isNewJob,
    );
    final theme = Theme.of(context);
    final floatingActionButtonTheme = theme.floatingActionButtonTheme;
    final fabBackgroundColor = floatingActionButtonTheme.backgroundColor ??
        theme.colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isNewJob
              ? 'Create New Job'
              : 'Edit Job',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'l10n.editJobSaveButtonTooltip',
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        backgroundColor: status.isLoadingOrSuccess
            ? fabBackgroundColor.withOpacity(0.5)
            : fabBackgroundColor,
        onPressed: status.isLoadingOrSuccess
            ? null
            : () => context.read<EditJobBloc>().add(const EditJobSubmitted()),
        child: status.isLoadingOrSuccess
            ? const CupertinoActivityIndicator()
            : const Icon(Icons.check_rounded),
      ),
      body: CupertinoScrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              _ClientField(),
              _DateField(),
              _DurationField(),
              _PayField(),
              _LocationField(),
              _CaregiversField(),
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
    final state = context.watch<EditJobBloc>().state;
    final hintText = state.initialJob?.client ?? '';

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.person, size: 40),
          ),
          Expanded(
            child: TextFormField(
              key: const Key('editJobView_client_textFormField'),
              initialValue: state.client,
              decoration: InputDecoration(
                enabled: !state.status.isLoadingOrSuccess,
                labelText: 'Client',
                hintText: hintText,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(50),
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
              ],
              onChanged: (value) {
                context.read<EditJobBloc>().add(EditJobClientChanged(value));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  const _DateField();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditJobBloc>().state;
    final state2 = context.watch<EditJobBloc>().state.startTime;
    final hintText = state.initialJob?.location ?? '';

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.calendar_month, size: 40),
          ),
          Expanded(
            child: InkWell(
              onTap: () async {
                DateTime? newDateTime = await showOmniDateTimePicker(
                  context: context,
                  primaryColor: Colors.cyan,
                  backgroundColor: Colors.grey[900],
                  calendarTextColor: Colors.white,
                  tabTextColor: Colors.white,
                  unselectedTabBackgroundColor: Colors.grey[700],
                  buttonTextColor: Colors.white,
                  timeSpinnerTextStyle:
                      const TextStyle(color: Colors.white70, fontSize: 18),
                  timeSpinnerHighlightedTextStyle:
                      const TextStyle(color: Colors.white, fontSize: 24),
                  is24HourMode: false,
                  isShowSeconds: false,
                  startInitialDate: DateTime.now(),
                  startFirstDate:
                      DateTime(1600).subtract(const Duration(days: 3652)),
                  startLastDate: DateTime.now().add(
                    const Duration(days: 3652),
                  ),
                  borderRadius: const Radius.circular(16),
                );
                if (newDateTime != null)
                  context
                      .read<EditJobBloc>()
                      .add(EditJobStartTimeChanged(newDateTime));
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text('Date',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black54)),
                      ),
                      Text(state2.toDateIosFormat()!),
                      Divider(thickness: 1, color: Colors.black38),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DurationField extends StatelessWidget {
  const _DurationField();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditJobBloc>().state;
    final hintText = state.initialJob?.duration ?? 0;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.punch_clock, size: 40),
          ),
          Expanded(
            child: TextFormField(
              key: const Key('editJobView_duration_textFormField'),
              initialValue: state.duration.toString(),
              decoration: InputDecoration(
                enabled: !state.status.isLoadingOrSuccess,
                labelText: 'Duration',
                hintText: hintText.toString(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                value.characters.length > 0
                    ? context
                        .read<EditJobBloc>()
                        .add(EditJobDurationChanged(double.parse(value)))
                    : null;
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PayField extends StatelessWidget {
  const _PayField();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditJobBloc>().state;
    final hintText = state.initialJob?.pay ?? 0;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.attach_money_outlined, size: 40),
          ),
          Expanded(
            child: TextFormField(
              key: const Key('editJobView_pay_textFormField'),
              initialValue: state.pay.toInt().toString(),
              decoration: InputDecoration(
                enabled: !state.status.isLoadingOrSuccess,
                labelText: 'Pay',
                hintText: hintText.toInt().toString(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                value.characters.length > 0
                    ? context
                        .read<EditJobBloc>()
                        .add(EditJobPayChanged(double.parse(value)))
                    : null;
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _LocationField extends StatelessWidget {
  const _LocationField();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditJobBloc>().state;
    final hintText = state.initialJob?.location ?? '';
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.location_on, size: 40),
          ),
          Expanded(
            child: TextFormField(
              key: const Key('editJobView_location_textFormField'),
              initialValue: state.location,
              decoration: InputDecoration(
                enabled: !state.status.isLoadingOrSuccess,
                labelText: 'location',
                hintText: hintText,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(50),
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
              ],
              onChanged: (value) {
                context.read<EditJobBloc>().add(EditJobLocationChanged(value));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CaregiversField extends StatelessWidget {
  const _CaregiversField();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditJobBloc>().state;
    final hintText = state.initialJob?.caregivers.first.name ?? '';
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.medical_services, size: 40),
          ),
          Expanded(
            child: TextFormField(
              key: const Key('editJobView_caregivers_textFormField'),
              initialValue: state.caregivers.first.name,
              decoration: InputDecoration(
                enabled: !state.status.isLoadingOrSuccess,
                labelText: 'caregivers',
                hintText: hintText,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(50),
                // FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
              ],
              onChanged: (value) {
                context.read<EditJobBloc>().add(EditJobCaregiversChanged([
                      User(
                        id: 'test',
                        name: value,
                        email: '',
                        photo: '',
                      )
                    ]));
              },
            ),
          ),
        ],
      ),
    );
  }
}

