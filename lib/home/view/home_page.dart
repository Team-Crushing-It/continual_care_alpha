import 'package:continual_care_alpha/home_overview/home_overview.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:continual_care_alpha/home/home.dart';
import 'package:continual_care_alpha/schedule/schedule.dart';

List<Page> onGenerateHomePages(
  HomeState state,
  List<Page<dynamic>> pages,
) {
  if (state.page == CurrentHomePage.schedule) {
    return [SchedulePage.page()];
  }
  if (state.page == CurrentHomePage.overview) {
    return [HomeOverviewPage.page()];
  }

  return pages;
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(
        key: ValueKey('home_page'),
        child: HomePage(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.page);
    return Scaffold(
      body: FlowBuilder(
        onGeneratePages: onGenerateHomePages,
        state: context.select<HomeCubit, HomeState>(
          (cubit) => cubit.state,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _HomeTabButton(
              groupValue: selectedTab,
              value: CurrentHomePage.overview,
              icon: Icons.home_outlined,
              label: 'Home',
              color: Colors.grey,
            ),
            _HomeTabButton(
              groupValue: selectedTab,
              value: CurrentHomePage.schedule,
              icon: Icons.calendar_month_outlined,
              label: 'Schedule',
              color: Colors.grey,
            ),
            _HomeTabButton(
              groupValue: selectedTab,
              value: CurrentHomePage.alert,
              icon: Icons.warning_amber_outlined,
              label: 'Alert',
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTabButton extends StatelessWidget {
  const _HomeTabButton({
    required this.groupValue,
    required this.value,
    required this.icon,
    required this.label,
    required this.color,
  });

  final CurrentHomePage groupValue;
  final CurrentHomePage value;
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: SizedBox(
        width: 90,
        child: InkWell(
          onTap: () => context.read<HomeCubit>().setPage(value),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: groupValue != value
                    ? color
                    : Theme.of(context).colorScheme.secondary,
                size: 32,
              ),
              Text(
                label,
                style: TextStyle(
                    color: groupValue != value
                        ? color
                        : Theme.of(context).colorScheme.secondary,
                    fontWeight: groupValue != value
                        ? FontWeight.normal
                        : FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
