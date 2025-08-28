import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/customers/cubit/customers_cubit.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_evaluation_model/customer_evaluation_model.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart';
import 'package:wellnesstrackerapp/features/customers/view/widgets/approve_customer_view.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';

abstract class SubscriberEvaluationViewCallBacks {
  void onTryAgainTap();
  Future<void> onRefresh();
}

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
      create: (context) => get<CustomersCubit>(),
      child: SubscriberEvaluationPage(role: role, customer: customer),
    );
  }
}

class SubscriberEvaluationPage extends StatefulWidget {
  const SubscriberEvaluationPage({
    super.key,
    required this.role,
    required this.customer,
  });
  final UserRoleEnum role;
  final CustomerModel customer;

  @override
  State<SubscriberEvaluationPage> createState() =>
      _SubscriberEvaluationPageState();
}

class _SubscriberEvaluationPageState extends State<SubscriberEvaluationPage>
    implements SubscriberEvaluationViewCallBacks {
  late final CustomersCubit customersCubit = context.read();

  @override
  void initState() {
    customersCubit.getSubscriberEvaluation(widget.role, widget.customer.id);
    super.initState();
  }

  @override
  Future<void> onRefresh() async => onTryAgainTap();

  @override
  void onTryAgainTap() =>
      customersCubit.getSubscriberEvaluation(widget.role, widget.customer.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("subscriber_evaluation".tr())),
      body: BlocBuilder<CustomersCubit, GeneralCustomersState>(
        buildWhen: (previous, current) => current is SubscriberEvaluationState,
        builder: (context, state) {
          if (state is SubscriberEvaluationLoading) {
            return LoadingIndicator();
          } else if (state is SubscriberEvaluationSuccess) {
            return RefreshIndicator(
              onRefresh: onRefresh,
              child: SingleChildScrollView(
                padding: AppConstants.padding20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [_buildEvaluationInfoTable(state.evaluation)],
                ),
              ),
            );
          } else if (state is SubscriberEvaluationFail) {
            return MainErrorWidget(
              error: state.error,
              onTryAgainTap: onTryAgainTap,
            );
            // return RefreshIndicator(
            //   onRefresh: onRefresh,
            //   child: SingleChildScrollView(
            //     padding: AppConstants.padding20,
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       spacing: 10,
            //       children: [
            //         _buildEvaluationInfoTable(
            //           CustomerEvaluationModel(
            //             name: "faris",
            //             age: 21,
            //             length: 170,
            //             weightBeforeSubscription: 70,
            //             healthEvaluation: "good",
            //             psycologyEvaluation: "good and stable",
            //             behaviorEvaluation: "active and always responsive",
            //             currentWeight: 50,
            //             receivedPlansCount: 5,
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildEvaluationInfoTable(CustomerEvaluationModel evaluation) {
    final data = [
      TitleValueModel("name", evaluation.name),
      TitleValueModel("age", evaluation.age.toString()),
      TitleValueModel("length", evaluation.length.toStringAsFixed(2)),
      TitleValueModel("weight_before_subscription",
          evaluation.weightBeforeSubscription.toStringAsFixed(2)),
      TitleValueModel("health_evaluate", evaluation.healthEvaluation),
      TitleValueModel("psychology_evaluate", evaluation.psycologyEvaluation),
      TitleValueModel("behavior_evaluate", evaluation.behaviorEvaluation),
      TitleValueModel(
          "currnet_weight", evaluation.currentWeight.toStringAsFixed(2)),
      TitleValueModel("plans_count", evaluation.receivedPlansCount.toString()),
    ];
    return Table(
      border: TableBorder.all(
        color: context.cs.primary,
        width: 2,
        borderRadius: AppConstants.borderRadius10,
      ),
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
      },
      children: data.map((entry) {
        return TableRow(
          children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: AppConstants.padding16,
                child: Text(
                  entry.title.tr(),
                  style: context.tt.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: AppConstants.padding16,
                child: Text(
                  entry.value,
                  style: context.tt.titleSmall,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
