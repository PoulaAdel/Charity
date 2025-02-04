library member;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/routes/app_pages.dart';
import '../../../../database/models/app_models.dart';
import '../../../../shared/widgets/active_project_card.dart';
import '../../../../shared/widgets/overview_header.dart';
import '../../../../shared/widgets/search_field.dart';
import '../../../../shared/widgets/sidebar_header.dart';
import '../../../../shared/widgets/today_text.dart';
import '../../../../utils/services/authetication_services.dart';
import '../../../../utils/services/local_secure_storage_services.dart';
import '../../../../shared/constants/app_constants.dart';
import '../../../../shared/widgets/chatting_card.dart';
import '../../../../shared/widgets/get_premium_card.dart';
import '../../../../shared/widgets/progress_card.dart';
import '../../../../shared/widgets/progress_report_card.dart';
import '../../../../shared/widgets/project_card.dart';
import '../../../../shared/widgets/task_card.dart';
import '../../../../utils/helpers/app_helpers.dart';
import '../../../../utils/ui/ui_utils.dart';

// component
import '../../../../shared/widgets/sidebar.dart';

// binding
part '../../bindings/member_binding.dart';

// controller
part '../../controllers/member_controller.dart';

class MemberScreen extends StatelessWidget {
  MemberScreen({Key? key}) : super(key: key);

  final MemberController controller = Get.find();

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
              // _buildProfile(data: controller.getProfil()),
              const SizedBox(height: kSpacing),
              _buildReportsSection(),
              const SizedBox(height: kSpacing),
              // _buildTeamMember(data: controller.getMember()),
              const SizedBox(height: kSpacing),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kSpacing),
                child: GetPremiumCard(onPressed: () {}),
              ),
              const SizedBox(height: kSpacing * 2),
              _buildTaskOverview(
                data: controller.getAllTask(),
              ),
              const SizedBox(height: kSpacing * 2),
              _buildActiveProject(
                data: controller.getActiveProject(),
              ),
              const SizedBox(height: kSpacing),
              // _buildRecentMessages(data: controller.getChatting()),
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
                      _buildReportsSection(),
                      const SizedBox(height: kSpacing * 2),
                      _buildTaskOverview(
                        data: controller.getAllTask(),
                      ),
                      const SizedBox(height: kSpacing * 2),
                      _buildActiveProject(
                        data: controller.getActiveProject(),
                      ),
                      const SizedBox(height: kSpacing),
                    ],
                  ),
                ),
                const Flexible(
                  flex: 4,
                  child: Column(
                    children: [
                      SizedBox(height: kSpacing * (kIsWeb ? 0.5 : 1.5)),
                      // Obx(() => _buildProfile(data: controller.getProfil())),
                      // const Divider(thickness: 1),
                      // const SizedBox(height: kSpacing),
                      // _buildTeamMember(data: controller.getMember()),
                      // const SizedBox(height: kSpacing),
                      // Padding(
                      //   padding:
                      //       const EdgeInsets.symmetric(horizontal: kSpacing),
                      //   child: GetPremiumCard(onPressed: () {}),
                      // ),
                      // const SizedBox(height: kSpacing),
                      // const Divider(thickness: 1),
                      // const SizedBox(height: kSpacing),
                      // _buildRecentMessages(data: controller.getChatting()),
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
                      _buildReportsSection(),
                      const SizedBox(height: kSpacing * 2),
                      _buildTaskOverview(data: controller.getAllTask()),
                      const SizedBox(height: kSpacing * 2),
                      _buildActiveProject(data: controller.getActiveProject()),
                      const SizedBox(height: kSpacing),
                    ],
                  ),
                ),
              ),
              const Flexible(
                flex: 4,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  primary: false,
                  child: Column(),
                ),
              )
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
          Expanded(
            child: Row(
              children: [
                const TodayText(),
                const SizedBox(width: kSpacing),
                Expanded(child: SearchField()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Row(
        children: [
          Flexible(
            flex: 5,
            child: ProgressCard(
              data: const ProgressCardData(
                totalUndone: 10,
                totalTaskInProress: 2,
              ),
              onPressedCheck: () {},
            ),
          ),
          const SizedBox(width: kSpacing / 2),
          const Flexible(
            flex: 4,
            child: ProgressReportCard(
              data: ProgressReportCardData(
                title: "1st Sprint",
                doneTask: 5,
                percent: .3,
                task: 3,
                undoneTask: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskOverview({required List<TaskCardData> data}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Column(
        children: [
          OverviewHeader(
            onSelected: (task) {},
          ),
          const SizedBox(height: kSpacing),
          Row(
            children: data
                .map(
                  (e) => Expanded(
                    child: TaskCard(
                      data: e,
                      onPressedMore: () {},
                      onPressedTask: () {},
                      onPressedContributors: () {},
                      onPressedComments: () {},
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveProject({required List<ProjectCardData> data}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: ActiveProjectCard(
        onPressedSeeAll: () {},
        data: data,
      ),
    );
  }
}
