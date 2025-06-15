import 'package:flutter/material.dart';

import 'heartstats.dart';



class HeartMeasure extends StatelessWidget {
  const HeartMeasure({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F2FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),

          // Measuring Text
          Text(
            "Measuring",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 30),

          // BRM Circle Display
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "76", // Dynamic BRM Value
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "BRM",
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.favorite, color: Colors.red, size: 20),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Average 71",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 40),

          // Measuring in progress Text
          Text(
            "Measuring in progress",
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),

          SizedBox(height: 40),

          // Fingerprint Scan Button
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=>HeartStatsScreen()));

              // Add scan functionality here
            },
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Icon(Icons.fingerprint, size: 40, color: Colors.blueAccent),
            ),
          ),
        ],
      ),
    );
  }
}
