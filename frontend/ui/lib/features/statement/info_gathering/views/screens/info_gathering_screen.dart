library info_gathering;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../config/routes/app_pages.dart';
import '../../../../../database/models/app_models.dart';
import '../../../../../shared/constants/app_constants.dart';
import '../../../../../shared/widgets/chatting_card.dart';
import '../../../../../shared/widgets/get_premium_card.dart';
import '../../../../../shared/widgets/header.dart';
import '../../../../../shared/widgets/list_profil_image.dart';
import '../../../../../shared/widgets/profile.dart';
import '../../../../../shared/widgets/profile_tile.dart';
import '../../../../../shared/widgets/sidebar_header.dart';
import '../../../../../utils/services/authetication_services.dart';
import '../../../../../utils/services/local_secure_storage_services.dart';
import '../../../../../utils/services/rest_api_services.dart';
import '../../../../../utils/ui/ui_utils.dart';

// component
import '../../../../../shared/widgets/sidebar.dart';
part '../components/edit_statement_form.dart';
part '../components/active_project_card.dart';
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
          const Expanded(child: Header()),
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
            // Family ID Section
            Column(
              children: [
                const Text('Family ID',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Obx(() => Text(
                      controller.selectedFamily.value?.pk.toString() ?? '',
                      overflow: TextOverflow.ellipsis,
                    )),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () async {
                    final family = await controller.chooseFamily(context);
                    if (family != null) {
                      controller._localSecureStorage.saveFamily(family);
                      controller.selectedFamily.value = family;
                    }
                  },
                  child: const Text('Change Family'),
                ),
              ],
            ),
            // Statement ID Section
            Column(
              children: [
                const Text('Statement ID',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Obx(() => Text(
                      controller.selectedStatement.value?.pk.toString() ?? '',
                      overflow: TextOverflow.ellipsis,
                    )),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () async {
                    final statement = await controller.chooseStatement(
                        context, controller.selectedFamily.value!);
                    if (statement != null) {
                      controller.selectedStatement.value = statement;
                    }
                  },
                  child: const Text('Change Statement'),
                ),
              ],
            ),
            // Action Buttons Section
            Column(
              children: [
                SizedBox(
                  width: 150, // Set a fixed width for the buttons
                  child: ElevatedButton.icon(
                    onPressed: controller.clearData,
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    icon: const Icon(Icons.delete, color: Colors.white),
                    label: const Text('Clear Data'),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 150, // Set a fixed width for the buttons
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final familyId =
                          controller.selectedFamily.value?.pk.toString() ?? '';
                      Clipboard.setData(ClipboardData(text: familyId));
                      Get.snackbar('Copied', 'Family ID copied to clipboard');
                    },
                    icon: const Icon(Icons.copy, color: Colors.white),
                    label: const Text('Family ID'),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 150, // Set a fixed width for the buttons
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final statementId =
                          controller.selectedStatement.value?.pk.toString() ??
                              '';
                      Clipboard.setData(ClipboardData(text: statementId));
                      Get.snackbar(
                          'Copied', 'Statement ID copied to clipboard');
                    },
                    icon: const Icon(Icons.copy, color: Colors.white),
                    label: const Text('Statement ID'),
                  ),
                ),
                const SizedBox(height: 8),
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
      margin: const EdgeInsets.all(12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Info Gathering',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Obx(() {
              final isEnabled = controller.selectedStatement.value != null;
              return _buildButtonRow(
                buttons: [
                  _buildSquareButton(
                    'Spiritual',
                    Icons.self_improvement,
                    isEnabled
                        ? () {
                            Get.dialog(
                              EditStatementForm(modelType: 'spiritual'),
                              barrierDismissible: false,
                            );
                          }
                        : null,
                  ),
                  _buildSquareButton(
                    'Economical',
                    Icons.attach_money,
                    isEnabled
                        ? () {
                            Get.dialog(
                              EditStatementForm(modelType: 'economical'),
                              barrierDismissible: false,
                            );
                          }
                        : null,
                  ),
                ],
              );
            }),
            const SizedBox(height: 20),
            Obx(() {
              final isEnabled = controller.selectedStatement.value != null;
              return _buildButtonRow(
                buttons: [
                  _buildSquareButton(
                    'Residential',
                    Icons.home,
                    isEnabled
                        ? () {
                            Get.dialog(
                              EditStatementForm(modelType: 'residential'),
                              barrierDismissible: false,
                            );
                          }
                        : null,
                  ),
                  _buildSquareButton(
                    'Social',
                    Icons.people,
                    isEnabled
                        ? () {
                            Get.dialog(
                              EditStatementForm(modelType: 'social'),
                              barrierDismissible: false,
                            );
                          }
                        : null,
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRow({required List<Widget> buttons}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: buttons
          .expand(
              (button) => [Expanded(child: button), const SizedBox(width: 16)])
          .toList()
        ..removeLast(), // Remove trailing spacer
    );
  }

  Widget _buildSquareButton(
      String label, IconData icon, VoidCallback? onPressed) {
    return SizedBox(
      width: 60, // Set fixed width for smaller buttons
      height: 60, // Set fixed height for smaller buttons
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.all(2.0), // Further reduce padding
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36), // Increase icon size
            const SizedBox(height: 2), // Maintain small spacing
            Text(
              label,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold), // Increase font size
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
