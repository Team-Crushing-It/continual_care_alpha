import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:jobs_api/jobs_api.dart';

class CommentTile extends StatelessWidget {
  const CommentTile({Key? key, required this.comment}) : super(key: key);
  final Comment comment;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              width: 30.0,
              height: 30.0,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Center(
                  child: Text(comment.username[0],
                      style: TextStyle(color: Colors.white, fontSize: 12))),
            ),
          ),
          Expanded(
            child: Text(
              comment.comment,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}
