import 'package:continual_care_alpha/schedule/widgets/schedule_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:continual_care_alpha/edit_job/view/edit_job_page.dart';
import 'package:continual_care_alpha/schedule/schedule.dart';
import 'package:jobs_repository/jobs_repository.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(
        key: ValueKey('schedule_page'),
        child: SchedulePage(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScheduleBloc(
        jobsRepository: context.read<JobsRepository>(),
      )..add(const ScheduleSubscriptionRequested()),
      child: const ScheduleView(),
    );
  }
}

class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
        toolbarHeight: 50,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(EditJobPage.route());
        },
        backgroundColor: Color(0xFF2A3066),
        child: const Icon(Icons.add),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ScheduleBloc, ScheduleState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == ScheduleStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text('l10n.jobsOverviewErrorSnackbarText'),
                    ),
                  );
              }
            },
          ),
          BlocListener<ScheduleBloc, ScheduleState>(
            listenWhen: (previous, current) =>
                previous.lastDeletedJob != current.lastDeletedJob &&
                current.lastDeletedJob != null,
            listener: (context, state) {
              final messenger = ScaffoldMessenger.of(context);
              messenger
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Expanded(child: Text('Job Deleted')),
                    action: SnackBarAction(
                      label: 'tap to undo,',
                      onPressed: () {
                        messenger.hideCurrentSnackBar();
                        context
                            .read<ScheduleBloc>()
                            .add(const ScheduleUndoDeletionRequested());
                      },
                    ),
                  ),
                );
            },
          ),
        ],
        child: BlocBuilder<ScheduleBloc, ScheduleState>(
          builder: (context, state) {
            if (state.jobs.isEmpty) {
              if (state.status == ScheduleStatus.loading) {
                return const Center(child: CupertinoActivityIndicator());
              } else if (state.status != ScheduleStatus.success) {
                return const SizedBox();
              } else {
                return Center(
                  child: Text(
                    ' l10n.jobsOverviewEmptyText,',
                    style: Theme.of(context).textTheme.caption,
                  ),
                );
              }
            }

            return Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SchedulePicker(),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: ListView(
                      children: [
                        for (final job in state.filteredJobs)
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: Color(0xff626262),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 16.0, top: 8),
                              child: JobListTile(
                                job: job,
                                onDismissed: (_) {
                                  context
                                      .read<ScheduleBloc>()
                                      .add(ScheduleJobDeleted(job));
                                },
                                onTap: () {
                                  Navigator.of(context).push(
                                    EditJobPage.route(initialJob: job),
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
            );
          },
        ),
      ),
    );
  }
}
