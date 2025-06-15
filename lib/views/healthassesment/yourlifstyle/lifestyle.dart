import 'package:flutter/material.dart';

class ActivityLevelScreen extends StatefulWidget {
  const ActivityLevelScreen({super.key});

  @override
  ActivityLevelScreenState createState() => ActivityLevelScreenState();
}

class ActivityLevelScreenState extends State<ActivityLevelScreen> {
  int selectedOption = 0; // Default selection

  final List<String> activityLevels = [
    "Sedentary (little or no exercise)",
    "Lightly Active (1-3 days of exercise per week)",
    "Moderately Active (3-5 days of exercise per week)",
    "Very Active (6-7 days of exercise per week)",
    "Athlete (Intense daily training)",
  ];

  // void _navigateToNextScreen() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => SleepHoursScreen(),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Activity Level",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question Text
            const Text(
              "How active is your lifestyle?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Options List
            Expanded(
              child: ListView.builder(
                itemCount: activityLevels.length,
                itemBuilder: (context, index) {
                  bool isSelected = selectedOption == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedOption = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.deepPurple.shade100 : Colors.white,
                        border: Border.all(
                          color: isSelected ? Colors.deepPurple : Colors.grey.shade300,
                          width: isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          if (isSelected)
                            BoxShadow(
                              color: Colors.deepPurple.shade100,
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                            color: isSelected ? Colors.deepPurple : Colors.grey,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              activityLevels[index],
                              style: TextStyle(
                                fontSize: 16,
                                color: isSelected ? Colors.deepPurple.shade800 : Colors.black87,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Next Button at the Bottom
            // SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     onPressed: _navigateToNextScreen,
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.deepPurple,
            //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            //       padding: const EdgeInsets.symmetric(vertical: 16),
            //     ),
            //     child: const Text("Next", style: TextStyle(fontSize: 18, color: Colors.white)),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}


