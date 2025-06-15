import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';

import 'heartmeasure.dart';



class Heart1 extends StatelessWidget {
  const Heart1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F2FA),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hello\nHasan",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage("https://img.freepik.com/free-psd/portrait-man-teenager-isolated_23-2151745771.jpg"), // Add user image
                  ),
                ],
              ),

              SizedBox(height: 20),

              // BRM Measurement Title
              Center(
                child: Column(
                  children: [
                    Text(
                      "Measure Your BRM",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "on the way!",
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                    SizedBox(height: 20),
                    // Heart Image
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        color: Colors.white,

                        child: Image.network(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMev6WTSvcyaeo661SGCS8KFQxzldgg6AIqQ&s", // Add heart image in assets folder
                          height: 150,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),

              // Heart Rate Zone Card
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Heart rate zone",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),

                    // Heart Rate Indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildHeartRateLabel("60", "Average", Colors.yellow),
                        _buildHeartRateLabel("102", "Healthy", Colors.green),
                        _buildHeartRateLabel("142", "Maximum", Colors.orange),
                        _buildHeartRateLabel("183", "Danger", Colors.red),
                      ],
                    ),

                    SizedBox(height: 15),

                    // Measure BRM Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>HeartMeasure()));


                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text(
                        "Measure BRM",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeartRateLabel(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
        ),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.black54)),
      ],
    );
  }
}
