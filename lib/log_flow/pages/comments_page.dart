import 'package:continual_care_alpha/log_flow/log_flow.dart';
import 'package:continual_care_alpha/schedule/widgets/date_ios_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobs_api/jobs_api.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage({super.key});

  static MaterialPage<void> page() {
    return const MaterialPage<void>(child: CommentsPage());
  }

  @override
  Widget build(BuildContext context) {
    final date = context.read<LogBloc>().state.started!;
    final client = context.watch<LogBloc>().state.client;

    return Scaffold(
        appBar: AppBar(
          title: Text(date.dateIosFormat()!),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              context
                  .read<LogBloc>()
                  .add(LogStatusChanged(LogStatus.tasksCompleted));
            },
          ),
        ),
        body: Column(
          children: [
            LogProgress(),
            Expanded(
                child: Column(
              children: [
                MoodPicker(
                  prompt: 'How was $client today?',
                ),
                _Comments(),
              ],
            )),
          ],
        ));
  }
}

class _Comments extends StatelessWidget {
  _Comments();
  final TextEditingController textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final state = context.watch<LogBloc>().state;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: [
          MainTitle(title: 'Comments'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<LogBloc, LogState>(
              // buildWhen: (previous, current) {
              //   return previous.comments!.length != current.comments!.length;
              // },
              builder: (context, state) {
                if (state.comments!.isNotEmpty) {
                  return Container(
                    width: double.maxFinite,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.comments!.length,
                      itemBuilder: ((context, index) {
                        return CommentTile(
                          comment: state.comments![index],
                        );
                      }),
                    ),
                  );
                }
                return Text('no comments yet');
              },
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      'Y',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: textFieldController,
                  decoration: InputDecoration(
                    enabled: !state.status.isLoadingOrSuccess,
                    hintText: 'Add a comment',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        context.read<LogBloc>().add(
                              LogCommentsChanged(
                                Comment(
                                    username: "testing",
                                    comment: textFieldController.text),
                              ),
                            );
                      },
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
