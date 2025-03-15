import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/widgets/sidebar_header.dart';

import '../../features/dashboard/views/screens/dashboard_screen.dart';

import '../../features/account_management/donors/views/screens/donors_screen.dart';
import '../../features/account_management/members/views/screens/members_screen.dart';

import '../../features/orgnization_assets/donations/views/screens/donations_screen.dart';
import '../../features/orgnization_assets/families/views/screens/families_screen.dart';
import '../../features/orgnization_assets/services/views/screens/services_screen.dart';

import '../../features/statement/final_decision/views/screens/final_decision_screen.dart';
import '../../features/statement/info_gathering/views/screens/info_gathering_screen.dart';
import '../../features/statement/info_processing/views/screens/info_processing_screen.dart';

import '../../features/action_plan/check/views/screens/check_screen.dart';
import '../../features/action_plan/supply/views/screens/supply_screen.dart';

import '../../features/reports/weekly_report/views/screens/weekly_report_screen.dart';
import '../../features/reports/monthly_report/views/screens/monthly_report_screen.dart';

import '../constants/app_constants.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({
    required this.data,
    Key? key,
  }) : super(key: key);

  final SidebarHeaderData data;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
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
                  leading: const Icon(Icons.dashboard),
                  title: const Text("Dashboard"),
                  onTap: () {
                    Get.offAll(() => DashboardScreen(),
                        binding: DashboardBinding());
                  },
                ),
                ExpansionTile(
                  leading: const Icon(Icons.account_circle),
                  title: const Text("Accounts Management"),
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text("Donors"),
                      onTap: () {
                        Get.offAll(() => DonorManagementScreen(),
                            binding: DonorManagementBinding());
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.group),
                      title: const Text("Served Members"),
                      onTap: () {
                        Get.offAll(() => MemberManagementScreen(),
                            binding: MemeberManagementBinding());
                      },
                    ),
                  ],
                ),
                ExpansionTile(
                  leading: const Icon(Icons.business),
                  title: const Text("Orgnizations Assets"),
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.monetization_on),
                      title: const Text("Donations"),
                      onTap: () {
                        Get.offAll(() => DonationManagementScreen(),
                            binding: DonationManagementBinding());
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.miscellaneous_services),
                      title: const Text("Services"),
                      onTap: () {
                        Get.offAll(() => ServiceManagementScreen(),
                            binding: ServiceManagementBinding());
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.family_restroom),
                      title: const Text("Served Families"),
                      onTap: () {
                        Get.offAll(() => FamilyManagementScreen(),
                            binding: FamilyManagementBinding());
                      },
                    ),
                  ],
                ),
                ExpansionTile(
                  leading: const Icon(Icons.assignment),
                  title: const Text("Statements Management"),
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.info),
                      title: const Text("Info Gathering"),
                      onTap: () {
                        Get.offAll(() => InfoGatheringScreen(),
                            binding: InfoGatheringBinding());
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.upcoming),
                      title: const Text("Info Processing"),
                      onTap: () {
                        Get.offAll(() => InfoProcessingScreen(),
                            binding: InfoProcessingBinding());
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.check_circle),
                      title: const Text("Final Decision"),
                      onTap: () {
                        Get.offAll(() => FinalDecisionScreen(),
                            binding: FinalDecisionBinding());
                      },
                    ),
                  ],
                ),
                ExpansionTile(
                  leading: const Icon(Icons.assignment_turned_in),
                  title: const Text("Action Plan"),
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.local_shipping),
                      title: const Text("Supplies"),
                      onTap: () {
                        Get.offAll(() => SupplyScreen(),
                            binding: SupplyBinding());
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.check_box),
                      title: const Text("Supplies Check"),
                      onTap: () {
                        Get.offAll(() => CheckScreen(),
                            binding: CheckBinding());
                      },
                    ),
                  ],
                ),
                ExpansionTile(
                  leading: const Icon(Icons.report),
                  title: const Text("Reports"),
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.report),
                      title: const Text("Weekly Report"),
                      onTap: () {
                        Get.offAll(() => WeeklyReportScreen(),
                            binding: WeeklyReportBinding());
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: const Text("Monthly Report"),
                      onTap: () {
                        Get.offAll(() => MonthlyReportScreen(),
                            binding: MonthlyReportBinding());
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
                Text("MIT License"),
                Align(
                  alignment: Alignment.center,
                  child: Text("Copyright©. All Rights Reserved."),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
