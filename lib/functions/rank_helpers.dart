String getRank(int rank) {
  if (rank == 1) {
    return "🥇";
  } else if (rank == 2) {
    return "🥈";
  } else if (rank == 3) {
    return "🥉";
  } else {
    return "  $rank. ";
  }
}

double getRankFontSize(int rank) {
  if (rank < 4) {
    return 20;
  } else {
    return 16;
  }
}
