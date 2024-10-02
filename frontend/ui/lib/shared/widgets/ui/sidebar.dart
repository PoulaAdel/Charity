import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/widgets/ui/sidebar_header.dart';

import '../../../features/dashboard/views/screens/dashboard_screen.dart';
import '../../../features/reports/views/screens/reports_daily_screen.dart';
import '../../../features/reports/views/screens/reports_monthly_screen.dart';
import '../../../features/reports/views/screens/reports_products_screen.dart';
import '../../constants/app_constants.dart';

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
                leading: const Icon(EvaIcons.grid),
                title: const Text("Dashboard"),
                onTap: () {
                  Get.offAll(() => DashboardScreen(),
                      binding: DashboardBinding());
                },
              ),
              ListTile(
                leading: const Icon(Icons.money),
                title: const Text("Cashier"),
                onTap: () {
                  Get.offAll(() => CashierScreen(), binding: CashierBinding());
                },
              ),
              ListTile(
                leading: const Icon(Icons.list),
                title: const Text("Categories"),
                onTap: () {
                  Get.offAll(() => CategoriesListScreen(),
                      binding: CategoriesListBinding());
                },
              ),
              ListTile(
                leading: const Icon(Icons.wallet),
                title: const Text("Coupons"),
                onTap: () {
                  Get.offAll(() => CouponsListScreen(),
                      binding: CouponsListBinding());
                },
              ),
              ExpansionTile(
                title: const Text("Products"),
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.list),
                    title: const Text("List Products"),
                    onTap: () {
                      Get.offAll(() => ProductsListScreen(),
                          binding: ProductsListBinding());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.code_off),
                    title: const Text("Products Barcode"),
                    onTap: () {
                      Get.offAll(() => ProductsPrintBarcodeScreen(),
                          binding: ProductsPrintBarcodeBinding());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.print),
                    title: const Text("Print Label"),
                    onTap: () {
                      Get.offAll(() => ProductsPrintLabelScreen(),
                          binding: ProductsPrintLabelBinding());
                    },
                  ),
                ],
              ),
              ExpansionTile(
                title: const Text("Cash Flow"),
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.money),
                    title: const Text("Sales"),
                    onTap: () {
                      Get.offAll(() => SalesListScreen(),
                          binding: SalesListBinding());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.money),
                    title: const Text("Sales On Hold"),
                    onTap: () {
                      Get.offAll(() => SalesOnHoldScreen(),
                          binding: SalesOnHoldBinding());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.list),
                    title: const Text("Purchases"),
                    onTap: () {
                      Get.offAll(() => PurchasesListScreen(),
                          binding: PurchasesListBinding());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.list),
                    title: const Text("Expenses"),
                    onTap: () {
                      Get.offAll(() => ExpensesListScreen(),
                          binding: ExpensesListBinding());
                    },
                  ),
                ],
              ),
              ExpansionTile(
                title: const Text("People"),
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.list),
                    title: const Text("Users"),
                    onTap: () {
                      Get.offAll(() => UsersListScreen(),
                          binding: UsersListBinding());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.list),
                    title: const Text("Customers"),
                    onTap: () {
                      Get.offAll(() => CustomersListScreen(),
                          binding: CustomersListBinding());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.list),
                    title: const Text("Suppliers"),
                    onTap: () {
                      Get.offAll(() => SuppliersListScreen(),
                          binding: SuppliersListBinding());
                    },
                  ),
                ],
              ),
              ExpansionTile(
                title: const Text("Reports"),
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.list),
                    title: const Text("Daily Report"),
                    onTap: () {
                      Get.offAll(() => ReportsDailyScreen(),
                          binding: ReportsDailyBinding());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.list),
                    title: const Text("Monthly Report"),
                    onTap: () {
                      Get.offAll(() => ReportsMonthlyScreen(),
                          binding: ReportsMonthlyBinding());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.list),
                    title: const Text("Stock Report"),
                    onTap: () {
                      Get.offAll(() => ReportsProductsScreen(),
                          binding: ReportsProductsBinding());
                    },
                  ),
                ],
              ),
              const Divider(thickness: 1),
            ], //ListViewChildren
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(kSpacing),
          child: Column(
            children: [
              Text("The Poulagrammer Corp."),
              Text("MIT License 2022 - 2032"),
              Align(
                alignment: Alignment.center,
                child: Text("Copyright©. All Rights Reserved.",
                    textScaleFactor: 0.8),
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