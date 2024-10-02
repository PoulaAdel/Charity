library reports_custom;

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
import '../../../../shared/widgets/ui/project_card.dart';
import '../../../../shared/widgets/ui/task_card.dart';
import '../../../../utils/helpers/app_helpers.dart';
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
part '../../bindings/reports_custom_binding.dart';

// controller
part '../../controllers/reports_custom_controller.dart';

class ReportsCustomScreen extends StatelessWidget {
  ReportsCustomScreen({Key? key}) : super(key: key);

  final ReportsCustomController controller = Get.find();

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
              const SizedBox(height: kSpacing / 2),
              const Divider(),
              _buildProfile(data: controller.getProfil()),
              const SizedBox(height: kSpacing),
              // _buildProgress(axis: Axis.vertical),
              // const SizedBox(height: kSpacing),
              _buildTeamMember(data: controller.getMember()),
              const SizedBox(height: kSpacing),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kSpacing),
                child: GetPremiumCard(onPressed: () {}),
              ),
              const SizedBox(height: kSpacing * 2),
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
                      const SizedBox(height: kSpacing * 2),
                      // _buildProgress(
                      //   axis: (constraints.maxWidth < 950)
                      //       ? Axis.vertical
                      //       : Axis.horizontal,
                      // ),
                      // const SizedBox(height: kSpacing),
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
                      const SizedBox(height: kSpacing * 2),
                      // _buildProgress(),
                      // const SizedBox(height: kSpacing),
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

  // Widget _buildProgress({Axis axis = Axis.horizontal}) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: kSpacing),
  //     child: (axis == Axis.horizontal)
  //         ? Row(
  //             children: [
  //               Flexible(
  //                 flex: 5,
  //                 child: ProgressCard(
  //                   data: const ProgressCardData(
  //                     totalUndone: 10,
  //                     totalTaskInProress: 2,
  //                   ),
  //                   onPressedCheck: () {},
  //                 ),
  //               ),
  //               const SizedBox(width: kSpacing / 2),
  //               const Flexible(
  //                 flex: 4,
  //                 child: ProgressReportCard(
  //                   data: ProgressReportCardData(
  //                     title: "1st Sprint",
  //                     doneTask: 5,
  //                     percent: .3,
  //                     task: 3,
  //                     undoneTask: 2,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           )
  //         : Column(
  //             children: [
  //               ProgressCard(
  //                 data: const ProgressCardData(
  //                   totalUndone: 10,
  //                   totalTaskInProress: 2,
  //                 ),
  //                 onPressedCheck: () {},
  //               ),
  //               const SizedBox(height: kSpacing / 2),
  //               const ProgressReportCard(
  //                 data: ProgressReportCardData(
  //                   title: "1st Sprint",
  //                   doneTask: 5,
  //                   percent: .3,
  //                   task: 3,
  //                   undoneTask: 2,
  //                 ),
  //               ),
  //             ],
  //           ),
  //   );
  // }

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
