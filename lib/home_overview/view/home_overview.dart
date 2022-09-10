import 'package:continual_care_alpha/home_overview/cubit/home_overview_cubit.dart';
import 'package:continual_care_alpha/home_overview/home_overview.dart';
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
        create: (context) =>
            HomeOverviewCubit(repository: context.read<JobsRepository>())
              ..getUpcoming(),
        child: HomeOverviewView());
  }
}

class HomeOverviewView extends StatelessWidget {
  const HomeOverviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('whole thing');
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Overview'),
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      padding: EdgeInsets.only(bottom: 4),
                      width: double.maxFinite,
                      child: Text(
                        "Upcoming Job",
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
                    BlocBuilder<HomeOverviewCubit, HomeOverviewState>(
                      builder: (context, state) {
                        print('inBlocBuilder');
                        if (state.job != null) {
                          return JobListTile(job: state.job!);
                        }
                        return Center(child: Text("No upcomming jobs"));
                      },
                    ),
                  ],
                ),
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
        ));
  }
}
