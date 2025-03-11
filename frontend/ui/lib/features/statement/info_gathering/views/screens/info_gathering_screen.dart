library info_gathering;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../config/routes/app_pages.dart';
import '../../../../../shared/constants/app_constants.dart';
import '../../../../../shared/widgets/chatting_card.dart';
import '../../../../../shared/widgets/get_premium_card.dart';
import '../../../../../shared/widgets/list_profil_image.dart';
import '../../../../../shared/widgets/profile.dart';
import '../../../../../shared/widgets/profile_tile.dart';
import '../../../../../shared/widgets/search_field.dart';
import '../../../../../shared/widgets/sidebar_header.dart';
import '../../../../../shared/widgets/today_text.dart';
import '../../../../../utils/services/authetication_services.dart';
import '../../../../../utils/services/local_secure_storage_services.dart';
import '../../../../../utils/ui/ui_utils.dart';

// component
import '../../../../../shared/widgets/sidebar.dart';
part '../components/active_project_card.dart';
part '../components/header.dart';
part '../components/overview_header.dart';
part '../components/recent_messages.dart';
part '../components/team_member.dart';

// binding
part '../../bindings/info_gathering_binding.dart';

// controller
part '../../controllers/info_gathering_controller.dart';

// models

class InfoGatheringScreen extends StatelessWidget {
  InfoGatheringScreen({Key? key}) : super(key: key);

  final InfoGatheringController controller = Get.find();

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
            child: Column(
              children: [
                const SizedBox(height: kSpacing * (kIsWeb ? 1 : 2)),
                _buildHeader(onPressedMenu: () => controller.openDrawer()),
                const SizedBox(height: kSpacing / 2),
                const Divider(),
                _buildProfile(data: controller.getProfil()),
                const SizedBox(height: kSpacing),
                _buildTeamMember(data: controller.getMember()),
                const SizedBox(height: kSpacing),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kSpacing),
                  child: GetPremiumCard(onPressed: () {}),
                ),
                const SizedBox(height: kSpacing * 2),
                _buildStickySection(context),
                const SizedBox(height: kSpacing),
                _buildInfoGatheringSection(context),
              ],
            ),
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
                        onPressedMenu: () => controller.openDrawer(),
                      ),
                      const SizedBox(height: kSpacing * 2),
                      _buildStickySection(context),
                      const SizedBox(height: kSpacing),
                      _buildInfoGatheringSection(context),
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: kSpacing,
                        ),
                        child: GetPremiumCard(onPressed: () {}),
                      ),
                      const SizedBox(height: kSpacing),
                      const Divider(thickness: 1),
                      const SizedBox(height: kSpacing),
                      _buildRecentMessages(data: controller.getChatting()),
                    ],
                  ),
                ),
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
                  child: Sidebar(data: controller.getSelectedProject()),
                ),
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
                      const SizedBox(height: kSpacing * 2),
                      _buildStickySection(context),
                      const SizedBox(height: kSpacing),
                      _buildInfoGatheringSection(context),
                      const SizedBox(height: kSpacing),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kSpacing,
                        ),
                        child: GetPremiumCard(onPressed: () {}),
                      ),
                      const SizedBox(height: kSpacing),
                      const Divider(thickness: 1),
                      const SizedBox(height: kSpacing),
                      _buildRecentMessages(data: controller.getChatting()),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: (ResponsiveBuilder.isMobile(context)) ||
              (ResponsiveBuilder.isTablet(context))
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
                icon: const Icon(Icons.menu),
                tooltip: "menu",
              ),
            ),
          const Expanded(child: _Header()),
        ],
      ),
    );
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
          _TeamMember(totalMember: data.length, onPressedAdd: () {}),
          const SizedBox(height: kSpacing / 2),
          ListProfilImage(maxImages: 6, images: data),
        ],
      ),
    );
  }

  Widget _buildRecentMessages({required List<ChattingCardData> data}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSpacing),
          child: _RecentMessages(onPressedMore: () {}),
        ),
        const SizedBox(height: kSpacing / 2),
        ...data.map((e) => ChattingCard(data: e, onPressed: () {})).toList(),
      ],
    );
  }

  Widget _buildStickySection(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const Text('Family ID',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Obx(() => Text(controller.selectedFamily.value)),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () async {
                    final family = await controller.chooseFamily(context);
                    if (family != null) {
                      controller.selectedFamily.value = family;
                    }
                  },
                  child: const Text('Change Family'),
                ),
              ],
            ),
            Column(
              children: [
                const Text('Statement ID',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Obx(() => Text(controller.selectedStatement.value)),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () async {
                    final statement = await controller.chooseStatement(
                        context, controller.selectedFamily.value);
                    if (statement != null) {
                      controller.selectedStatement.value = statement;
                    }
                  },
                  child: const Text('Change Statement'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoGatheringSection(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kSpacing),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => controller.onNewStatementPressed(context),
                    child: const Text('New Statement'),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        controller.onExistingStatementPressed(context),
                    child: const Text('Existing Statement'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
