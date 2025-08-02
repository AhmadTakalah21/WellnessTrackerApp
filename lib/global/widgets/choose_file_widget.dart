import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:wellnesstrackerapp/global/blocs/upload_file_cubit/cubit/upload_file_cubit.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';

class ChooseFileWidget extends StatelessWidget {
  const ChooseFileWidget({
    super.key,
    this.readOnly = false,
    required this.onSetFile,
    this.initialFile,
    this.validator,
  });

  final bool readOnly;
  final void Function(String? filePath) onSetFile;
  final String? initialFile;
  final String? Function(String?)? validator;

  Future<void> upload(BuildContext context) async {
    context.read<UploadFileCubit>().uploadFile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<UploadFileCubit>(),
      child: BlocConsumer<UploadFileCubit, UploadFileState>(
        listener: (context, state) {
          if (state is UploadFileSuccess) {
            onSetFile(state.filePath);
          } else if (state is UploadFileFail) {
            MainSnackBar.showErrorMessage(context, state.message);
            onSetFile(null);
          }
        },
        builder: (context, state) {
          String? filePath;
          String? message;
          if (state is UploadFileSuccess) {
            filePath = state.filePath;
            message = basename(filePath);
          } else if (state is UploadFileFail) {
            message = state.message;
          }
          final hintText =
              filePath == null ? 'choose_file'.tr() : 'chosen_file'.tr();

          return FormField(
            validator: validator,
            builder: (field) {
              final hasError = field.hasError;
              final color = hasError ? context.cs.error : context.cs.primary;
              final width = hasError ? 1.0 : 2.0;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: readOnly
                        ? null
                        : () => context.read<UploadFileCubit>().uploadFile(),
                    child: Container(
                      padding: AppConstants.padding12,
                      decoration: BoxDecoration(
                        border: Border.all(width: width, color: color),
                        borderRadius: AppConstants.borderRadius10,
                      ),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.file_copy, color: color),
                                  const SizedBox(width: 8),
                                  Text(
                                    hintText,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                          if (message != null) Expanded(child: Text(message)),
                        ],
                      ),
                    ),
                  ),
                  if (hasError)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Text(
                        field.errorText ?? '',
                        style: TextStyle(color: context.cs.error, fontSize: 12),
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
