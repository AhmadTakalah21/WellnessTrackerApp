import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';

import 'habitsummary.dart';

class HabitTrackerScreen extends StatelessWidget {
  const HabitTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Habit Tracker",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGoalCard(),
            const SizedBox(height: 20),
            const Text(
              "Today's Habits",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildHabitCard(
                    "Sleep",
                    FontAwesomeIcons.bed,
                    "11:30 PM",
                    100,
                    Colors.pink,
                  ),
                  _buildHabitCard(
                    "Cycling",
                    FontAwesomeIcons.bicycle,
                    "5:30 AM",
                    65,
                    Colors.purple,
                  ),
                  _buildHabitCard(
                    "Read Book",
                    FontAwesomeIcons.book,
                    "6:00 PM",
                    85,
                    Colors.blue,
                  ),
                  _buildHabitCard(
                    "Meditation",
                    FontAwesomeIcons.om,
                    "7:00 AM",
                    90,
                    Colors.orange,
                  ),
                  _buildHabitCard(
                    "Workout",
                    FontAwesomeIcons.dumbbell,
                    "8:00 AM",
                    75,
                    Colors.green,
                  ),
                ],
              ),
            ),
            _buildNewHabitButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.blueAccent, Colors.lightBlueAccent],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Icon(
              FontAwesomeIcons.faceSmile,
              color: Colors.blueAccent,
              size: 30,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Your Daily Goal Almost Done",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "12 of 15 completed",
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(height: 10),
                LinearProgressIndicator(
                  value: 0.8,
                  color: Colors.white,
                  backgroundColor: Colors.white24,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHabitCard(
    String title,
    IconData icon,
    String time,
    int progress,
    Color color,
  ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withAlpha((0.2 * 255).toInt()),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(time, style: TextStyle(color: Colors.grey.shade600)),
        trailing: Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressIndicator(
              value: progress / 100,
              color: color,
              strokeWidth: 5,
            ),
            Text(
              "$progress%",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewHabitButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonColor,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddHabitScreen()),
          );
        },
        child: const Text(
          "+ New Habit",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  String selectedFrequency = "Daily";
  List<bool> selectedDays = [false, false, false, false, false, false, false];
  bool isEveryday = false;
  TimeOfDay selectedTime = TimeOfDay(hour: 10, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Habit",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("Habit Title", "Enter habit name"),
            const SizedBox(height: 20),
            _buildActivitySelector(),
            const SizedBox(height: 20),
            _buildFrequencySelector(),
            const SizedBox(height: 20),
            _buildDaySelector(),
            const SizedBox(height: 20),
            _buildToggle("Every Day", isEveryday, (val) {
              setState(() {
                isEveryday = val;
              });
            }),
            const SizedBox(height: 20),
            _buildTimePicker(),
            const Spacer(),
            _buildAddHabitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 5),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivitySelector() {
    List<IconData> icons = [
      FontAwesomeIcons.dumbbell,
      FontAwesomeIcons.personRunning,
      FontAwesomeIcons.bicycle,
      FontAwesomeIcons.book,
      FontAwesomeIcons.seedling,
      FontAwesomeIcons.dumbbell,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Choose Activity",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          children: List.generate(icons.length, (index) {
            return GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                backgroundColor: Colors.blueAccent.withAlpha((0.1 * 255).toInt()),
                radius: 28,
                child: Icon(icons[index], color: Colors.blueAccent, size: 24),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildFrequencySelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildChip("Daily"),
        _buildChip("Weekly"),
        _buildChip("Monthly"),
      ],
    );
  }

  Widget _buildChip(String label) {
    return ChoiceChip(
      label: Text(label, style: const TextStyle(fontSize: 16)),
      selected: selectedFrequency == label,
      selectedColor: Colors.blueAccent,
      backgroundColor: Colors.grey[200],
      onSelected: (bool selected) {
        setState(() {
          selectedFrequency = label;
        });
      },
    );
  }

  Widget _buildDaySelector() {
    List<String> days = ["S", "M", "T", "W", "T", "F", "S"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedDays[index] = !selectedDays[index];
            });
          },
          child: CircleAvatar(
            backgroundColor:
                selectedDays[index] ? Colors.blueAccent : Colors.grey[200],
            child: Text(
              days[index],
              style: TextStyle(
                color: selectedDays[index] ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildToggle(String label, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.blueAccent,
        ),
      ],
    );
  }

  Widget _buildTimePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Remind at specific time",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        TextButton(
          onPressed: () async {
            TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: selectedTime,
            );
            if (picked != null) {
              setState(() {
                selectedTime = picked;
              });
            }
          },
          child: Text(
            selectedTime.format(context),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddHabitButton() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_)=>HabitSummaryScreen()));


        },
        child: const Text(
          "Habit Summary",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
