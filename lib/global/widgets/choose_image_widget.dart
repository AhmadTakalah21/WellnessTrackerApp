import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wellnesstrackerapp/global/blocs/upload_image_cubit/cubit/upload_image_cubit.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/app_image_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';

class ChooseImageWidget extends StatelessWidget {
  const ChooseImageWidget({
    super.key,
    this.readOnly = false,
    this.label = "image",
    this.validator,
    this.initialImage,
    required this.onSetImage,
  });
  final String? initialImage;
  final bool readOnly;
  final void Function(XFile? image) onSetImage;
  final String label;
  final String? Function(String?)? validator;

  Future<void> upload(BuildContext context) async {
    context.read<UploadImageCubit>().uploadImage;
  }

  @override
  Widget build(BuildContext context) {
    final initialImage = this.initialImage;
    return BlocProvider(
      create: (context) => get<UploadImageCubit>(),
      child: BlocConsumer<UploadImageCubit, UploadImageState>(
        listener: (context, state) {
          if (state is UploadImageSuccess) {
            onSetImage(state.image);
          } else if (state is UploadImageFail) {
            MainSnackBar.showErrorMessage(context, state.message);
            onSetImage(null);
          }
        },
        builder: (context, state) {
          String? imagePath;
          String? message;
          if (state is UploadImageSuccess) {
            imagePath = state.image.path;
            message = basename(imagePath);
          } else if (state is UploadImageFail) {
            message = state.message;
          }
          final hasImage = imagePath != null && File(imagePath).existsSync();
          final hintText =
              imagePath == null ? 'choose_image'.tr() : 'chosen_image'.tr();
          return FormField(
            validator: validator,
            builder: (field) {
              final hasError = field.hasError;
              final color = hasError ? context.cs.error : context.cs.primary;
              final width = hasError ? 1.0 : 2.0;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label.tr(), style: context.tt.titleLarge),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: readOnly
                        ? null
                        : () => context.read<UploadImageCubit>().uploadImage(),
                    child: Container(
                      padding: AppConstants.padding12,
                      decoration: BoxDecoration(
                        border: Border.all(width: width, color: color),
                        borderRadius: AppConstants.borderRadius10,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.image, color: context.cs.primary),
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
                              if (message != null)
                                Expanded(child: Text(message)),
                            ],
                          ),
                          if (hasImage) ...[
                            const SizedBox(height: 10),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(imagePath!),
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ],
                          if (initialImage != null && !hasImage) ...[
                            const SizedBox(height: 10),
                            AppImageWidget(
                              url: initialImage,
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                              errorWidget: const SizedBox.shrink(),
                              onImageLoaded: (p0) async {
                                final networkImage =
                                    p0 as CachedNetworkImageProvider;
                                final response = await NetworkAssetBundle(
                                  Uri.parse(networkImage.url),
                                ).load("");
                                final bytes = response.buffer.asUint8List();

                                final tempDir = await getTemporaryDirectory();
                                final filePath =
                                    '${tempDir.path}/downloaded_image.jpg';
                                final file = File(filePath);
                                await file.writeAsBytes(bytes);
                                final xfile = XFile(file.path);

                                onSetImage(xfile);
                              },
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  if (hasError)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 4.0),
                      child: Text(
                        field.errorText ?? '',
                        style: TextStyle(color: Colors.red, fontSize: 12),
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
