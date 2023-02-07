import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProjectStatisticsCards extends StatelessWidget {
  late int nbrF;
  late int nbrR;

  ProjectStatisticsCards({required this.nbrF, required this.nbrR});
double progress =0;
double progressF = 0;
  @override
  Widget build(BuildContext context) {
    progress =nbrR/(nbrR+nbrF);
    progressF = nbrF/(nbrR+nbrF);

   progress = double.parse(progress.toStringAsFixed(2));
   progressF= double.parse(progressF.toStringAsFixed(2));
   print(progressF.toString());
    return Row(
      children: [
        ProjectStatisticsCard(
          count: nbrR.toString(),
          name: 'Tous les projets régies',
          descriptions: '',
          progress: progress,
          progressString: (progress*100).toString()+"%",
          color: Colors.greenAccent,
        ),
        ProjectStatisticsCard(
          color: Colors.redAccent,
          count: nbrF.toString(),
          name: 'Tous les projets forfaits',
          descriptions: '',
          progress: progressF,
          progressString: (progressF*100).toString()+"%",
        ),
      ],
    );
  }
}

class ProjectStatisticsCard extends StatelessWidget {
  final String count;
  final String name;
  final String descriptions;
  final double progress;
  final String progressString;
  final Color color;

  const ProjectStatisticsCard({
    required this.count,
    required this.descriptions,
    required this.name,
    required this.progress,
    required this.progressString,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 40.0, right: 20.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        height: 85.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    count,
                    style: GoogleFonts.quicksand(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Text(
                    name,
                    style: GoogleFonts.quicksand(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    descriptions,
                    style: GoogleFonts.quicksand(
                      fontSize: 10.0,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
            CircularPercentIndicator(
              radius: 40.0,
              lineWidth: 4.5,
              percent: progress,
              circularStrokeCap: CircularStrokeCap.round,
              center: Text(
                progressString,
                style: GoogleFonts.quicksand(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
              progressColor: Colors.white,
              startAngle: 270,
              backgroundColor: Colors.white54,
            ),
          ],
        ),
      ),
    );
  }
}
