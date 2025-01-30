import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/widgets/sidebar_header.dart';

import '../../features/account_management/views/screens/donor_screen.dart';
import '../../features/account_management/views/screens/user_screen.dart';
import '../../features/action_plan/views/screens/check_screen.dart';
import '../../features/action_plan/views/screens/supply_screen.dart';
import '../../features/dashboard/views/screens/dashboard_screen.dart';
import '../../features/orgnization_assets/views/screens/donation_screen.dart';
import '../../features/orgnization_assets/views/screens/family_screen.dart';
import '../../features/orgnization_assets/views/screens/member_screen.dart';
import '../../features/orgnization_assets/views/screens/service_screen.dart';
import '../../features/statement/views/screens/final_decision_screen.dart';
import '../../features/statement/views/screens/info_gathering_screen.dart';
import '../../features/statement/views/screens/info_processing_screen.dart';
import '../constants/app_constants.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({
    required this.data,
    Key? key,
  }) : super(key: key);

  final SidebarHeaderData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerHeader(
          padding: const EdgeInsets.all(kSpacing),
          child: Wrap(children: [
            SidebarHeaderCard(
              data: data,
            ),
          ]),
        ),
        Expanded(
          child: ListView(
            primary: false,
            scrollDirection: Axis.vertical,
            children: [
              ListTile(
                leading: const Icon(Icons.abc),
                title: const Text("Dashboard"),
                onTap: () {
                  Get.offAll(() => DashboardScreen(),
                      binding: DashboardBinding());
                },
              ),
              ExpansionTile(
                title: const Text("Accounts Management"),
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.list),
                    title: const Text("Users"),
                    onTap: () {
                      Get.offAll(() => UserScreen(), binding: UserBinding());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.code_off),
                    title: const Text("Donors"),
                    onTap: () {
                      Get.offAll(() => DonorScreen(), binding: DonorBinding());
                    },
                  ),
                ],
              ),
              ExpansionTile(
                title: const Text("Orgnizations Assets"),
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.list),
                    title: const Text("Donations"),
                    onTap: () {
                      Get.offAll(() => DonationScreen(),
                          binding: DonationBinding());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.code_off),
                    title: const Text("Services"),
                    onTap: () {
                      Get.offAll(() => ServiceScreen(),
                          binding: ServiceBinding());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.print),
                    title: const Text("Served Families"),
                    onTap: () {
                      Get.offAll(() => FamilyScreen(),
                          binding: FamilyBinding());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.print),
                    title: const Text("Served Members"),
                    onTap: () {
                      Get.offAll(() => MemberScreen(),
                          binding: MemberBinding());
                    },
                  ),
                ],
              ),
              ExpansionTile(
                title: const Text("Statements Management"),
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.list),
                    title: const Text("Info Gathering"),
                    onTap: () {
                      Get.offAll(() => InfoGatheringScreen(),
                          binding: InfoGatheringBinding());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.code_off),
                    title: const Text("Info Processing"),
                    onTap: () {
                      Get.offAll(() => InfoProcessingScreen(),
                          binding: InfoProcessingBinding());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.print),
                    title: const Text("Final Decision"),
                    onTap: () {
                      Get.offAll(() => FinalDecisionScreen(),
                          binding: FinalDecisionBinding());
                    },
                  ),
                ],
              ),
              ExpansionTile(
                title: const Text("Action Plan"),
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.list),
                    title: const Text("Supplies"),
                    onTap: () {
                      Get.offAll(() => SupplyScreen(),
                          binding: SupplyBinding());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.code_off),
                    title: const Text("Supplies Check"),
                    onTap: () {
                      Get.offAll(() => CheckScreen(), binding: CheckBinding());
                    },
                  ),
                ],
              ),
              ExpansionTile(
                title: const Text("Reports"),
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.list),
                    title: const Text("Custom"),
                    onTap: () {
                      // Get.offAll(() => CustomReportScreen(),
                      //     binding: CustomReportBinding());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.code_off),
                    title: const Text("Monthly"),
                    onTap: () {
                      // Get.offAll(() => MonthlyReportScreen(),
                      //     binding: MonthlyReportBinding());
                    },
                  ),
                ],
              ),
            ], //ListViewChildren
          ),
        ),
        const Divider(thickness: 1),
        const Padding(
          padding: EdgeInsets.all(kSpacing),
          child: Column(
            children: [
              Text("Developed By Poula Adel."),
              Text("MIT License 2022 - 2032"),
              Align(
                alignment: Alignment.center,
                child: Text("Copyright©. All Rights Reserved."),
              ),
            ],
          ),
        ),
      ],
    );
  }
}



/// Old Structure
/// 

// Container(
//       color: Theme.of(context).cardColor,
//       child: SingleChildScrollView(
//         controller: ScrollController(),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(kSpacing),
//               child: ProjectCard(
//                 data: data,
//               ),
//             ),
//             const Divider(thickness: 1),
//             SelectionButton(
//               data: [
//                 SelectionButtonData(
//                   activeIcon: EvaIcons.grid,
//                   icon: EvaIcons.gridOutline,
//                   label: "Dashboard",
//                 ),
//                 SelectionButtonData(
//                   activeIcon: EvaIcons.archive,
//                   icon: EvaIcons.archiveOutline,
//                   label: "Reports",
//                 ),
//                 SelectionButtonData(
//                   activeIcon: EvaIcons.calendar,
//                   icon: EvaIcons.calendarOutline,
//                   label: "Calendar",
//                 ),
//                 SelectionButtonData(
//                   activeIcon: EvaIcons.email,
//                   icon: EvaIcons.emailOutline,
//                   label: "Email",
//                   totalNotif: 20,
//                 ),
//                 SelectionButtonData(
//                   activeIcon: EvaIcons.person,
//                   icon: EvaIcons.personOutline,
//                   label: "Profile",
//                 ),
//                 SelectionButtonData(
//                   activeIcon: EvaIcons.settings,
//                   icon: EvaIcons.settingsOutline,
//                   label: "Setting",
//                 ),
//               ],
//               onSelected: (index, value) {
//                 log("index : $index | label : ${value.label}");
//               },
//             ),
//             const Divider(thickness: 1),
//             const SizedBox(height: kSpacing * 2),
//             UpgradePremiumCard(
//               backgroundColor: Theme.of(context).canvasColor.withOpacity(.4),
//               onPressed: () {},
//             ),
//             const SizedBox(height: kSpacing),
//           ],
//         ),
//       ),
//     );