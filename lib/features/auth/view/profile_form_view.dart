import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellnesstrackerapp/features/auth_manager/bloc/auth_manager_bloc.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';

@RoutePage()
class CompleteProfileFormView extends StatefulWidget {
  const CompleteProfileFormView({super.key});

  @override
  State<CompleteProfileFormView> createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileFormView> {
  late final AuthManagerBloc authManagerBloc = context.read();
  final _formKey = GlobalKey<FormState>();

  final Map<String, TextEditingController> _controllers = {
    'age': TextEditingController(),
    'chronicDiseases': TextEditingController(),
    'waist': TextEditingController(),
    'chest': TextEditingController(),
    'shoulders': TextEditingController(),
    'thigh': TextEditingController(),
    'arm': TextEditingController(),
    'notes': TextEditingController(),
  };

  String? selectedHeight;
  String? selectedWeight;

  final List<String> heightOptions = [for (int i = 140; i <= 210; i++) '$i سم'];
  final List<String> weightOptions = [for (int i = 40; i <= 160; i++) '$i كغ'];

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      authManagerBloc.add(ProfileFormCompletedRequested());
      MainSnackBar.showSuccessMessage(context, 'تم حفظ المعلومات بنجاح');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('استكمال الملف الشخصي'),
        backgroundColor: theme.primaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Text(
                  'يرجى تعبئة البيانات التالية بدقة:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 20),
              _buildSectionTitle('المعلومات الأساسية'),
              const SizedBox(height: 10),
              _buildDropdownField(
                label: 'الطول (سم)',
                value: selectedHeight,
                items: heightOptions,
                onChanged: (value) => setState(() => selectedHeight = value),
              ),
              const SizedBox(height: 12),
              _buildDropdownField(
                label: 'الوزن (كغ)',
                value: selectedWeight,
                items: weightOptions,
                onChanged: (value) => setState(() => selectedWeight = value),
              ),
              const SizedBox(height: 12),
              _buildTextField('age'),
              const SizedBox(height: 20),
              _buildSectionTitle('مقاسات الجسم'),
              const SizedBox(height: 10),
              _buildTextField('waist'),
              _buildTextField('chest'),
              _buildTextField('shoulders'),
              _buildTextField('thigh'),
              _buildTextField('arm'),
              const SizedBox(height: 20),
              _buildSectionTitle('معلومات صحية'),
              const SizedBox(height: 10),
              _buildTextField('chronicDiseases'),
              _buildTextField('notes'),
              const SizedBox(height: 30),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          theme.primaryColor.withValues(alpha: 0.9),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'حفظ ومتابعة',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.cairo(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    final theme = Theme.of(context);

    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.primaryColor),
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
      ),
      items:
          items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
      validator: (val) =>
          val == null || val.isEmpty ? 'يرجى اختيار $label' : null,
    );
  }

  Widget _buildTextField(String key) {
    final label = _getLabel(key);
    final controller = _controllers[key]!;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: key == 'notes' || key == 'chronicDiseases'
            ? TextInputType.multiline
            : TextInputType.number,
        maxLines: key == 'notes' || key == 'chronicDiseases' ? 3 : 1,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: theme.primaryColor, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                BorderSide(color: theme.primaryColor.withValues(alpha: 0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: theme.primaryColor),
          ),
          labelStyle: const TextStyle(color: Colors.black),
          fillColor: Colors.grey.shade100,
          filled: true,
        ),
        validator: (value) {
          if ((value == null || value.isEmpty) && key != 'notes') {
            return 'هذا الحقل مطلوب';
          }
          return null;
        },
      ),
    );
  }

  String _getLabel(String key) {
    switch (key) {
      case 'age':
        return 'العمر';
      case 'chronicDiseases':
        return 'الأمراض المزمنة';
      case 'waist':
        return 'محيط الخصر (سم)';
      case 'chest':
        return 'محيط الصدر (سم)';
      case 'shoulders':
        return 'محيط الكتفين (سم)';
      case 'thigh':
        return 'محيط الفخذ (سم)';
      case 'arm':
        return 'محيط الذراع (سم)';
      case 'notes':
        return 'ملاحظات إضافية';
      default:
        return '';
    }
  }
}
