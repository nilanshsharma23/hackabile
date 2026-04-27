class LeaderboardEntryObject {
  LeaderboardEntryObject({
    required this.rank,
    required this.username,
    required this.avatarUrl,
    required this.totalSeconds,
  });

  final int rank;
  final String username;
  final String avatarUrl;
  final int totalSeconds;
}
