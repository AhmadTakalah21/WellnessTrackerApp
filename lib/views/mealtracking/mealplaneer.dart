import 'package:flutter/material.dart';

import '../../Widgets/custombtn.dart';
import 'mealplans.dart';


class MealPlannerScreen extends StatelessWidget {
  final List<String> days = ["20", "21", "22", "23", "24", "25"];
  final List<String> weekDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri"];
  final int selectedDayIndex = 1;

   MealPlannerScreen({super.key}); // Active day (21st)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: Text("October", style: TextStyle(color: Colors.black, fontSize: 18)),

      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Selector
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(days.length, (index) {
                    bool isActive = index == selectedDayIndex;
                    return Column(
                      children: [
                        Text(weekDays[index], style: TextStyle(color: Colors.grey[600])),
                        SizedBox(height: 4),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          decoration: BoxDecoration(
                            color: isActive ? Colors.purple[100] : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            border: isActive ? Border.all(color: Colors.purple, width: 2) : Border.all(color: Colors.transparent),
                          ),
                          child: Text(days[index], style: TextStyle(fontWeight: FontWeight.bold, color: isActive ? Colors.purple : Colors.black)),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),

            // Calories Remaining Section
            Card(
              color: Colors.white,

              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text("Calories Remaining", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [Text("1,064", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), Text("Goal", style: TextStyle(color: Colors.grey))],
                        ),
                        Text("-", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        Column(
                          children: [Text("0", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), Text("Food", style: TextStyle(color: Colors.grey))],
                        ),
                        Text("+", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        Column(
                          children: [Text("0", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), Text("Exercise", style: TextStyle(color: Colors.grey))],
                        ),
                        Text("=", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        Column(
                          children: [Text("1,064", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)), Text("Remaining", style: TextStyle(color: Colors.grey))],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Meal Plan List
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MealTile(time: "7:00 AM", title: "Breakfast", subtitle: "Overnight oat", calories: "280 kcal", color: Colors.green[100]!),
                    MealTile(time: "10:00 AM", title: "Mid-Morning Snack", subtitle: "Greek Yogurt & Honey", calories: "150 kcal", color: Colors.blue[100]!),
                    MealTile(time: "1:00 PM", title: "Lunch", subtitle: "Grilled Chicken Salad", calories: "320 kcal", color: Colors.orange[100]!),
                    MealTile(time: "4:00 PM", title: "Afternoon Snack", subtitle: "Almonds & Apple", calories: "200 kcal", color: Colors.purple[100]!),
                    MealTile(time: "7:00 PM", title: "Dinner", subtitle: "Salmon with Vegetables", calories: "450 kcal", color: Colors.red[100]!),
                    MealTile(time: "9:30 PM", title: "Late-Night Snack", subtitle: "Dark Chocolate & Green Tea", calories: "120 kcal", color: Colors.grey[300]!),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:   Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 10),
          child: CustomButton(text: 'Add to Meal', onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=>MealPlansScreen()));


          })
      ),
    );
  }
}

class MealTile extends StatelessWidget {
  final String time;
  final String title;
  final String subtitle;
  final String calories;
  final Color color;

  const MealTile({super.key, required this.time, required this.title, required this.subtitle, required this.calories, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(time, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black54)),
            SizedBox(width: 10),
            Expanded(
              child: Card(
                color: color,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.black54)),
                        ],
                      ),
                      Text(calories, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
