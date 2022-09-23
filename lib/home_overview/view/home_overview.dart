import 'package:continual_care_alpha/app/bloc/app_bloc.dart';
import 'package:continual_care_alpha/home_overview/bloc/home_overview_bloc.dart';
import 'package:continual_care_alpha/home_overview/home_overview.dart';
import 'package:continual_care_alpha/log_flow/log_flow.dart';
import 'package:continual_care_alpha/tasks/tasks.dart';
import 'package:continual_care_alpha/tasks/view/tasks_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobs_repository/jobs_repository.dart';

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
      lazy: false,
      create: (context) => HomeOverviewBloc(
        jobsRepository: context.read<JobsRepository>(),
      )..add(HomeOverviewSubscriptionRequested()),
      child: HomeOverviewView(),
    );
  }
}

// class ModalProvider extends StatelessWidget {
//   const ModalProvider({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // print(
//     //   context.read<HomeOverviewBloc>().state.upcomingJob!.logs.first.tasks,
//     // );
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           lazy: false,
//           create: (context) => TasksBloc(
//             initialTasks: context
//                 .read<HomeOverviewBloc>()
//                 .state
//                 .upcomingJob!
//                 .logs
//                 .first
//                 .tasks,
//             jobsRepository: context.read<JobsRepository>(),
//           ),
//         ),
//       ],
//       child: HomeOverviewView(),
//     );
//   }
// }

class HomeOverviewView extends StatelessWidget {
  const HomeOverviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 36,
          child: Image.asset('assets/logo_dark_nobg.png'),
        ),
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
                          if (state.upcomingJob != null) {
                            return JobListTile(
                                job: state.upcomingJob!,
                                onTap: () {
                                  startJobModal(
                                    context,
                                    state.upcomingJob!,
                                    state.recentJob!,
                                  );
                                });
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
            // BlocBuilder<HomeOverviewBloc, HomeOverviewState>(
            //   builder: (context, state) {
            //     if (state.logs != null) {
            //       if (state.logs!.isNotEmpty) {
            //         return Expanded(
            //           child: ListView.builder(
            //             itemCount: state.logs!.length,
            //             itemBuilder: ((context, index) {
            //               return LogTile(
            //                 initialLog: state.logs![index],
            //                 onTap: () {
            //                   Navigator.of(context).push(
            //                     LogOverviewPage.route(
            //                       initialLog: state.logs![index],
            //                     ),
            //                   );
            //                 },
            //               );
            //             }),
            //           ),
            //         );
            //       }
            //     }
            //     return Text("No logs yet");
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
