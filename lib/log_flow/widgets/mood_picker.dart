import 'package:continual_care_alpha/log_flow/log_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobs_api/jobs_api.dart';

class MoodPicker extends StatelessWidget {
  const MoodPicker({
    super.key,
    required this.prompt,
    required this.cMood,
  });

  final String prompt;
  final bool cMood;

  @override
  Widget build(BuildContext context) {
    final mood = cMood
        ? context.watch<LogBloc>().state.cMood
        : context.watch<LogBloc>().state.iMood;

    // final cMood = context.watch<LogBloc>().state.cMood;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(prompt),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: Mood.values
                  .map<Widget>(
                    (pMood) => MoodBox(
                      mood: pMood,
                      isSelected: pMood == mood ? true : false,
                      onTap: () => {
                        cMood
                            ? context
                                .read<LogBloc>()
                                .add(LogCMoodChanged(pMood))
                            : context
                                .read<LogBloc>()
                                .add(LogIMoodChanged(pMood))
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class MoodBox extends StatelessWidget {
  const MoodBox({
    super.key,
    required this.mood,
    required this.isSelected,
    required this.onTap,
  });

  final Mood mood;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 64,
        width: 64,
        decoration: isSelected
            ? BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Color(0xff626262),
                ),
              )
            : null,
        child: Image.asset(
          'assets/${mood.name}.png',
        ),
      ),
    );
  }
}
