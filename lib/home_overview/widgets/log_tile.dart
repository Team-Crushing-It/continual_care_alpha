import 'package:continual_care_alpha/home_overview/home_overview.dart';
import 'package:flutter/material.dart';
import 'package:logs_api/logs_api.dart';

class LogTile extends StatelessWidget {
  const LogTile({
    Key? key,
    required this.initialLog,
    this.onTap,
  }) : super(key: key);

  final Log initialLog;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        minVerticalPadding: 0,
        onTap: onTap,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Wed Sep 7",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text.rich(
                      overflow: TextOverflow.ellipsis,
                      TextSpan(children: [
                        TextSpan(
                            text: "Mood: ",
                            style: TextStyle(color: Color(0xff989898))),
                        TextSpan(text: "🤩"),
                      ])),
                ),
              ],
            ),
          ],
        ),
        subtitle: Container(
          decoration: ShapeDecoration(
            shape: Border(
              bottom: BorderSide(
                color: Colors.black,
                width: 0.5,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InfoItem(title: "Comments", count: 4),
                InfoItem(title: "Tasks", count: 12),
                InfoItem(title: "IADL", count: 2),
                InfoItem(title: "BADL", count: 5)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
