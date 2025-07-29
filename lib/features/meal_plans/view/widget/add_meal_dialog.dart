import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/features/ingredients/model/ingredient_model/ingredient_model.dart';
import 'package:wellnesstrackerapp/features/meals/model/ingredient_with_quantity_model/ingredient_with_quantity_model.dart';
import 'package:wellnesstrackerapp/features/meals/model/meal_model/meal_model.dart';
import 'package:wellnesstrackerapp/global/models/ingredient_unit_enum.dart';
import 'package:wellnesstrackerapp/global/models/meal_type_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';

class AddMealDialog extends StatefulWidget {
  const AddMealDialog({super.key});

  @override
  State<AddMealDialog> createState() => _AddMealDialogState();
}

class _AddMealDialogState extends State<AddMealDialog> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final videoLinkController = TextEditingController();

  MealTypeEnum? selectedType;
  File? selectedFile;

  final List<IngredientWithQuantityModel> ingredients = [];

  Future<void> _addIngredientDialog() async {
    final nameCtrl = TextEditingController();
    final qtyCtrl = TextEditingController();
    IngredientUnitEnum selectedUnit = IngredientUnitEnum.gram;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        final theme = Theme.of(context);
        final primaryColor = theme.colorScheme.primary;
        final primaryTextColor = theme.primaryColorDark;
        final grayColor = theme.disabledColor;

        return Dialog(
          insetPadding: const EdgeInsets.all(40),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Title
                  Row(
                    children: [
                      Icon(Icons.kitchen, color: primaryColor),
                      const SizedBox(width: 12),
                      Text(
                        "add_ingredient".tr(),
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: primaryTextColor,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  /// Name Field
                  TextFormField(
                    controller: nameCtrl,
                    decoration: InputDecoration(
                      labelText: "ingredient_name".tr(),
                      prefixIcon: const Icon(Icons.edit),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Quantity Field
                  TextFormField(
                    controller: qtyCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "quantity".tr(),
                      prefixIcon: const Icon(Icons.numbers),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Unit Dropdown
                  DropdownButtonFormField<IngredientUnitEnum>(
                    value: selectedUnit,
                    decoration: InputDecoration(
                      labelText: "unit".tr(),
                      prefixIcon: const Icon(Icons.scale),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    items: IngredientUnitEnum.values
                        .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.name.tr()),
                    ))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) selectedUnit = val;
                    },
                  ),

                  const SizedBox(height: 30),

                  /// Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close, color: grayColor),
                        label: Text("cancel".tr(), style: TextStyle(color: grayColor)),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (nameCtrl.text.isNotEmpty && qtyCtrl.text.isNotEmpty) {
                            final ingredient = IngredientModel(
                              id: DateTime.now().millisecondsSinceEpoch,
                              name: nameCtrl.text.trim(),
                              unit: selectedUnit,
                              calories: "0",
                              proteins: "0g",
                              carbs: "0g",
                              dietitianId: 0,
                            );
                            final withQuantity = IngredientWithQuantityModel(
                              id: 0,
                              ingredientId: ingredient.id,
                              quantity: int.tryParse(qtyCtrl.text.trim()) ?? 1,
                              ingredient: ingredient,
                            );
                            setState(() => ingredients.add(withQuantity));
                            Navigator.pop(context);
                          }
                        },
                        icon: const Icon(Icons.check),
                        label: Text("add".tr()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }



  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp4', 'mov', 'avi', 'pdf', 'docx'],
      );

      if (result != null && result.files.isNotEmpty) {
        final file = File(result.files.first.path!);
        final extension = result.files.first.extension?.toLowerCase();

        if (extension != null) {
          setState(() {
            selectedFile = file;
            videoLinkController.clear();
          });

          if (['pdf', 'docx'].contains(extension)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("file_selected_successfully".tr(args: [extension.toUpperCase()]))),
            );
          } else if (['mp4', 'mov', 'avi'].contains(extension)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("video_file_selected".tr())),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("unsupported_file_type".tr())),
            );
          }
        }
      }
    } catch (e) {
      debugPrint("File picking failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("file_picker_failed".tr())),
      );
    }
  }


  void _onSave() {
    final name = nameController.text.trim();
    final description = descriptionController.text.trim();
    final link = videoLinkController.text.trim();

    if (name.isEmpty || description.isEmpty || selectedType == null || ingredients.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("fill_all_fields".tr())),
      );
      return;
    }

    final meal = MealModel(
      id: DateTime.now().millisecondsSinceEpoch,
      dietitianId: 0,
      name: name,
      description: description,
      type: selectedType!,
      link: selectedFile != null ? selectedFile!.path : link,
      ingredients: ingredients,
    );

    Navigator.pop(context, meal);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(32),
        constraints: const BoxConstraints(maxWidth: 800),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "add_new_meal".tr(),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 24),

              // Meal Name
              _buildTextField(
                context,
                controller: nameController,
                label: "meal_name".tr(),
                icon: Icons.fastfood,
              ),

              const SizedBox(height: 16),

              // Meal Type
              _buildDropdown<MealTypeEnum>(
                context,
                value: selectedType,
                label: "meal_type".tr(),
                icon: Icons.restaurant,
                items: MealTypeEnum.values,
                display: (e) => e.displayName,
                onChanged: (val) => setState(() => selectedType = val),
              ),

              const SizedBox(height: 16),

              // Description
              _buildTextField(
                context,
                controller: descriptionController,
                label: "description".tr(),
                icon: Icons.notes,
                maxLines: 3,
              ),

              const SizedBox(height: 24),

              // Video section
              Text("video_instruction".tr(), style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      context,
                      controller: videoLinkController,
                      label: "video_link".tr(),
                      enabled: selectedFile == null,
                      icon: Icons.link,
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: _pickFile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade100,
                      foregroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.upload_file),
                    label: Text("upload_file".tr()),
                  ),
                ],
              ),

              if (selectedFile != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "file_selected".tr() + ": ${selectedFile!.path.split('/').last}",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.green.shade800),
                  ),
                ),

              const SizedBox(height: 24),

              // Ingredients section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("ingredients".tr(), style: Theme.of(context).textTheme.titleMedium),
                  TextButton.icon(
                    onPressed: _addIngredientDialog,
                    icon: const Icon(Icons.add),
                    label: Text("add_ingredient".tr()),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              ...ingredients.map((e) => Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  leading: const Icon(Icons.kitchen),
                  title: Text(e.ingredient.name),
                  subtitle: Text("${e.quantity} ${e.ingredient.unit.name.tr()}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => setState(() => ingredients.remove(e)),
                  ),
                ),
              )),

              const SizedBox(height: 32),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text("cancel".tr()),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _onSave,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    ),
                    child: Text("save".tr(), style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      BuildContext context, {
        required TextEditingController controller,
        required String label,
        IconData? icon,
        bool enabled = true,
        int maxLines = 1,
      }) {
    return TextField(
      controller: controller,
      enabled: enabled,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey.shade100,
      ),
    );
  }
  Widget _buildDropdown<T>(
      BuildContext context, {
        required T? value,
        required List<T> items,
        required String label,
        required IconData icon,
        required String Function(T) display,
        required ValueChanged<T?> onChanged,
      }) {
    return DropdownButtonFormField<T>(
      value: value,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey.shade100,
      ),
      items: items
          .map((e) => DropdownMenuItem<T>(
        value: e,
        child: Text(display(e)),
      ))
          .toList(),
    );
  }


}
