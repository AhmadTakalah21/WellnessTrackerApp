// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
// import 'package:wellnesstrackerapp/global/utils/constants.dart';

// class MainTabBar extends StatelessWidget {
//   const MainTabBar({
//     super.key,
//     required this.titles,
//     required this.tabController,
//     required this.onTapSelected,
//     required this.selectedTab,
//     this.isScrollable = true,
//   });

//   final List<String> titles;
//   final TabController tabController;
//   final ValueSetter<int> onTapSelected;
//   final int selectedTab;
//   final bool isScrollable;

//   @override
//   Widget build(BuildContext context) {
//     return TabBar(
//       controller: tabController,
//       isScrollable: isScrollable,
//       indicatorPadding: EdgeInsets.zero,
//       dividerColor: Colors.transparent,
//       indicatorColor: Colors.transparent,
//       labelPadding: EdgeInsets.zero,
//       tabAlignment: TabAlignment.start,
//       padding: const EdgeInsets.symmetric(horizontal: 10 * 1.25),
//       tabs: List.generate(
//         titles.length,
//         (index) {
//           final title = titles[index];
//           return GestureDetector(
//             onTap: () => onTapSelected(index),
//             child: AnimatedContainer(
//               duration: AppConstants.duration500ms,
//               margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
//               padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//               decoration: BoxDecoration(
//                   borderRadius: AppConstants.borderRadius10,
//                   color: selectedTab == index
//                       ? context.cs.primary
//                       : context.cs.onSurface,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withValues(alpha: 0.3),
//                       blurRadius: 2,
//                       offset: const Offset(0, 2),
//                     ),
//                   ]),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     title.tr(),
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w700,
//                       color: selectedTab == index
//                           ? context.cs.onSurface
//                           : context.cs.primary,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';

class MainTabBar extends StatelessWidget {
  const MainTabBar({
    super.key,
    required this.titles,
    required this.tabController,
    required this.onTapSelected,
    required this.selectedTab,
    this.isScrollable = true,
  });

  final List<String> titles;
  final TabController tabController;
  final ValueSetter<int> onTapSelected;
  final int selectedTab;
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    if (isScrollable) {
      return TabBar(
        controller: tabController,
        isScrollable: true,
        indicatorPadding: EdgeInsets.zero,
        dividerColor: Colors.transparent,
        indicatorColor: Colors.transparent,
        labelPadding: EdgeInsets.zero,
        tabAlignment: TabAlignment.start,
        onTap: onTapSelected,
        padding: const EdgeInsets.symmetric(horizontal: 10 * 1.25),
        tabs: List.generate(titles.length, (index) {
          final title = titles[index];
          return _buildTab(context, title, index);
        }),
      );
    } else {
      return Row(
        children: List.generate(titles.length, (index) {
          final title = titles[index];
          return Expanded(
            child: GestureDetector(
              onTap: () => onTapSelected(index),
              child: _buildTab(context, title, index),
            ),
          );
        }),
      );
    }
  }

  Widget _buildTab(BuildContext context, String title, int index) {
    return AnimatedContainer(
      duration: AppConstants.duration500ms,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: AppConstants.borderRadius10,
        color: selectedTab == index ? context.cs.primary : context.cs.onSurface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          title.tr(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: selectedTab == index
                ? context.cs.onSurface
                : context.cs.primary,
          ),
        ),
      ),
    );
  }
}
