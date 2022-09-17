import 'package:continual_care_alpha/home_overview/bloc/home_overview_bloc.dart';
import 'package:continual_care_alpha/home_overview/home_overview.dart';
import 'package:continual_care_alpha/log/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobs_repository/jobs_repository.dart';
import 'package:logs_api/logs_api.dart';
import 'package:logs_repository/logs_repository.dart';

import '../../schedule/widgets/job_list_tile.dart';

class HomeOverviewPage extends StatelessWidget {
  const HomeOverviewPage({Key? key}) : super(key: key);

  static Page page() => const SlideRightPage<void>(
        key: ValueKey('home_overview_page'),
        child: HomeOverviewPage(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeOverviewBloc(
              jobsRepository: context.read<JobsRepository>(),
              logsRepository: context.read<LogsRepository>(),
            )
              ..add(HomeOverviewSubscriptionRequested())
              ..add(HomeOverviewUpcomingJobRequested()),
        child: HomeOverviewView());
  }
}

class HomeOverviewView extends StatelessWidget {
  const HomeOverviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Overview'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Container(
                          width: double.maxFinite,
                          height: 32,
                          child: Text(
                            "Upcoming",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
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
                      ),
                      BlocBuilder<HomeOverviewBloc, HomeOverviewState>(
                        builder: (context, state) {
                          if (state.job != null) {
                            return JobListTile(
                              job: state.job!,
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (newContext) {
                                    return BlocProvider.value(
                                      value: context.read<HomeOverviewBloc>(),
                                      child: AlertDialog(
                                        title: Text(
                                            "Mon Sep 12 Maureen & Day Derosa"),
                                        content: Text(
                                            'Would you like to start the job?',
                                            style: TextStyle(
                                                color: Color(0xff989898))),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              context
                                                  .read<HomeOverviewBloc>()
                                                  .add(HomeOverviewLogAdded());
                                              Navigator.pop(newContext);
                                              Navigator.of(context).push(
                                                LogPage.route(),
                                              );
                                            },
                                            child: Text(
                                              'Yes',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(newContext);
                                            },
                                            child: Text(
                                              'No',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          }
                          return Center(child: Text("No upcomming jobs"));
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16, right: 2),
                  child: Column(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.notifications,
                            size: 32,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.account_circle,
                            size: 32,
                          ))
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                width: double.maxFinite,
                height: 32,
                child: Text(
                  "Activity Log",
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
            ),
            BlocBuilder<HomeOverviewBloc, HomeOverviewState>(
              builder: (context, state) {
                if (state.logs != null) {
                  if (state.logs!.isNotEmpty) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.logs!.length,
                        itemBuilder: ((context, index) {
                          return LogTile(
                            initialLog: state.logs![index],
                            onTap: () {
                              Navigator.of(context).push(
                                LogPage.route(
                                  initialLog: state.logs![index],
                                ),
                              );
                            },
                          );
                        }),
                      ),
                    );
                  }
                }
                return Text("No logs yet");
              },
            )
          ],
        ),
      ),
    );
  }
}
