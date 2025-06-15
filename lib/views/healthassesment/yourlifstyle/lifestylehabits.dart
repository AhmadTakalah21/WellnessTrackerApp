import 'package:flutter/material.dart';

class AlcoholSmokingScreen extends StatefulWidget {
  const AlcoholSmokingScreen({super.key});

  @override
  AlcoholSmokingScreenState createState() => AlcoholSmokingScreenState();
}

class AlcoholSmokingScreenState extends State<AlcoholSmokingScreen> {
  int selectedOption = 0; // First option preselected

  final List<String> options = [
    "Yes, regularly",
    "Occasionally",
    "No, never",
  ];

  // void _navigateToNextScreen() {
  //   // Replace with the actual next screen
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) =>  PreExistingConditionsScreen()),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,

        title: const Text("Lifestyle Habits", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Do you consume alcohol or smoke?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
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
                              options[index],
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