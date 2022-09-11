import 'package:continual_care_alpha/app/bloc/app_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:continual_care_alpha/edit_log/edit_log.dart';
import 'package:logs_api/logs_api.dart';
import 'package:logs_repository/logs_repository.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class EditLogPage extends StatelessWidget {
  const EditLogPage({super.key});

  static Route<void> route({Log? initialLog}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => EditLogBloc(
          user: User(
            id: context.read<AppBloc>().state.user.id,
            name: context.read<AppBloc>().state.user.name,
            email: context.read<AppBloc>().state.user.email,
            photo: context.read<AppBloc>().state.user.photo,
          ),
          logsRepository: context.read<LogsRepository>(),
          initialLog: initialLog,
        ),
        child: const EditLogPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditLogBloc, EditLogState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == EditLogStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const EditLogView(),
    );
  }
}

class EditLogView extends StatelessWidget {
  const EditLogView({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select((EditLogBloc bloc) => bloc.state.status);
    final isNewLog = context.select(
      (EditLogBloc bloc) => bloc.state.isNewLog,
    );
    final theme = Theme.of(context);
    final floatingActionButtonTheme = theme.floatingActionButtonTheme;
    final fabBackgroundColor = floatingActionButtonTheme.backgroundColor ??
        theme.colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isNewLog ? 'Create New Log' : 'Edit Log',
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
            : () => context.read<EditLogBloc>().add(const EditLogSubmitted()),
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
              _LinkField(),
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
    final state = context.watch<EditLogBloc>().state;
    final hintText = state.initialLog?.client ?? '';

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
              key: const Key('editLogView_client_textFormField'),
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
                context.read<EditLogBloc>().add(EditLogClientChanged(value));
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
    final state = context.watch<EditLogBloc>().state;
    final state2 = context.watch<EditLogBloc>().state.startTime;
    final hintText = state.initialLog?.location ?? '';

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
                      .read<EditLogBloc>()
                      .add(EditLogStartTimeChanged(newDateTime));
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
    final state = context.watch<EditLogBloc>().state;
    final hintText = state.initialLog?.duration ?? 0;
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
              key: const Key('editLogView_duration_textFormField'),
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
                        .read<EditLogBloc>()
                        .add(EditLogDurationChanged(double.parse(value)))
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
    final state = context.watch<EditLogBloc>().state;
    final hintText = state.initialLog?.pay ?? 0;

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
              key: const Key('editLogView_pay_textFormField'),
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
                        .read<EditLogBloc>()
                        .add(EditLogPayChanged(double.parse(value)))
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
    final state = context.watch<EditLogBloc>().state;
    final hintText = state.initialLog?.location ?? '';
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
              key: const Key('editLogView_location_textFormField'),
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
                context.read<EditLogBloc>().add(EditLogLocationChanged(value));
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
    final state = context.watch<EditLogBloc>().state;
    final hintText = state.initialLog?.caregivers.first.name ?? '';
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
              key: const Key('editLogView_caregivers_textFormField'),
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
                context.read<EditLogBloc>().add(EditLogCaregiversChanged([
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

class _LinkField extends StatelessWidget {
  const _LinkField();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditLogBloc>().state;
    final hintText = state.initialLog?.link ?? '';
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.link, size: 40),
          ),
          Expanded(
              child: TextFormField(
            key: const Key('editLogView_link_textFormField'),
            initialValue: state.link,
            decoration: InputDecoration(
              enabled: !state.status.isLoadingOrSuccess,
              labelText: 'link',
              hintText: hintText,
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(50),
              // FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
            ],
            onChanged: (value) {
              context.read<EditLogBloc>().add(EditLogLinkChanged(value));
            },
          )),
        ],
      ),
    );
  }
}
