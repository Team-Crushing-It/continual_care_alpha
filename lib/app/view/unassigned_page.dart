import 'package:continual_care_alpha/app/app.dart';
import 'package:continual_care_alpha/app/widgets.dart/animated_logo.dart';
import 'package:continual_care_alpha/edit_job/edit_job.dart';
import 'package:continual_care_alpha/home_overview/bloc/home_overview_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

class UnassignedPage extends StatelessWidget {
  const UnassignedPage({super.key});

  static Page page() => const MaterialPage<void>(
        key: ValueKey('unassigned_page'),
        child: UnassignedPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 36,
          child: Image.asset('assets/logo_dark_nobg.png'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Container(
                  width: 750,
                  height: 300,
                  child:
                      const RiveAnimation.asset('assets/animation_light.riv'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Container(
                  width: 655,
                  child: Image.asset('assets/logo_light.png'),
                ),
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Text(
                'Please contact your coordinator to be added to your associated group',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          BottomButton(
            onPressed: () {
              context.read<AppBloc>().add(AppLogoutRequested());
            },
            pressable: true,
            title: 'Log out',
          )
        ],
      ),
    );
  }
}
