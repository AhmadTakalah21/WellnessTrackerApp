import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/users/cubit/users_cubit.dart';
import 'package:wellnesstrackerapp/features/users/model/user_model/user_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../global/blocs/user_roles_cubit/cubit/user_roles_cubit.dart';

class AddUserWidget extends StatefulWidget {
  final bool isEdit;
  final UserModel? user;
  final int selectedPage;

  const AddUserWidget({
    super.key,
    required this.isEdit,
    this.user,
    required this.selectedPage,
  });

  @override
  State<AddUserWidget> createState() => _AddUserWidgetState();
}

class _AddUserWidgetState extends State<AddUserWidget> {
  UsersCubit get cubit => context.read<UsersCubit>();
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  String? selectedRole;
  bool? isActive;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.user != null) {
      nameController.text = widget.user!.name;
      emailController.text = widget.user!.email;
      phoneController.text = widget.user!.phone;
      selectedRole = widget.user!.role;
      isActive = widget.user!.isActive;
    }

    context.read<UserRolesCubit>().getRoles();
  }

  void _saveUser() async {
    if (_formKey.currentState?.validate() ?? false) {
      cubit.setName(nameController.text);
      cubit.setEmail(emailController.text);
      cubit.setPassword(passwordController.text);
      cubit.setPhone(phoneController.text);
      cubit.setRole(selectedRole ?? '');
      cubit.setIsActive(isActive ?? true);

      await cubit.addUser(
        isAdd: !widget.isEdit,
        userId: widget.isEdit ? widget.user?.id : null,
      );

      if (mounted) {
        Navigator.pop(context);
        cubit.getUsers(page: widget.selectedPage);
      }
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    String? hint,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      style: context.tt.bodyMedium,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: context.cs.primary),
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[500]),
        hintText: widget.isEdit ? null : hint,
        hintStyle: TextStyle(color: Colors.grey[500]),
        floatingLabelBehavior: widget.isEdit
            ? FloatingLabelBehavior.auto
            : FloatingLabelBehavior.never,
        filled: true,
        fillColor: context.cs.surfaceVariant,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: context.cs.primary, width: 2),
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildRoleDropdown(List<String> roles) {
    return DropdownButtonFormField<String>(
      value: selectedRole,
      hint: Text(
        'select_role'.tr(),
        style: context.tt.bodyMedium?.copyWith(color: Colors.grey[500]),
      ),
      icon: Icon(LucideIcons.chevronDown, color: context.cs.primary),
      decoration: InputDecoration(
        prefixIcon: Icon(LucideIcons.badgeCheck, color: context.cs.primary),
        labelText: 'role'.tr(),
        filled: true,
        fillColor: context.cs.surfaceVariant,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: context.cs.primary, width: 2),
        ),
      ),
      style: context.tt.bodyMedium,
      items: roles.map((role) {
        return DropdownMenuItem(
          value: role,
          child: Text(role.tr(), style: context.tt.bodyMedium),
        );
      }).toList(),
      onChanged: (value) => setState(() => selectedRole = value),
      validator: (value) => value == null ? 'required'.tr() : null,
    );
  }

  Widget _buildStatusDropdown() {
    return DropdownButtonFormField<bool>(
      value: widget.isEdit ? isActive : null,
      hint: Text(
        'select_status'.tr(),
        style: context.tt.bodyMedium?.copyWith(color: Colors.grey[500]),
      ),
      icon: Icon(LucideIcons.circleDot, color: context.cs.primary),
      decoration: InputDecoration(
        prefixIcon: Icon(LucideIcons.shieldCheck, color: context.cs.primary),
        labelText: 'status'.tr(),
        filled: true,
        fillColor: context.cs.surfaceVariant,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: context.cs.primary, width: 2),
        ),
      ),
      items: [
        DropdownMenuItem(value: true, child: Text('active'.tr())),
        DropdownMenuItem(value: false, child: Text('inactive'.tr())),
      ],
      onChanged: (value) => setState(() => isActive = value),
      validator: (value) => value == null ? 'status_required'.tr() : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final spacing = const SizedBox(height: 16);

    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      backgroundColor: context.cs.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: BlocListener<UsersCubit, GeneralUsersState>(
        listener: (context, state) {
          if (state is AddUserFail) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is AddUserSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      widget.isEdit ? 'edit_user'.tr() : 'add_user'.tr(),
                      style: context.tt.headlineSmall,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildTextField(
                    controller: nameController,
                    label: 'name'.tr(),
                    icon: LucideIcons.user,
                    hint: 'John Doe',
                    validator: (val) =>
                        val == null || val.isEmpty ? 'required'.tr() : null,
                  ),
                  spacing,
                  _buildTextField(
                    controller: emailController,
                    label: 'email'.tr(),
                    icon: LucideIcons.mail,
                    hint: 'example@mail.com',
                    validator: (val) => val == null || !val.contains('@')
                        ? 'invalid_email'.tr()
                        : null,
                  ),
                  spacing,
                  if (!widget.isEdit) ...[
                    _buildTextField(
                      controller: passwordController,
                      label: 'password'.tr(),
                      icon: LucideIcons.lock,
                      isPassword: true,
                      validator: (val) => val == null || val.length < 6
                          ? 'too_short'.tr()
                          : null,
                    ),
                    spacing,
                  ],
                  _buildTextField(
                    controller: phoneController,
                    label: 'phone'.tr(),
                    icon: LucideIcons.phone,
                  ),
                  spacing,
                  BlocBuilder<UserRolesCubit, UserRolesState>(
                    builder: (context, state) {
                      if (state is UserRolesLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: context.cs.primary,
                          ),
                        );
                      } else if (state is UserRolesSuccess) {
                        final roles =
                            state.userRoles.map((e) => e.name).toList();
                        return _buildRoleDropdown(roles);
                      } else if (state is UserRolesEmpty) {
                        return Text(
                          'no_roles'.tr(),
                          style: TextStyle(color: Colors.red),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                  spacing,
                  _buildStatusDropdown(),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                            foregroundColor: context.cs.secondary),
                        child: Text('cancel'.tr()),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: _saveUser,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.cs.primary,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text(
                          widget.isEdit ? 'save'.tr() : 'add'.tr(),
                          style: context.tt.labelLarge
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:wellnesstrackerapp/features/users/cubit/users_cubit.dart';
// import 'package:wellnesstrackerapp/features/users/model/user_model/user_model.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
// import 'package:lucide_icons/lucide_icons.dart';
// import '../../../../global/blocs/user_roles_cubit/cubit/user_roles_cubit.dart';
//
// class AddUserWidget extends StatefulWidget {
//   final bool isEdit;
//   final UserModel? user;
//   final int selectedPage;
//
//   const AddUserWidget({
//     super.key,
//     required this.isEdit,
//     this.user,
//     required this.selectedPage,
//   });
//
//   @override
//   State<AddUserWidget> createState() => _AddUserWidgetState();
// }
//
// class _AddUserWidgetState extends State<AddUserWidget> {
//   UsersCubit get cubit => context.read<UsersCubit>();
//   final _formKey = GlobalKey<FormState>();
//
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final phoneController = TextEditingController();
//
//   String? selectedRole;
//   bool? isActive;
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.isEdit && widget.user != null) {
//       nameController.text = widget.user!.name;
//       emailController.text = widget.user!.email;
//       phoneController.text = widget.user!.phone;
//       selectedRole = widget.user!.role;
//       isActive = widget.user!.isActive;
//     }
//
//     context.read<UserRolesCubit>().getRoles();
//   }
//
//   void _saveUser() async {
//     if (_formKey.currentState?.validate() ?? false) {
//       cubit.setName(nameController.text);
//       cubit.setEmail(emailController.text);
//       cubit.setPassword(passwordController.text);
//       cubit.setPhone(phoneController.text);
//       cubit.setRole(selectedRole ?? '');
//       cubit.setIsActive(isActive ?? true);
//
//       await cubit.addUser(
//         isAdd: !widget.isEdit,
//         userId: widget.isEdit ? widget.user?.id : null,
//       );
//
//       if (mounted) {
//         Navigator.pop(context);
//         cubit.getUsers(page: widget.selectedPage);
//       }
//     }
//   }
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     bool isPassword = false,
//     String? hint,
//     String? Function(String?)? validator,
//   }) {
//     return TextFormField(
//       controller: controller,
//       obscureText: isPassword,
//       style: context.tt.bodyMedium,
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon, color: context.cs.primary),
//         labelText: label,
//         labelStyle: TextStyle(color: Colors.grey[500]),
//         hintText: widget.isEdit ? null : hint,
//         hintStyle: TextStyle(color: Colors.grey[500]),
//         floatingLabelBehavior: widget.isEdit
//             ? FloatingLabelBehavior.auto
//             : FloatingLabelBehavior.never,
//         filled: true,
//         fillColor: context.cs.surfaceVariant,
//         contentPadding:
//         const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: context.cs.primary, width: 2),
//         ),
//       ),
//       validator: validator,
//     );
//   }
//
//   Widget _buildRoleDropdown(List<String> roles) {
//     return DropdownButtonFormField<String>(
//       value: selectedRole,
//       icon: Icon(LucideIcons.chevronDown, color: context.cs.primary),
//       decoration: InputDecoration(
//         prefixIcon: Icon(LucideIcons.badgeCheck, color: context.cs.primary),
//         labelText: 'role'.tr(),
//         filled: true,
//         fillColor: context.cs.surfaceVariant,
//         contentPadding:
//         const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: context.cs.primary, width: 2),
//         ),
//       ),
//       style: context.tt.bodyMedium,
//       items: roles.map((role) {
//         return DropdownMenuItem(
//           value: role,
//           child: Text(role.tr(), style: context.tt.bodyMedium),
//         );
//       }).toList(),
//       onChanged: (value) => setState(() => selectedRole = value),
//       validator: (value) => value == null ? 'required'.tr() : null,
//     );
//   }
//
//   Widget _buildStatusDropdown() {
//     return DropdownButtonFormField<bool>(
//       value: widget.isEdit ? isActive : null,
//       hint: Text(
//         'select_status'.tr(),
//         style: context.tt.bodyMedium?.copyWith(color: Colors.grey[500]),
//       ),
//       icon: Icon(LucideIcons.circleDot, color: context.cs.primary),
//       decoration: InputDecoration(
//         prefixIcon: Icon(LucideIcons.shieldCheck, color: context.cs.primary),
//         labelText: 'status'.tr(),
//         filled: true,
//         fillColor: context.cs.surfaceVariant,
//         contentPadding:
//         const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: context.cs.primary, width: 2),
//         ),
//       ),
//       items: [
//         DropdownMenuItem(value: true, child: Text('active'.tr())),
//         DropdownMenuItem(value: false, child: Text('inactive'.tr())),
//       ],
//       onChanged: (value) => setState(() => isActive = value),
//       validator: (value) => value == null ? 'status_required'.tr() : null,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final spacing = const SizedBox(height: 16);
//
//     return Dialog(
//       insetPadding: const EdgeInsets.all(24),
//       backgroundColor: context.cs.background,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
//       child: BlocListener<UsersCubit, GeneralUsersState>(
//         listener: (context, state) {
//           if (state is AddUserFail) {
//             ScaffoldMessenger.of(context)
//                 .showSnackBar(SnackBar(content: Text(state.error)));
//           } else if (state is AddUserSuccess) {
//             ScaffoldMessenger.of(context)
//                 .showSnackBar(SnackBar(content: Text(state.message)));
//           }
//         },
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
//           child: Form(
//             key: _formKey,
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Center(
//                     child: Text(
//                       widget.isEdit ? 'edit_user'.tr() : 'add_user'.tr(),
//                       style: context.tt.headlineSmall,
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                   _buildTextField(
//                     controller: nameController,
//                     label: 'name'.tr(),
//                     icon: LucideIcons.user,
//                     hint: 'John Doe',
//                     validator: (val) =>
//                     val == null || val.isEmpty ? 'required'.tr() : null,
//                   ),
//                   spacing,
//                   _buildTextField(
//                     controller: emailController,
//                     label: 'email'.tr(),
//                     icon: LucideIcons.mail,
//                     hint: 'example@mail.com',
//                     validator: (val) => val == null || !val.contains('@')
//                         ? 'invalid_email'.tr()
//                         : null,
//                   ),
//                   spacing,
//                   if (!widget.isEdit) ...[
//                     _buildTextField(
//                       controller: passwordController,
//                       label: 'password'.tr(),
//                       icon: LucideIcons.lock,
//                       isPassword: true,
//                       validator: (val) => val == null || val.length < 6
//                           ? 'too_short'.tr()
//                           : null,
//                     ),
//                     spacing,
//                   ],
//                   _buildTextField(
//                     controller: phoneController,
//                     label: 'phone'.tr(),
//                     icon: LucideIcons.phone,
//                   ),
//                   spacing,
//                   BlocBuilder<UserRolesCubit, UserRolesState>(
//                     builder: (context, state) {
//                       if (state is UserRolesLoading) {
//                         return Center(
//                           child: CircularProgressIndicator(
//                             color: context.cs.primary,
//                           ),
//                         );
//                       } else if (state is UserRolesSuccess) {
//                         final roles = state.userRoles.map((e) => e.name).toList();
//                         return _buildRoleDropdown(roles);
//                       } else if (state is UserRolesEmpty) {
//                         return Text(
//                           'no_roles'.tr(),
//                           style: TextStyle(color: Colors.red),
//                         );
//                       } else {
//                         return SizedBox.shrink();
//                       }
//                     },
//                   ),
//                   spacing,
//                   _buildStatusDropdown(),
//                   const SizedBox(height: 28),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         onPressed: () => Navigator.pop(context),
//                         style: TextButton.styleFrom(
//                             foregroundColor: context.cs.secondary),
//                         child: Text('cancel'.tr()),
//                       ),
//                       const SizedBox(width: 12),
//                       ElevatedButton(
//                         onPressed: _saveUser,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: context.cs.primary,
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 24, vertical: 14),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12)),
//                         ),
//                         child: Text(
//                           widget.isEdit ? 'save'.tr() : 'add'.tr(),
//                           style: context.tt.labelLarge
//                               ?.copyWith(color: Colors.white),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
