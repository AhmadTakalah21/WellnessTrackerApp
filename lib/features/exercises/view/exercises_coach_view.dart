import 'dart:typed_data';

import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:wellnesstrackerapp/features/exercises/cubit/exercises_cubit.dart';
import 'package:wellnesstrackerapp/features/exercises/model/exercise_model/exercise_model.dart';
import 'package:wellnesstrackerapp/features/exercises/view/add_exercise_view.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/additional_options_bottom_sheet.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_add_floating_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/video_player_widget.dart';

abstract class ExercisesCoachViewCallbacks {
  void onAddTap();
  void onTap(ExerciseModel exercise);
  void onEditTap(ExerciseModel exercise);
  void onDeleteTap(ExerciseModel exercise);
  void onTryAgainTap();
  Future<void> onRefresh();
}

@RoutePage()
class ExercisesCoachView extends StatelessWidget {
  const ExercisesCoachView({super.key, required this.role});
  final UserRoleEnum role;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<ExercisesCubit>(),
      child: ExercisesCoachPage(role: role),
    );
  }
}

class ExercisesCoachPage extends StatefulWidget {
  const ExercisesCoachPage({super.key, required this.role});
  final UserRoleEnum role;

  @override
  State<ExercisesCoachPage> createState() => _ExercisesCoachPageState();
}

class _ExercisesCoachPageState extends State<ExercisesCoachPage>
    with TickerProviderStateMixin
    implements ExercisesCoachViewCallbacks {
  late final ExercisesCubit exercisesCubit = context.read();

  @override
  void initState() {
    super.initState();
    exercisesCubit.getExercises();
  }

  String get _baseUrl => 'https://dev-mi.serv00.net'; // عدّلها بحسب بيئتك

  bool _isWebUrl(String s) =>
      s.startsWith('http://') || s.startsWith('https://');

  bool _isVideo(String s) {
    final l = s.toLowerCase();
    return l.endsWith('.mp4') ||
        l.endsWith('.mov') ||
        l.endsWith('.mkv') ||
        l.endsWith('.webm');
  }

  String _absoluteLink(String link) {
    if (link.isEmpty) return '';
    return _isWebUrl(link) ? link : '$_baseUrl/storage/$link';
  }

  IconData _iconForLink(String raw) {
    final url = _absoluteLink(raw);
    if (url.isEmpty) return Icons.link_off;
    if (_isVideo(url)) return Icons.play_circle_fill;
    return Icons.link;
  }

  Future<void> _openExternal(String url) async {
    final ok =
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('cannot_open_link'.tr())),
      );
    }
  }

  void _onOpenMedia(String raw) {
    final url = _absoluteLink(raw);
    if (url.isEmpty) return;

    if (_isVideo(url)) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => VideoPlayerView(url: url)),
      );
    } else {
      _openExternal(url);
    }
  }

  @override
  void onAddTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddExerciseView(exercisesCubit: exercisesCubit),
      ),
    );
  }

  @override
  void onTap(ExerciseModel exercise) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: AppConstants.borderRadiusT20),
      builder: (context) => AdditionalOptionsBottomSheet(
        item: exercise,
        onEditTap: onEditTap,
        onDeleteTap: onDeleteTap,
      ),
    );
  }

  @override
  void onDeleteTap(ExerciseModel exercise) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (_) => InsureDeleteWidget(
        item: exercise,
        onSuccess: () {
          Navigator.pop(context);
          exercisesCubit.getExercises();
        },
      ),
    );
  }

  @override
  void onEditTap(ExerciseModel exercise) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddExerciseView(
          exercisesCubit: exercisesCubit,
          exercise: exercise,
        ),
      ),
    );
  }

  @override
  Future<void> onRefresh() async => onTryAgainTap();

  @override
  void onTryAgainTap() => exercisesCubit.getExercises();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('exercises'.tr())),
      body: BlocBuilder<ExercisesCubit, GeneralExercisesState>(
        buildWhen: (previous, current) => current is ExercisesState,
        builder: (context, state) {
          if (state is ExercisesLoading) {
            return const Center(child: LoadingIndicator());
          } else if (state is ExercisesSuccess) {
            final exercises = state.exercises.data;
            return RefreshIndicator(
              onRefresh: onRefresh,
              child: SingleChildScrollView(
                padding: AppConstants.padding20,
                physics: BouncingScrollPhysics(),
                child: Column(
                  spacing: 20,
                  children: [
                    ...exercises.map((e) => _buildExerciseTile(e)),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            );
          } else if (state is ExercisesEmpty) {
            return MainErrorWidget(
              error: state.message,
              isRefresh: true,
              onTryAgainTap: onTryAgainTap,
            );
          } else if (state is ExercisesFail) {
            return MainErrorWidget(
              error: state.error,
              onTryAgainTap: onTryAgainTap,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: MainFloatingButton(onTap: onAddTap),
    );
  }

  Widget _buildExerciseTile(ExerciseModel exercise) {
    // نفترض أن ExerciseModel يحتوي على حقل link مثل MealModel
    final String link = _absoluteLink(exercise.link);
    final desc = exercise.description;

    return InkWell(
      onTap: () => onTap(exercise),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // العنوان + زر الميديا الذكي
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      exercise.name,
                      style: context.tt.titleLarge?.copyWith(
                        color: context.cs.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (exercise.link.isNotEmpty)
                    IconButton(
                      tooltip: 'open_instruction'.tr(),
                      icon: Icon(_iconForLink(exercise.link),
                          size: 30, color: context.cs.primary),
                      onPressed: () => _onOpenMedia(exercise.link),
                    ),
                ],
              ),

              const SizedBox(height: 12),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Chip(
                    avatar: const Icon(Icons.repeat),
                    label: Text('${'rounds'.tr()}: ${desc.rounds}'),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              if (desc.repeats.isNotEmpty)
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (int i = 0; i < desc.repeats.length; i++)
                      Chip(
                        label: Text(
                          '${'round'.tr()} ${i + 1}: ${desc.repeats[i]} ${'reps'.tr()}',
                        ),
                      ),
                  ],
                ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Icon(Icons.info_outline, size: 18, color: context.cs.primary),
                  const SizedBox(width: 6),
                  Text('instruction'.tr(), style: context.tt.titleMedium),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                desc.explain,
                style: context.tt.bodyMedium,
              ),

              if (link.isNotEmpty && (_isVideo(link))) ...[
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () => _onOpenMedia(exercise.link),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: _buildVideoPreview(link),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<Uint8List?> _generateThumbnail(String url) async {
    try {
      return await VideoThumbnail.thumbnailData(
        video: url,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 500,
        quality: 75,
      );
    } catch (e) {
      debugPrint("Thumbnail error: $e");
      return null;
    }
  }

  Widget _buildVideoPreview(String videoUrl) {
    return FutureBuilder<Uint8List?>(
      future: _generateThumbnail(videoUrl),
      builder: (context, snapshot) {
        Widget child;

        if (snapshot.connectionState == ConnectionState.waiting) {
          child = ColoredBox(
            color: Colors.black.withOpacity(0.08),
            child: LoadingIndicator(color: context.cs.secondary),
          );
        } else if (snapshot.hasData && snapshot.data != null) {
          child = Image.memory(snapshot.data!, fit: BoxFit.cover);
        } else {
          child = ColoredBox(color: Colors.black.withOpacity(0.08));
        }

        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              child,
              if (child is Image)
                const Center(
                  child: Icon(
                    Icons.play_circle_fill,
                    size: 56,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
