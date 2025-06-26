import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/auth/cubit/auth_cubit.dart';
import 'package:wellnesstrackerapp/features/auth/model/sign_in_model/sign_in_model.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/user_view_on_permission_model.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';
// import 'package:wellnesstrackerapp/views/exercisetracker/exercise.dart';
// import 'package:wellnesstrackerapp/views/habittracker/habittracker.dart';
// import 'package:wellnesstrackerapp/views/heartrater/heartrate.dart';
// import 'package:wellnesstrackerapp/views/hyderationtracking/hyderation.dart';
// import 'package:wellnesstrackerapp/views/mealtracking/mealtracking.dart';
// import 'package:wellnesstrackerapp/views/medicationremider/medication.dart';
// import 'package:wellnesstrackerapp/views/meditation/meditation.dart';
// import 'package:wellnesstrackerapp/views/mentalwellbeing/mentalwellbeing.dart';
// import 'package:wellnesstrackerapp/views/messages/chat_screen.dart';
// import 'package:wellnesstrackerapp/views/moodtracker/mood.dart';
// import 'package:wellnesstrackerapp/views/notifications/notifications.dart';
// import 'package:wellnesstrackerapp/views/nutritiontracking/nutritiontracking.dart';
// import 'package:wellnesstrackerapp/views/personalizedplansgeneration/personlizedplans.dart';
// import 'package:wellnesstrackerapp/views/physicalhealth/physicalhealth.dart';
// import 'package:wellnesstrackerapp/views/plans/plans.dart';
// import 'package:wellnesstrackerapp/views/reviews/reviews.dart';
// import 'package:wellnesstrackerapp/views/sleeptracking/sleeptracking.dart';
// import 'package:wellnesstrackerapp/views/stepstrcking/stepstracking.dart';
// import 'package:wellnesstrackerapp/views/stressmanagement/stressmanagement.dart';
// import 'package:wellnesstrackerapp/views/userprofilesetup/userprofile.dart';
// import 'package:wellnesstrackerapp/views/weighttracker/weighttracker.dart';
// import 'package:wellnesstrackerapp/views/yogatracker/yogatracker.dart';

abstract class DashboardViewCallBacks {
  void onLogoutTap();
}

@RoutePage()
class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<AuthCubit>(),
      child: Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    implements DashboardViewCallBacks {
  late final AuthCubit authCubit = context.read();
  late final user = context.read<SignInModel>();

  List<UserViewOnPermissionModel> modules = [];

  @override
  void initState() {
    super.initState();
    modules = user.role.getPermissions;
  }

  // final List<Color> iconColors = [
  //   Colors.red,
  //   Colors.blue,
  //   Colors.green,
  //   Colors.orange,
  //   Colors.purple,
  //   Colors.cyan,
  //   Colors.teal,
  //   Colors.amber,
  //   Colors.pink,
  //   Colors.indigo,
  //   Colors.lime,
  //   Colors.brown,
  //   Colors.deepOrange,
  //   Colors.deepPurple,
  //   Colors.lightBlue,
  //   Colors.lightGreen,
  //   Colors.yellow,
  //   Colors.grey,
  //   Colors.blueGrey,
  //   Colors.redAccent,
  //   Colors.greenAccent,
  //   Colors.orangeAccent,
  //   Colors.purpleAccent,
  //   Colors.tealAccent,
  // ];

  // final Map<String, dynamic> modules = {
  // "Daily Goals": {
  //   "icon": FontAwesomeIcons.listCheck,
  //   "screen": DailyGoalsScreen(),
  // },
  // "Exercise": {
  //   "icon": FontAwesomeIcons.dumbbell,
  //   "screen": ExerciseTrackerScreennnn(),
  // },
  // "Habit": {
  //   "icon": FontAwesomeIcons.checkDouble,
  //   "screen": HabitTrackerScreen(),
  // },
  // "Heart Rate": {"icon": FontAwesomeIcons.heartPulse, "screen": Heart1()},
  // "Hydration": {"icon": FontAwesomeIcons.glassWater, "screen": Hyderation1()},
  // "Meal": {"icon": FontAwesomeIcons.utensils, "screen": MealTrackingScreen()},
  // "Medication": {
  //   "icon": FontAwesomeIcons.pills,
  //   "screen": MedicationReminderScreen(),
  // },
  // "Meditation": {"icon": FontAwesomeIcons.om, "screen": MeditationScreen()},
  // "Mental": {
  //   "icon": FontAwesomeIcons.brain,
  //   "screen": MentalWellbeingScreen(),
  // },
  // "Mood": {"icon": FontAwesomeIcons.faceSmile, "screen": MoodTrackerScreen()},
  // "Nutrition": {
  //   "icon": FontAwesomeIcons.appleWhole,
  //   "screen": NutritionTrackingScreen(),
  // },
  // "Personalized": {
  //   "icon": FontAwesomeIcons.fileSignature,
  //   "screen": PersonalizedPlanScreen(),
  // },
  // "Physical": {
  //   "icon": FontAwesomeIcons.personWalking,
  //   "screen": PhysicalHealth(),
  // },
  // "Plans": {
  //   "icon": FontAwesomeIcons.calendarCheck,
  //   "screen": ActivityPlanScreen(),
  // },
  // "Reviews": {"icon": FontAwesomeIcons.star, "screen": Reviews()},
  // "Sleep": {"icon": FontAwesomeIcons.moon, "screen": SleepCalendarScreen()},
  // "Steps": {
  //   "icon": FontAwesomeIcons.shoePrints,
  //   "screen": StepTrackerScreen(),
  // },
  // "Stress": {"icon": FontAwesomeIcons.spa, "screen": StressManagement()},
  // "Profile ": {
  //   "icon": FontAwesomeIcons.userPen,
  //   "screen": UserProfileSetupScreen(),
  // },
  // "Weight": {
  //   "icon": FontAwesomeIcons.weightScale,
  //   "screen": WeightTrackerr(),
  // },
  // "Yoga": {
  //   "icon": FontAwesomeIcons.personPraying,
  //   "screen": YogaTrackerScreen(),
  // },
  // "Messages": {"icon": FontAwesomeIcons.commentDots, "screen": ChatScreen()},
  // };

  @override
  void onLogoutTap() {
    authCubit.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.cs.onSurface,
      appBar: AppBar(
        backgroundColor: context.cs.primary,
        elevation: 4,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 20),
            Text('Health & Wellness App', style: context.tt.titleLarge),
          ],
        ),
        actions: [
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is LogOutSuccess) {
                MainSnackBar.showSuccessMessage(context, state.message);
              } else if (state is SignInFail) {
                MainSnackBar.showErrorMessage(context, state.error);
              }
            },
            builder: (context, state) {
              if (state is SignInLoading) {
                return LoadingIndicator(color: context.cs.error);
              }
              return IconButton(
                iconSize: 30,
                color: context.cs.secondary,
                onPressed: onLogoutTap,
                icon: const Icon(Icons.logout_rounded),
              );
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4,
            mainAxisSpacing: 3,
          ),
          itemCount: modules.length,
          itemBuilder: (context, index) {
            final module = modules[index];
            return _buildGridItem(context, module);
          },
        ),
      ),
    );
  }

  Widget _buildGridItem(
    BuildContext context,
    UserViewOnPermissionModel module,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => module.screen),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: module.color.withAlpha((0.2 * 255).toInt()),
                shape: BoxShape.circle,
              ),
              child: Icon(module.icon, size: 37, color: module.color),
            ),
            const SizedBox(height: 6),
            Text(
              module.title.tr(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
