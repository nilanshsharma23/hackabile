import 'package:flutter/material.dart';
import 'package:hackabile/classes/leaderboard_entry_object.dart';
import 'package:hackabile/functions/format_seconds.dart';
import 'package:hackabile/functions/rank_helpers.dart';

class LeaderboardEntryTemplate extends StatefulWidget {
  const LeaderboardEntryTemplate({
    super.key,
    required this.leaderboardEntryObject,
  });

  final LeaderboardEntryObject leaderboardEntryObject;

  @override
  State<LeaderboardEntryTemplate> createState() =>
      _LeaderboardEntryTemplateState();
}

class _LeaderboardEntryTemplateState extends State<LeaderboardEntryTemplate> {
  bool showTime = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 8,
              children: [
                Text(
                  getRank(widget.leaderboardEntryObject.rank),
                  style: TextStyle(
                    fontSize: getRankFontSize(
                      widget.leaderboardEntryObject.rank,
                    ),
                  ),
                ),
                CircleAvatar(
                  foregroundImage: NetworkImage(
                    widget.leaderboardEntryObject.avatarUrl,
                  ),
                  radius: 12,
                ),
                Text(
                  widget.leaderboardEntryObject.username,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  showTime = !showTime;
                });
              },
              icon: Icon(
                showTime ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              ),
            ),
          ],
        ),
        if (showTime)
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: "Time: ", style: TextStyle(fontSize: 20)),
                TextSpan(
                  text: formatSeconds(
                    totalSeconds: widget.leaderboardEntryObject.totalSeconds,
                  ),
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
