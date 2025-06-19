import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wellnesstrackerapp/features/items/view/items_view.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/keep_alive_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_add_floating_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_tab_bar.dart';

class ChartModel {
  ChartModel({
    required this.xAxisProperty,
    required this.yAxisProperty,
  });

  final String xAxisProperty;
  final List<double> yAxisProperty;
}

abstract class PointsViewCallBacks {
  void onTabSelected(int index);
  void onGoToStoreTap();
}

@RoutePage()
class PointsView extends StatelessWidget {
  const PointsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const PointsPage();
  }
}

class PointsPage extends StatefulWidget {
  const PointsPage({super.key});

  @override
  State<PointsPage> createState() => _PointsPageState();
}

class _PointsPageState extends State<PointsPage>
    with SingleTickerProviderStateMixin
    implements PointsViewCallBacks {
  PageController pageController = PageController();
  late TabController tabController;
  int selectedTab = 0;

  final List<String> tabBarTitles = ["points", "get_points_methods"];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabBarTitles.length, vsync: this);
  }

  @override
  void onTabSelected(int index) {
    setState(() => selectedTab = index);
    tabController.animateTo(index);
    pageController.jumpToPage(index);
  }

  @override
  void onGoToStoreTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemsView(),
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartModel> data = [
      ChartModel(
        xAxisProperty: "month 1",
        yAxisProperty: [100],
      ),
      ChartModel(
        xAxisProperty: "month 2",
        yAxisProperty: [300],
      ),
      ChartModel(
        xAxisProperty: "month 3",
        yAxisProperty: [350],
      ),
      ChartModel(
        xAxisProperty: "month 5",
        yAxisProperty: [500],
      ),
      ChartModel(
        xAxisProperty: "month 6",
        yAxisProperty: [700],
      ),
      ChartModel(
        xAxisProperty: "month 7",
        yAxisProperty: [700],
      ),
      ChartModel(
        xAxisProperty: "month 8",
        yAxisProperty: [1000],
      ),
    ];
    final List<Widget> pages = [
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: buildStepCounter(context),
                ),
              ),
            ),
            SizedBox(height: 40),
            SfCartesianChart(
              borderColor: Colors.black,
              borderWidth: 0.5,
              plotAreaBorderWidth: 1,
              title:
                  ChartTitle(text: "التقدم", textStyle: context.tt.titleLarge),
              primaryYAxis: NumericAxis(
                minimum: 0,
                maximum: 2000,
                interval: 200,
                labelStyle: context.tt.bodyMedium,
                majorGridLines: const MajorGridLines(
                  width: 1,
                  color: Colors.grey,
                  dashArray: [0, 0],
                ),
              ),
              primaryXAxis: CategoryAxis(
                interval: 1,
                labelStyle: context.tt.titleMedium,
                majorGridLines: const MajorGridLines(
                  width: 1,
                  color: Colors.grey,
                  dashArray: [0, 0],
                ),
              ),
              series: List<CartesianSeries<ChartModel, String>>.generate(
                data[0].yAxisProperty.length,
                (index) => LineSeries<ChartModel, String>(
                  width: 3,
                  animationDuration: 1500,
                  color: context.cs.primary,
                  dataSource: data,
                  xValueMapper: (ChartModel xAxis, ind) => xAxis.xAxisProperty,
                  yValueMapper: (ChartModel yAxis, ind) =>
                      yAxis.yAxisProperty[index],
                ),
              ),
            ),
            // const SizedBox(height: 20),
            // buildStatsRow(),
            // const SizedBox(height: 20),
            // buildFriendsList(context),
          ],
        ),
      ),
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            ...List.generate(
              10,
              (index) {
                return Card(
                  child: Padding(
                    padding: AppConstants.padding20,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.line_weight, color: context.cs.primary),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "you can get 500 point by losing 3 kgs weekly",
                                style: context.tt.bodyLarge,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    ];
    return Scaffold(
      backgroundColor: context.cs.onSurface,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.cs.primary,
        elevation: 10,
        title: Text('points'.tr(), style: context.tt.titleLarge),
      ),
      body: Column(
        children: [
          MainTabBar(
            titles: tabBarTitles,
            tabController: tabController,
            onTapSelected: onTabSelected,
            selectedTab: selectedTab,
            isScrollable: false,
          ),
          Expanded(
            child: PageView(
              physics: const BouncingScrollPhysics(),
              controller: pageController,
              onPageChanged: onTabSelected,
              children: List.generate(
                tabBarTitles.length,
                (index) => Padding(
                  padding: AppConstants.padding16,
                  child: KeepAliveWidget(child: pages[index]),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: MainFloatingButton(
        icon: Icons.add_shopping_cart_outlined,
        onTap: onGoToStoreTap,
      ),
    );
  }

  Widget buildStepCounter(BuildContext context) {
    return Padding(
      padding: AppConstants.paddingV32,
      child: Column(
        children: [
          Column(
            children: [
              Text(
                "1000",
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "نقطة",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildStatsRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          buildStatCard("1.9 km", FontAwesomeIcons.shoePrints, Colors.blue),
          buildStatCard("130 kcal", FontAwesomeIcons.fire, Colors.purple),
          buildStatCard(
            "3.2 km/h",
            FontAwesomeIcons.guaraniSign,
            Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget buildStatCard(String value, IconData icon, Color bgColor) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: bgColor.withAlpha((0.1 * 255).toInt()),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: bgColor,
            radius: 15,
            child: FaIcon(icon, color: Colors.white, size: 14),
          ),
          const SizedBox(width: 8),
          Text(value, style: GoogleFonts.poppins(fontSize: 14)),
        ],
      ),
    );
  }

  Widget buildFriendsList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "الأصدقاء",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "عرض الكل",
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: context.cs.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        buildFriendItem(
          "Robert",
          "4085",
          "2.7 km",
          "190 kcal",
          "2.3 km/h",
          Colors.red,
        ),
        buildFriendItem(
          "Valery",
          "304",
          "0.3 km",
          "64 kcal",
          "0.5 km/h",
          Colors.purple,
        ),
        buildFriendItem(
          "Max",
          "10238",
          "8 km",
          "315 kcal",
          "5 km/h",
          Colors.blue,
        ),
        buildFriendItem(
          "Robert",
          "4085",
          "2.7 km",
          "190 kcal",
          "2.3 km/h",
          Colors.red,
        ),
        buildFriendItem(
          "Valery",
          "304",
          "0.3 km",
          "64 kcal",
          "0.5 km/h",
          Colors.purple,
        ),
        buildFriendItem(
          "Max",
          "10238",
          "8 km",
          "315 kcal",
          "5 km/h",
          Colors.blue,
        ),
        buildFriendItem(
          "Robert",
          "4085",
          "2.7 km",
          "190 kcal",
          "2.3 km/h",
          Colors.red,
        ),
        buildFriendItem(
          "Valery",
          "304",
          "0.3 km",
          "64 kcal",
          "0.5 km/h",
          Colors.purple,
        ),
        buildFriendItem(
          "Max",
          "10238",
          "8 km",
          "315 kcal",
          "5 km/h",
          Colors.blue,
        ),
        SizedBox(height: 80),
      ],
    );
  }

  Widget buildFriendItem(
    String name,
    String steps,
    String distance,
    String kcal,
    String speed,
    Color color,
  ) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withAlpha((0.1 * 255).toInt()),
          backgroundImage: NetworkImage(
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8fDA%3D',
          ),
        ),
        title: Text(
          name,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        subtitle: Row(
          children: [
            Text("$distance | ", style: GoogleFonts.poppins(fontSize: 12)),
            Text("$kcal | ", style: GoogleFonts.poppins(fontSize: 12)),
            Text(speed, style: GoogleFonts.poppins(fontSize: 12)),
          ],
        ),
        trailing: Text(
          steps,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}
