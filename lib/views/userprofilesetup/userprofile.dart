import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/Widgets/custombtn.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import '../../widgets/customtextfield.dart';


class UserProfileSetupScreen extends StatefulWidget {
  const UserProfileSetupScreen({super.key});

  @override
  UserProfileSetupScreenState createState() => UserProfileSetupScreenState();
}

class UserProfileSetupScreenState extends State<UserProfileSetupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  String? _selectedGender;
  String? _selectedTargetWeight;

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _targetWeightOptions = ['Lose Weight', 'Maintain Weight', 'Gain Weight'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Profile Setup"),
        centerTitle: true,

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(label: "Full Name", controller: _nameController, icon: Icons.person),
            const SizedBox(height: 10),
            CustomTextField(label: "Age (18 - 100)", controller: _ageController, icon: Icons.calendar_today),
            const SizedBox(height: 10),
            _buildDropdown("Select Gender", _selectedGender, _genders, (value) {
              setState(() => _selectedGender = value);
            }),
            const SizedBox(height: 10),
            CustomTextField(label: "Height (cm or ft & in)", controller: _heightController, icon: Icons.height),
            const SizedBox(height: 10),
            CustomTextField(label: "Current Weight (kg or lbs)", controller: _weightController, icon: Icons.monitor_weight),
            const SizedBox(height: 10),
            _buildDropdown("Target Weight", _selectedTargetWeight, _targetWeightOptions, (value) {
              setState(() => _selectedTargetWeight = value);
            }),
            const SizedBox(height: 20),
            CustomButton(text: 'Continue', onTap: (){}),
            
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String hint, String? selectedValue, List<String> items, ValueChanged<String?> onChanged) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textFormFieldBorderColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: selectedValue,
          hint: Text(hint, style: const TextStyle(color: Colors.black54, fontSize: 16)),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(fontSize: 16)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
