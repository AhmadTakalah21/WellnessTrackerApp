import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/customers/cubit/customers_cubit.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_evaluation_model/customer_evaluation_model.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';

@RoutePage()
class SubscriberEvaluationView extends StatelessWidget {
  const SubscriberEvaluationView({
    super.key,
    required this.role,
    required this.customer,
  });

  final UserRoleEnum role;
  final CustomerModel customer;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => get<CustomersCubit>(),
      child: _SubscriberEvaluationPage(role: role, customer: customer),
    );
  }
}

class _SubscriberEvaluationPage extends StatefulWidget {
  const _SubscriberEvaluationPage({
    required this.role,
    required this.customer,
  });

  final UserRoleEnum role;
  final CustomerModel customer;

  @override
  State<_SubscriberEvaluationPage> createState() =>
      _SubscriberEvaluationPageState();
}

class _SubscriberEvaluationPageState extends State<_SubscriberEvaluationPage> {
  late final CustomersCubit customersCubit = context.read();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    customersCubit.getSubscriberEvaluation(widget.role, widget.customer.id);
  }

  Future<void> _onRefresh() => _load();

  @override
  Widget build(BuildContext context) {
    final ui = _UiScale.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "subscriber_evaluation".tr(),
          style: TextStyle(fontSize: ui.appBarTitle),
        ),
      ),
      body: BlocBuilder<CustomersCubit, GeneralCustomersState>(
        buildWhen: (prev, curr) => curr is SubscriberEvaluationState,
        builder: (context, state) {
          if (state is SubscriberEvaluationLoading) {
            return const LoadingIndicator();
          }

          if (state is SubscriberEvaluationFail) {
            return MainErrorWidget(
              error: state.error,
              onTryAgainTap: _load,
            );
          }

          if (state is SubscriberEvaluationSuccess) {
            final evaluations = state.evaluations;

            if (evaluations.isEmpty) {
              return MainErrorWidget(
                isRefresh: true,
                error: "no_evaluations".tr(),
                onTryAgainTap: _load,
              );
            }

            final base = evaluations.first;

            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: AppConstants.padding20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SubscriberInfoCard(base: base),
                    SizedBox(height: ui.sectionGap),
                    Text(
                      "evaluations".tr(),
                      style: context.tt.titleLarge?.copyWith(
                        fontSize: ui.sectionTitle,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: ui.sectionGapSmall),
                    ...evaluations.map((e) => _EvaluationCard(evaluation: e)),
                    SizedBox(height: ui.bottomSpace),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

/// -------------------- Subscriber Info Card --------------------

class _SubscriberInfoCard extends StatelessWidget {
  const _SubscriberInfoCard({required this.base});

  final CustomerEvaluationModel base;

  @override
  Widget build(BuildContext context) {
    final ui = _UiScale.of(context);

    final rows = <MapEntry<String, String>>[
      MapEntry("name", base.name),
      MapEntry("age", base.age.toString()),
      MapEntry("length", base.length.toString()),
      MapEntry(
        "weight_before_subscription",
        base.weightBeforeSubscription.toString(),
      ),
      MapEntry("currnet_weight", base.currentWeight.toString()),
    ];

    return Container(
      decoration: BoxDecoration(
        color: context.cs.surface,
        borderRadius: AppConstants.borderRadius10,
        border: Border.all(color: context.cs.primary.withValues(alpha: 0.18)),
        boxShadow: [
          BoxShadow(
            color: context.cs.onTertiary.withValues(alpha: 0.12),
            offset: const Offset(0, 6),
            blurRadius: 14,
          ),
        ],
      ),
      padding: AppConstants.padding16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, color: context.cs.primary, size: ui.icon),
              SizedBox(width: ui.iconGap),
              Text(
                "subscriber_info".tr(),
                style: context.tt.titleLarge?.copyWith(
                  fontSize: ui.cardTitle,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          SizedBox(height: ui.cardInnerGap),
          ...rows.map((e) => _InfoLine(titleKey: e.key, value: e.value)),
        ],
      ),
    );
  }
}

/// -------------------- Evaluation Card --------------------

class _EvaluationCard extends StatelessWidget {
  const _EvaluationCard({required this.evaluation});

  final CustomerEvaluationModel evaluation;

  @override
  Widget build(BuildContext context) {
    final ui = _UiScale.of(context);
    final meta = _EvaluatorMeta.fromEvaluation(evaluation);

    // ✅ اخفاء plans_count للطبيب والنفسي
    final showPlansCount =
    !(meta.type == _EvaluatorType.doctor ||
        meta.type == _EvaluatorType.psychologist);

    return Container(
      margin: EdgeInsets.only(bottom: ui.cardGap),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppConstants.borderRadius10,
        border: Border.all(color: context.cs.primary.withValues(alpha: 0.12)),
        boxShadow: [
          BoxShadow(
            color: context.cs.onTertiary.withValues(alpha: 0.10),
            offset: const Offset(0, 6),
            blurRadius: 14,
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: AppConstants.padding16,
          childrenPadding: AppConstants.padding16,
          leading: CircleAvatar(
            radius: ui.avatarRadius,
            backgroundColor: meta.color.withValues(alpha: 0.12),
            child: Icon(meta.icon, color: meta.color, size: ui.avatarIcon),
          ),
          title: Text(
            meta.titleKey.tr(),
            style: context.tt.titleMedium?.copyWith(
              fontSize: ui.expansionTitle,
              fontWeight: FontWeight.w800,
            ),
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: ui.subtitleTopPadding),
            child: Text(
              meta.roleKey.tr(),
              style: context.tt.bodySmall?.copyWith(
                fontSize: ui.expansionSubtitle,
                fontWeight: FontWeight.w600,
                color: context.cs.onSurface.withValues(alpha: 0.70),
              ),
            ),
          ),
          children: [
            _InfoLine(
              titleKey: "health_evaluate",
              value: _safe(evaluation.healthEvaluation),
            ),
            _InfoLine(
              titleKey: "psychology_evaluate",
              value: _safe(evaluation.psycologyEvaluation),
            ),
            _InfoLine(
              titleKey: "behavior_evaluate",
              value: _safe(evaluation.behaviorEvaluation),
            ),
            if (showPlansCount)
              _InfoLine(
                titleKey: "plans_count",
                value: evaluation.receivedPlansCount.toString(),
              ),
          ],
        ),
      ),
    );
  }

  static String _safe(String? v) {
    final s = (v ?? "").trim();
    return s.isEmpty ? "-" : s;
  }
}

/// -------------------- Shared Line Widget --------------------

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.titleKey, required this.value});

  final String titleKey;
  final String value;

  @override
  Widget build(BuildContext context) {
    final ui = _UiScale.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: ui.lineVPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              titleKey.tr(),
              style: context.tt.bodyMedium?.copyWith(
                fontSize: ui.lineTitle,
                fontWeight: FontWeight.w700,
                color: context.cs.onSurface.withValues(alpha: 0.82),
              ),
            ),
          ),
          SizedBox(width: ui.lineGap),
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: context.tt.bodyMedium?.copyWith(
                fontSize: ui.lineValue,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

/// -------------------- Meta --------------------

enum _EvaluatorType { doctor, psychologist, dietitian, coach, unknown }

class _EvaluatorMeta {
  const _EvaluatorMeta({
    required this.type,
    required this.titleKey,
    required this.roleKey,
    required this.icon,
    required this.color,
  });

  final _EvaluatorType type;
  final String titleKey;
  final String roleKey;
  final IconData icon;
  final Color color;

  factory _EvaluatorMeta.fromEvaluation(CustomerEvaluationModel e) {
    if (e.doctorId != null) {
      return const _EvaluatorMeta(
        type: _EvaluatorType.doctor,
        titleKey: "doctor_evaluation",
        roleKey: "role_doctor",
        icon: Icons.medical_services_outlined,
        color: Colors.blue,
      );
    }
    if (e.psychologistId != null) {
      return const _EvaluatorMeta(
        type: _EvaluatorType.psychologist,
        titleKey: "psychologist_evaluation",
        roleKey: "role_psychologist",
        icon: Icons.psychology_outlined,
        color: Colors.deepPurple,
      );
    }
    if (e.dietitianId != null) {
      return const _EvaluatorMeta(
        type: _EvaluatorType.dietitian,
        titleKey: "dietitian_evaluation",
        roleKey: "role_dietitian",
        icon: Icons.restaurant_menu_outlined,
        color: Colors.green,
      );
    }
    if (e.coachId != null) {
      return const _EvaluatorMeta(
        type: _EvaluatorType.coach,
        titleKey: "coach_evaluation",
        roleKey: "role_coach",
        icon: Icons.fitness_center_outlined,
        color: Colors.orange,
      );
    }

    return const _EvaluatorMeta(
      type: _EvaluatorType.unknown,
      titleKey: "evaluation",
      roleKey: "role_unknown",
      icon: Icons.info_outline,
      color: Colors.grey,
    );
  }
}

/// -------------------- Responsive Scale (Clean + One Place) --------------------

class _UiScale {
  _UiScale._(this._s);

  final double _s;

  /// ✅ responsive + يحترم تكبير الخط من إعدادات الهاتف
  factory _UiScale.of(BuildContext context) {
    final scaler = MediaQuery.textScalerOf(context);
    final factor = scaler.scale(1.0);

    // clamp حتى ما يصير كبير جداً أو صغير جداً
    final s = factor.clamp(1.0, 1.25);
    return _UiScale._(s);
  }

  // AppBar
  double get appBarTitle => 18 * _s;

  // Section
  double get sectionTitle => 20 * _s;
  double get sectionGap => 14 * _s;
  double get sectionGapSmall => 10 * _s;
  double get bottomSpace => 30 * _s;

  double get icon => 22 * _s;
  double get iconGap => 10 * _s;
  double get cardInnerGap => 12 * _s;

  // Cards
  double get cardTitle => 20 * _s;
  double get cardGap => 12 * _s;

  // Expansion
  double get avatarRadius => 22 * _s;
  double get avatarIcon => 22 * _s;
  double get expansionTitle => 18 * _s;
  double get expansionSubtitle => 15 * _s;
  double get subtitleTopPadding => 2 * _s;

  // Lines
  double get lineTitle => 16 * _s;
  double get lineValue => 16 * _s;
  double get lineVPadding => 8 * _s;
  double get lineGap => 12 * _s;
}
