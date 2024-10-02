library reports_products;

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/routes/app_pages.dart';
import '../../../../database/models/app_models.dart';
import '../../../../shared/widgets/ui/sidebar_header.dart';
import '../../../../utils/services/authetication_services.dart';
import '../../../../utils/services/local_secure_storage_services.dart';

import '../../../../shared/constants/app_constants.dart';
import '../../../../shared/widgets/ui/chatting_card.dart';
import '../../../../shared/widgets/ui/get_premium_card.dart';
import '../../../../shared/widgets/ui/list_profil_image.dart';
import '../../../../utils/ui/ui_utils.dart';

// models
import '../../models/profile.dart';

// component
import '../../../../shared/widgets/ui/sidebar.dart';
import '../components/header.dart';
import '../components/profile_tile.dart';
import '../components/recent_messages.dart';
import '../components/team_member.dart';

// binding
part '../../bindings/reports_products_binding.dart';

// controller
part '../../controllers/reports_products_controller.dart';

class ReportsProductsScreen extends StatelessWidget {
  ReportsProductsScreen({Key? key}) : super(key: key);

  final ReportsProductsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      drawer: (ResponsiveBuilder.isDesktop(context))
          ? null
          : Drawer(
              child: Padding(
                padding: const EdgeInsets.only(top: kSpacing),
                child: Sidebar(data: controller.getSelectedProject()),
              ),
            ),
      body: ResponsiveBuilder(
        mobileBuilder: (context, constraints) {
          return SingleChildScrollView(
            controller: controller.scrollController,
            scrollDirection: Axis.vertical,
            child: Column(children: [
              const SizedBox(height: kSpacing * (kIsWeb ? 1 : 2)),
              _buildHeader(onPressedMenu: () => controller.openDrawer()),
              const SizedBox(height: kSpacing * 2),
              const Divider(),
              const SizedBox(height: kSpacing / 2),
              _buildTopSection(context),
              const SizedBox(height: kSpacing / 2),
              _buildMiddleSection(context),
              const SizedBox(height: kSpacing / 2),
              _buildBottomSection(context),
              const SizedBox(height: kSpacing),
              const Divider(),
              _buildProfile(data: controller.getProfil()),
              const SizedBox(height: kSpacing),
              // const SizedBox(height: kSpacing),
              _buildTeamMember(data: controller.getMember()),
              const SizedBox(height: kSpacing),
              _buildRecentMessages(data: controller.getChatting()),
            ]),
          );
        },
        tabletBuilder: (context, constraints) {
          return SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: (constraints.maxWidth < 950) ? 6 : 9,
                  child: Column(
                    children: [
                      const SizedBox(height: kSpacing * (kIsWeb ? 1 : 2)),
                      _buildHeader(
                          onPressedMenu: () => controller.openDrawer()),
                      const SizedBox(height: kSpacing),
                      _buildTopSection(context),
                      const SizedBox(height: kSpacing),
                      _buildMiddleSection(context),
                      const SizedBox(height: kSpacing),
                      _buildBottomSection(context),
                      const SizedBox(height: kSpacing),
                    ],
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Column(
                    children: [
                      const SizedBox(height: kSpacing * (kIsWeb ? 0.5 : 1.5)),
                      Obx(() => _buildProfile(data: controller.getProfil())),
                      const Divider(thickness: 1),
                      const SizedBox(height: kSpacing),
                      _buildTeamMember(data: controller.getMember()),
                      const SizedBox(height: kSpacing),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: kSpacing),
                        child: GetPremiumCard(onPressed: () {}),
                      ),
                      const SizedBox(height: kSpacing),
                      const Divider(thickness: 1),
                      const SizedBox(height: kSpacing),
                      _buildRecentMessages(data: controller.getChatting()),
                    ],
                  ),
                )
              ],
            ),
          );
        },
        desktopBuilder: (context, constraints) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: (constraints.maxWidth < 1360) ? 4 : 3,
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(kBorderRadius),
                      bottomRight: Radius.circular(kBorderRadius),
                    ),
                    child: Sidebar(data: controller.getSelectedProject())),
              ),
              Flexible(
                flex: 9,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  primary: false,
                  child: Column(
                    children: [
                      const SizedBox(height: kSpacing),
                      _buildHeader(),
                      const SizedBox(height: kSpacing / 2),
                      const Divider(),
                      const SizedBox(height: kSpacing),
                      _buildTopSection(context),
                      const SizedBox(height: kSpacing),
                      _buildMiddleSection(context),
                      const SizedBox(height: kSpacing),
                      _buildBottomSection(context),
                      const SizedBox(height: kSpacing / 2),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 4,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  primary: false,
                  child: Column(
                    children: [
                      const SizedBox(height: kSpacing / 2),
                      Obx(() => _buildProfile(data: controller.getProfil())),
                      const Divider(thickness: 1),
                      const SizedBox(height: kSpacing),
                      _buildTeamMember(data: controller.getMember()),
                      const SizedBox(height: kSpacing),
                      const Divider(thickness: 1),
                      const SizedBox(height: kSpacing),
                      _buildRecentMessages(data: controller.getChatting()),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
      floatingActionButton: (ResponsiveBuilder.isMobile(context))
          ? FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 50, 63, 70),
              hoverColor: const Color.fromARGB(255, 106, 136, 151),
              foregroundColor: Colors.white,
              onPressed: () {
                controller.scrollToTop();
              },
              heroTag: null,
              child: const Icon(Icons.arrow_upward),
            )
          : null,
    );
  }

  Widget _buildHeader({Function()? onPressedMenu}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Row(
        children: [
          if (onPressedMenu != null)
            Padding(
              padding: const EdgeInsets.only(right: kSpacing),
              child: IconButton(
                onPressed: onPressedMenu,
                icon: const Icon(EvaIcons.menu),
                tooltip: "menu",
              ),
            ),
          const Expanded(child: Header()),
        ],
      ),
    );
  }

  // void _buildChartsSection() {}

  Widget _buildTopSection(context) {
    return // Section 1
        // TopSection
        SizedBox(
      height: MediaQuery.of(context).size.height * 0.10,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('Shortage Items'),
                  Text('1000 Product'),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('Expired'),
                  Text('500 Product'),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('High Demand'),
                  Text('200 Product'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiddleSection(context) {
    return // Section 2
        // MiddleSection
        SizedBox(
      height: MediaQuery.of(context).size.height * 0.30,
      child: GridView.builder(
        itemCount: 5,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: getGridCount(context),
        ),
        itemBuilder: (context, index) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('Sales by Product Category'),
                  Text('\$1000'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomSection(context) {
    return // Section 2
        // BottomSection
        SizedBox(
      height: MediaQuery.of(context).size.height * 0.30,
      child: GridView.builder(
        itemCount: 5,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: getGridCount(context),
        ),
        itemBuilder: (context, index) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('Gross Profit'),
                  Text('\$1000'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  int getGridCount(context) {
    if (ResponsiveBuilder.isDesktop(context)) {
      return 4;
    } else if (ResponsiveBuilder.isTablet(context)) {
      return 3;
    } else {
      return 2;
    }
  }

  Widget _buildProfile({required Profile data}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: ProfilTile(
        data: data,
        onPressedLogOut: () {
          controller.logoutUser();
        },
      ),
    );
  }

  Widget _buildTeamMember({required List<ImageProvider> data}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TeamMember(
            totalMember: data.length,
            onPressedAdd: () {},
          ),
          const SizedBox(height: kSpacing / 2),
          ListProfilImage(maxImages: 6, images: data),
        ],
      ),
    );
  }

  Widget _buildRecentMessages({required List<ChattingCardData> data}) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSpacing),
        child: RecentMessages(onPressedMore: () {}),
      ),
      const SizedBox(height: kSpacing / 2),
      ...data
          .map(
            (e) => ChattingCard(data: e, onPressed: () {}),
          )
          .toList(),
    ]);
  }
}
