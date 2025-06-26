// import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:wellnesstrackerapp/features/codes/cubit/codes_cubit.dart';
// import 'package:wellnesstrackerapp/features/codes/model/code_model/code_model.dart';
// import 'package:wellnesstrackerapp/features/codes/model/department_model/department_model.dart';
// import 'package:wellnesstrackerapp/global/utils/constants.dart';
// import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
// import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';
// import 'package:wellnesstrackerapp/global/widgets/main_text_field.dart';
//
// class AddCodeWidget extends StatefulWidget {
//   final bool isEdit;
//   final CodeModel? code;
//   final VoidCallback onSuccess;
//
//   const AddCodeWidget({
//     super.key,
//     required this.isEdit,
//     this.code,
//     required this.onSuccess,
//   });
//
//   @override
//   State<AddCodeWidget> createState() => _AddCodeWidgetState();
// }
//
// class _AddCodeWidgetState extends State<AddCodeWidget> {
//   late final CodesCubit codesCubit = context.read();
//
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController codeController = TextEditingController();
//   final TextEditingController startDateController = TextEditingController();
//   final TextEditingController endDateController = TextEditingController();
//
//   DepartmentModel? selectedDepartment;
//   String? selectedStatus;
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.isEdit && widget.code != null) {
//       codeController.text = widget.code!.code;
//       startDateController.text = widget.code!.startDate;
//       endDateController.text = widget.code!.endDate;
//       selectedStatus = widget.code!.status;
//       selectedDepartment = widget.code!.department;
//     }
//   }
//
//   void onSave() {
//     if (!_formKey.currentState!.validate()) return;
//
//     final codeModel = CodeModel(
//       id: widget.code?.id ?? 0,
//       code: codeController.text,
//       startDate: startDateController.text,
//       endDate: endDateController.text,
//       status: selectedStatus ?? 'active',
//       department: selectedDepartment!,
//     );
//
//     // Call the cubit method to add/update
//     codesCubit.submitCode(
//       code: codeModel,
//       isEdit: widget.isEdit,
//       onSuccess: widget.onSuccess,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: MediaQuery.of(context).viewInsets,
//       child: SingleChildScrollView(
//         padding: AppConstants.padding16,
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(widget.isEdit ? 'edit_code'.tr() : 'add_code'.tr(), style: Theme.of(context).textTheme.titleLarge),
//               const SizedBox(height: 16),
//               MainTextField(
//                 controller: codeController,
//                 labelText: 'code'.tr(),
//                 validator: (val) => val == null || val.isEmpty ? 'required_field'.tr() : null,
//               ),
//               const SizedBox(height: 12),
//               MainTextField(
//                 controller: startDateController,
//                 labelText: 'start'.tr(),
//                 validator: (val) => val == null || val.isEmpty ? 'required_field'.tr() : null,
//               ),
//               const SizedBox(height: 12),
//               MainTextField(
//                 controller: endDateController,
//                 labelText: 'end'.tr(),
//                 validator: (val) => val == null || val.isEmpty ? 'required_field'.tr() : null,
//               ),
//               const SizedBox(height: 12),
//               DropdownButtonFormField<String>(
//                 value: selectedStatus,
//                 decoration: InputDecoration(
//                   labelText: 'status'.tr(),
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                 ),
//                 items: ['active', 'inactive'].map((status) => DropdownMenuItem(value: status, child: Text(status.tr()))).toList(),
//                 onChanged: (val) => setState(() => selectedStatus = val),
//               ),
//               const SizedBox(height: 12),
//               MainDropDownWidget<DepartmentModel>(
//                 items: codesCubit.departments,
//                 selectedValue: selectedDepartment,
//                 text: 'department'.tr(),
//                 onChanged: (value) => setState(() => selectedDepartment = value),
//               ),
//               const SizedBox(height: 20),
//               MainActionButton(
//                 text: widget.isEdit ? 'update'.tr() : 'save'.tr(),
//                 onPressed: onSave,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
