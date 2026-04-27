import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hackabile/classes/stats_object.dart';
import 'package:hackabile/widgets/chart_template.dart';
import 'package:hackabile/widgets/info_card_template.dart';

class StatsWidgets extends StatelessWidget {
  const StatsWidgets({super.key, required this.statsObject});

  final StatsObject statsObject;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        InfoCardTemplate(
          title: "Total Time",
          data: statsObject.humanReadableTotal,
        ),
        InfoCardTemplate(title: "Streak", data: "${statsObject.streak} days"),
        ChartTemplate(
          title: "Projects",
          child: Padding(
            padding: const EdgeInsets.only(right: 96),
            child: SizedBox(
              height: statsObject.projects.length * 24,
              child: BarChart(
                BarChartData(
                  rotationQuarterTurns: 1,
                  alignment: BarChartAlignment.center,
                  groupsSpace: 8,

                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  barGroups: List.generate(
                    statsObject.projects.length,
                    (index) => BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: statsObject.projects[index].totalSeconds
                              .toDouble(),
                          label: BarChartRodLabel(
                            text: statsObject.projects[index].name,
                          ),
                          width: 16,

                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        ChartTemplate(
          title: "Languages",
          child: SizedBox(
            height: 512,
            child: PieChart(
              PieChartData(
                sections: List.generate(
                  statsObject.languages.length,
                  (index) => PieChartSectionData(
                    value: statsObject.languages[index].totalSeconds.toDouble(),
                    color: statsObject.languages[index].color,
                    title: statsObject.languages[index].name,
                    radius: 175,
                    titleStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                centerSpaceRadius: 0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
