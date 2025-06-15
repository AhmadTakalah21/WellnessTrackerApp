import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PersonalizedPlanScreen extends StatelessWidget {
  const PersonalizedPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Personalized Plan',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 10),
            _buildPlanCard(
              context,
              title: 'Diet Plan',
              description:
                  'Personalized meal plans based on your dietary needs.',
              icon: FontAwesomeIcons.utensils,
              color: Colors.green,
              nextScreen: DietPlanScreen(),
            ),
            _buildPlanCard(
              context,
              title: 'Workout Plan',
              description: 'Custom workouts tailored to your fitness goals.',
              icon: FontAwesomeIcons.dumbbell,
              color: Colors.blue,
              nextScreen: WorkoutPlanScreen(),
            ),
            _buildPlanCard(
              context,
              title: 'Wellness Plan',
              description: 'Relaxation & stress management techniques.',
              icon: FontAwesomeIcons.spa,
              color: Colors.purple,
              nextScreen: WellnessPlanScreen(),
            ),
            _buildPlanCard(
              context,
              title: 'Mindfulness',
              description: 'Guided meditation & relaxation exercises.',
              icon: FontAwesomeIcons.brain,
              color: Colors.orange,
              nextScreen: MindfulnessScreen(),
            ),
            _buildPlanCard(
              context,
              title: 'Hydration Tracking',
              description: 'Stay hydrated with personalized reminders.',
              icon: FontAwesomeIcons.droplet,
              color: Colors.cyan,
              nextScreen: HydrationScreen(),
            ),
            _buildPlanCard(
              context,
              title: 'Sleep Optimization',
              description: 'Improve sleep quality with expert tips.',
              icon: FontAwesomeIcons.moon,
              color: Colors.indigo,
              nextScreen: SleepOptimizationScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Colors.deepPurple, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Image.network(
              'https://www.pngplay.com/wp-content/uploads/5/Health-Wellness-Yoga-Icon-PNG.png',
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'A custom plan tailored to your lifestyle and health goals.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildPlanCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required Widget nextScreen,
  }) {
    return GestureDetector(
      onTap: () {
        // TODO
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => DashboardView()),
        // );
      },
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: color.withAlpha((0.2 * 255).toInt()),
            child: Icon(icon, color: color),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(description),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
        ),
      ),
    );
  }
}

// Dummy Screens for Navigation
class DietPlanScreen extends StatelessWidget {
  const DietPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Diet Plan")),
      body: Center(child: Text("Diet Plan Details")),
    );
  }
}

class WorkoutPlanScreen extends StatelessWidget {
  const WorkoutPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Workout Plan")),
      body: Center(child: Text("Workout Plan Details")),
    );
  }
}

class WellnessPlanScreen extends StatelessWidget {
  const WellnessPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Wellness Plan")),
      body: Center(child: Text("Wellness Plan Details")),
    );
  }
}

class MindfulnessScreen extends StatelessWidget {
  const MindfulnessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mindfulness")),
      body: Center(child: Text("Mindfulness Details")),
    );
  }
}

class HydrationScreen extends StatelessWidget {
  const HydrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hydration Tracking")),
      body: Center(child: Text("Hydration Tracking Details")),
    );
  }
}

class SleepOptimizationScreen extends StatelessWidget {
  const SleepOptimizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sleep Optimization")),
      body: Center(child: Text("Sleep Optimization Details")),
    );
  }
}
