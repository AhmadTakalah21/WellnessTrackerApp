import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';



class MedicineDetailsScreen extends StatelessWidget {
  const MedicineDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medication Details',style: TextStyle(color: Colors.black,fontSize: 22),),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: double.infinity,
                  child: Card(
                    color: Colors.white,
                      child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfgTNx22EOakeOrWePio1XRGIchK6LeHGMOg&s", height: 120))),
            ),
            SizedBox(height: 20),
            Text(
              "Paracetamol XL2",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            SizedBox(height: 15),

            // Time Tags
            Row(
              children: [
                TimeTag(text: "After Breakfast", color: Colors.blueAccent),
                SizedBox(width: 10),
                TimeTag(text: "After Dinner", color: Colors.pinkAccent),
              ],
            ),
            SizedBox(height: 20),

            // Medicine Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MedicineStat(title: "This Month", value: "4/31 Taken", icon: Icons.calendar_today, color: Colors.redAccent),
                MedicineStat(title: "Amount", value: "2 Pills/day", icon: Icons.check_circle, color: Colors.blueAccent),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MedicineStat(title: "Cause", value: "High Fever", icon: Icons.local_fire_department, color: Colors.orangeAccent),
                MedicineStat(title: "Cap Size", value: "120 mg", icon: Icons.medical_services, color: Colors.purpleAccent),
              ],
            ),
            SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MedicineStat(title: "This Month", value: "4/31 Taken", icon: Icons.calendar_today, color: Colors.redAccent),
                MedicineStat(title: "Amount", value: "2 Pills/day", icon: Icons.check_circle, color: Colors.blueAccent),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MedicineStat(title: "Cause", value: "High Fever", icon: Icons.local_fire_department, color: Colors.orangeAccent),
                MedicineStat(title: "Cap Size", value: "120 mg", icon: Icons.medical_services, color: Colors.purpleAccent),
              ],
            ),
            Spacer(),


            // Edit Schedule Button
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Edit Schedule", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable Time Tag Widget
class TimeTag extends StatelessWidget {
  final String text;
  final Color color;

  const TimeTag({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha((0.2 * 255).toInt()),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }
}

// Reusable Medicine Stat Widget
class MedicineStat extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const MedicineStat({super.key, required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.42,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 14, color: Colors.grey)),
              Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
