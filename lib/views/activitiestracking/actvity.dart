// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';

class MainInfoModel {
  final String name;
  final String age;
  final String tall;
  final String weight;
  final String illnesses;
  final String waistline;
  final String chestMeasurement;
  final String sholdersMeasurement;
  final String thighCircumference;
  final String ulnaCircumference;
  MainInfoModel({
    required this.name,
    required this.age,
    required this.tall,
    required this.weight,
    required this.illnesses,
    required this.waistline,
    required this.chestMeasurement,
    required this.sholdersMeasurement,
    required this.thighCircumference,
    required this.ulnaCircumference,
  });
}

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  ActivityScreenState createState() => ActivityScreenState();
}

class ActivityScreenState extends State<ActivityScreen> {
  int selectedTab = 1; // 0 = Daily, 1 = Weekly, 2 = Monthly

  final List<MainInfoModel> mainInfoList = [
    MainInfoModel(
      name: 'Alice',
      age: '25',
      tall: '165',
      weight: '60',
      illnesses: 'None',
      waistline: '70',
      chestMeasurement: '85',
      sholdersMeasurement: '40',
      thighCircumference: '50',
      ulnaCircumference: '25',
    ),
    MainInfoModel(
      name: 'Bob',
      age: '30',
      tall: '180',
      weight: '80',
      illnesses: 'Asthma',
      waistline: '85',
      chestMeasurement: '100',
      sholdersMeasurement: '45',
      thighCircumference: '55',
      ulnaCircumference: '30',
    ),
    MainInfoModel(
      name: 'Charlie',
      age: '22',
      tall: '170',
      weight: '70',
      illnesses: 'None',
      waistline: '75',
      chestMeasurement: '90',
      sholdersMeasurement: '42',
      thighCircumference: '52',
      ulnaCircumference: '28',
    ),
    MainInfoModel(
      name: 'Diana',
      age: '28',
      tall: '160',
      weight: '55',
      illnesses: 'Diabetes',
      waistline: '68',
      chestMeasurement: '80',
      sholdersMeasurement: '38',
      thighCircumference: '48',
      ulnaCircumference: '24',
    ),
    MainInfoModel(
      name: 'Ethan',
      age: '35',
      tall: '185',
      weight: '90',
      illnesses: 'Hypertension',
      waistline: '95',
      chestMeasurement: '105',
      sholdersMeasurement: '47',
      thighCircumference: '58',
      ulnaCircumference: '32',
    ),
    MainInfoModel(
      name: 'Fiona',
      age: '27',
      tall: '168',
      weight: '65',
      illnesses: 'None',
      waistline: '72',
      chestMeasurement: '88',
      sholdersMeasurement: '41',
      thighCircumference: '51',
      ulnaCircumference: '26',
    ),
    MainInfoModel(
      name: 'George',
      age: '32',
      tall: '178',
      weight: '75',
      illnesses: 'None',
      waistline: '80',
      chestMeasurement: '95',
      sholdersMeasurement: '44',
      thighCircumference: '53',
      ulnaCircumference: '29',
    ),
    MainInfoModel(
      name: 'Hannah',
      age: '24',
      tall: '162',
      weight: '58',
      illnesses: 'Anemia',
      waistline: '69',
      chestMeasurement: '83',
      sholdersMeasurement: '39',
      thighCircumference: '49',
      ulnaCircumference: '25',
    ),
    MainInfoModel(
      name: 'Ian',
      age: '40',
      tall: '175',
      weight: '78',
      illnesses: 'None',
      waistline: '85',
      chestMeasurement: '98',
      sholdersMeasurement: '46',
      thighCircumference: '54',
      ulnaCircumference: '31',
    ),
    MainInfoModel(
      name: 'Julia',
      age: '26',
      tall: '158',
      weight: '54',
      illnesses: 'Thyroid',
      waistline: '66',
      chestMeasurement: '79',
      sholdersMeasurement: '37',
      thighCircumference: '47',
      ulnaCircumference: '23',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.cs.primary,
        elevation: 10,
        title: Text('user_administration'.tr(), style: context.tt.titleLarge),
      ),
      backgroundColor: context.cs.onSurface,
      body: Padding(
        padding: AppConstants.padding16,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // MainDataTable(
              //   titles: [
              //     "name".tr(),
              //     "age".tr(),
              //     "tall".tr(),
              //     "weight".tr(),
              //     "illnesses".tr(),
              //     "waistline".tr(),
              //     "chest_measurement".tr(),
              //     "sholders_measurement".tr(),
              //     "thigh_circumference".tr(),
              //     "ulna_circumference".tr(),
              //     "action".tr(),
              //   ],
              //   rows:
              //       mainInfoList.map((e) {
              //         return DataRow(
              //           cells: [
              //             DataCell(Center(child: Text(e.name))),
              //             DataCell(Center(child: Text(e.age))),
              //             DataCell(Center(child: Text(e.tall))),
              //             DataCell(Center(child: Text(e.weight))),
              //             DataCell(Center(child: Text(e.illnesses))),
              //             DataCell(Center(child: Text(e.waistline))),
              //             DataCell(Center(child: Text(e.chestMeasurement))),
              //             DataCell(Center(child: Text(e.sholdersMeasurement))),
              //             DataCell(Center(child: Text(e.thighCircumference))),
              //             DataCell(Center(child: Text(e.ulnaCircumference))),
              //             DataCell(
              //               Row(
              //                 children: [
              //                   IconButton(
              //                     onPressed: () {},
              //                     icon: Icon(
              //                       Icons.edit,
              //                       color: context.cs.primary,
              //                     ),
              //                   ),
              //                   IconButton(
              //                     onPressed: () {},
              //                     icon: Icon(
              //                       Icons.delete,
              //                       color: context.cs.error,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ],
              //         );
              //       }).toList(),
              // ),
            ],
          ),
        ),
      ),
    );
    // Scaffold(
    //   backgroundColor: Colors.grey.shade100,
    //   body: SafeArea(
    //     child: SingleChildScrollView(
    //       padding: const EdgeInsets.all(16.0),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           GestureDetector(
    //             onTap: (){
    //               Navigator.push(context, MaterialPageRoute(builder: (_)=>ActivityShedule()));

    //             },
    //               child: buildHeader()),
    //           const SizedBox(height: 20),
    //           buildTabSelector(),
    //           const SizedBox(height: 20),
    //           buildBarChart(),
    //           const SizedBox(height: 20),
    //           buildAdditionalStats(),
    //         ],
    //       ),
    //     ),
    //   ),
    //   bottomNavigationBar: Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: CustomButton(text: 'Next', onTap: (){
    //       Navigator.push(context, MaterialPageRoute(builder: (_)=>ActivityShedule()));

    //     }),
    //   ),
    // );
  }

  // Widget buildHeader() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Text(
  //         "Activity",
  //         style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
  //       ),
  //       Icon(Icons.calendar_today, color: Colors.black54),
  //     ],
  //   );
  // }

  // Widget buildTabSelector() {
  //   List<String> tabs = ["Daily", "Weekly", "Monthly"];

  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     children: List.generate(tabs.length, (index) {
  //       return GestureDetector(
  //         onTap: () {
  //           setState(() {
  //             selectedTab = index;
  //           });
  //         },
  //         child: Container(
  //           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
  //           decoration: BoxDecoration(
  //             color: selectedTab == index ? Colors.deepPurple : Colors.white,
  //             borderRadius: BorderRadius.circular(20),
  //             boxShadow:
  //                 selectedTab == index
  //                     ? [
  //                       BoxShadow(
  //                         color: Colors.deepPurple.shade200,
  //                         blurRadius: 5,
  //                         spreadRadius: 1,
  //                       ),
  //                     ]
  //                     : [],
  //           ),
  //           child: Text(
  //             tabs[index],
  //             style: GoogleFonts.poppins(
  //               fontSize: 16,
  //               fontWeight: FontWeight.w500,
  //               color: selectedTab == index ? Colors.white : Colors.black54,
  //             ),
  //           ),
  //         ),
  //       );
  //     }),
  //   );
  // }

  // Widget buildBarChart() {
  //   return Container(
  //     height: 200,
  //     padding: const EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(15),
  //       boxShadow: [
  //         BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1),
  //       ],
  //     ),
  //     child: BarChart(
  //       BarChartData(
  //         barGroups: [
  //           for (int i = 0; i < 7; i++)
  //             BarChartGroupData(
  //               x: i,
  //               barRods: [
  //                 BarChartRodData(
  //                   fromY: 0, // Always start from 0
  //                   toY: (5 + i).toDouble(), // Height of the bar
  //                   color: Colors.orange, // Bar color
  //                   width: 14,
  //                   borderRadius: BorderRadius.circular(8),
  //                 ),
  //               ],
  //             ),
  //         ],
  //         borderData: FlBorderData(show: false),
  //         gridData: FlGridData(show: false),
  //         titlesData: FlTitlesData(show: false),
  //       ),
  //     ),
  //   );
  // }

  // Widget buildAdditionalStats() {
  //   return Column(
  //     children: [
  //       buildStatCard(
  //         value: "4967",
  //         label: "Steps",
  //         icon: FontAwesomeIcons.personWalking,
  //         progress: 0.7,
  //         gradientColors: [Colors.blueAccent, Colors.blue],
  //       ),
  //       const SizedBox(height: 12),
  //       buildStatCard(
  //         value: "78 bpm",
  //         label: "Heart Rate",
  //         icon: FontAwesomeIcons.heartPulse,
  //         progress: 0.5,
  //         gradientColors: [Colors.redAccent, Colors.red],
  //       ),
  //       const SizedBox(height: 12),
  //       buildStatCard(
  //         value: "49 hours",
  //         label: "Sleep",
  //         icon: FontAwesomeIcons.bed,
  //         progress: 0.8,
  //         gradientColors: [Colors.purpleAccent, Colors.purple],
  //       ),
  //       const SizedBox(height: 12),
  //       buildStatCard(
  //         value: "16 hours",
  //         label: "Active Time",
  //         icon: FontAwesomeIcons.fire,
  //         progress: 0.6,
  //         gradientColors: [Colors.orangeAccent, Colors.orange],
  //       ),
  //       const SizedBox(height: 12),
  //       buildStatCard(
  //         value: "2.5L",
  //         label: "Water Intake",
  //         icon: FontAwesomeIcons.droplet,
  //         progress: 0.9,
  //         gradientColors: [Colors.lightBlueAccent, Colors.lightBlue],
  //       ),
  //       const SizedBox(height: 12),
  //       buildStatCard(
  //         value: "8900",
  //         label: "Calories Burned",
  //         icon: FontAwesomeIcons.fireFlameCurved,
  //         progress: 0.75,
  //         gradientColors: [Colors.pinkAccent, Colors.pink],
  //       ),
  //     ],
  //   );
  // }

  // Widget buildStatCard({
  //   required String value,
  //   required String label,
  //   required IconData icon,
  //   required double progress,
  //   required List<Color> gradientColors,
  // }) {
  //   return Container(
  //     padding: const EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       gradient: LinearGradient(
  //         colors: gradientColors,
  //         begin: Alignment.topLeft,
  //         end: Alignment.bottomRight,
  //       ),
  //       borderRadius: BorderRadius.circular(20),
  //       boxShadow: [
  //         BoxShadow(
  //           color: gradientColors.last.withAlpha((0.3 * 255).toInt()),
  //           blurRadius: 10,
  //           spreadRadius: 2,
  //         ),
  //       ],
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Row(
  //           children: [
  //             // Icon
  //             CircleAvatar(
  //               radius: 24,
  //               backgroundColor: Colors.white.withAlpha((0.2 * 255).toInt()),
  //               child: Icon(icon, color: Colors.white, size: 28),
  //             ),
  //             const SizedBox(width: 12),
  //             // Text Details
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   value,
  //                   style: const TextStyle(
  //                     fontSize: 18,
  //                     fontWeight: FontWeight.bold,
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //                 Text(
  //                   label,
  //                   style: const TextStyle(fontSize: 14, color: Colors.white70),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //         // Progress Indicator
  //         Stack(
  //           alignment: Alignment.center,
  //           children: [
  //             SizedBox(
  //               width: 40,
  //               height: 40,
  //               child: CircularProgressIndicator(
  //                 value: progress,
  //                 strokeWidth: 5,
  //                 backgroundColor: Colors.white.withAlpha((0.2 * 255).toInt()),
  //                 valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
  //               ),
  //             ),
  //             Text(
  //               "${(progress * 100).toInt()}%",
  //               style: const TextStyle(
  //                 fontSize: 12,
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.white,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
