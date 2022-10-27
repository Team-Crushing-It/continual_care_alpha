import 'package:continual_care_alpha/log_flow/log_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobs_api/jobs_api.dart';

class Comments extends StatelessWidget {
  Comments();
  final TextEditingController textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final state = context.watch<LogBloc>().state;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                                    username: 'value',

                                    // context
                                    //     .read<AppBloc>()
                                    //     .state
                                    //     .user
                                    //     .name!,
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
