library donation_management;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../config/routes/app_pages.dart';
import '../../../../../database/models/app_models.dart';
import '../../../../../shared/constants/app_constants.dart';
import '../../../../../shared/widgets/chatting_card.dart';
import '../../../../../shared/widgets/get_premium_card.dart';
import '../../../../../shared/widgets/list_profil_image.dart';
import '../../../../../shared/widgets/profile.dart';
import '../../../../../shared/widgets/profile_tile.dart';
import '../../../../../shared/widgets/project_card.dart';
import '../../../../../shared/widgets/search_field.dart';
import '../../../../../shared/widgets/sidebar_header.dart';
import '../../../../../shared/widgets/task_card.dart';
import '../../../../../shared/widgets/today_text.dart';
import '../../../../../utils/helpers/app_helpers.dart';
import '../../../../../utils/services/authetication_services.dart';
import '../../../../../utils/services/local_secure_storage_services.dart';
import '../../../../../utils/services/rest_api_services.dart';
import '../../../../../utils/ui/ui_utils.dart';

// component
import '../../../../../shared/widgets/sidebar.dart';
part '../components/active_project_card.dart';
part '../components/header.dart';
part '../components/overview_header.dart';
part '../components/recent_messages.dart';
part '../components/team_member.dart';
part '../components/donation_form.dart';

// binding
part '../../bindings/donations_binding.dart';

// controller
part '../../controllers/donations_controller.dart';

// models

class DonationManagementScreen extends StatelessWidget {
  DonationManagementScreen({Key? key}) : super(key: key);

  final DonationManagementController controller = Get.find();

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
                _buildDonationsSection(),
                const SizedBox(height: kSpacing),
                _buildTeamMember(data: controller.getMember()),
                const SizedBox(height: kSpacing),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kSpacing),
                  child: GetPremiumCard(onPressed: () {}),
                ),
                const SizedBox(height: kSpacing * 2),
                _buildRecentMessages(data: controller.getChatting()),
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
                      _buildDonationsSection(),
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
                      _buildDonationsSection(),
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

  Widget _buildDonationsSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSpacing),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.bottomSheet(
                    DonationForm(),
                    backgroundColor: Colors.white,
                    isScrollControlled: true,
                  );
                },
                child: const Text('Add Donation'),
              ),
              const SizedBox(width: kSpacing),
              Expanded(
                child: TextField(
                  controller: controller.searchController,
                  decoration: InputDecoration(
                    hintText: 'Search donations...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (value) {
                    controller.searchDonations(value);
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  controller.searchDonations(controller.searchController.text);
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  semanticsLabel: "Loading",
                ),
              ),
            );
          } else if (controller.donations.isEmpty) {
            return const Center(child: Text('No donations found'));
          } else {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.donations.length,
              itemBuilder: (context, index) {
                final donation = controller.donations[index];
                return ListTile(
                  title: Text('Donation ${donation.pk}'),
                  subtitle: Text(donation.donor.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        color: Colors.green,
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Edit donation
                          Get.bottomSheet(
                            DonationForm(donation: donation),
                            backgroundColor: Colors.white,
                            isScrollControlled: true,
                          );
                        },
                      ),
                      IconButton(
                        color: Colors.red,
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // Delete donation
                          Get.defaultDialog(
                            title: "Delete Donation",
                            middleText:
                                "Are you sure you want to delete this donation?",
                            textCancel: "Cancel",
                            textConfirm: "Delete",
                            confirmTextColor: Colors.white,
                            onConfirm: () {
                              controller.deleteDonation(donation.pk!);
                              Get.back();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    Get.bottomSheet(
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Donation ${donation.pk} Details',
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            Text('Donor: ${donation.donor}',
                                style: const TextStyle(fontSize: 18)),
                            const SizedBox(height: 8),
                            Text('Type: ${donation.type}',
                                style: const TextStyle(fontSize: 18)),
                            const SizedBox(height: 8),
                            Text('Notes: ${donation.notes ?? 'N/A'}',
                                style: const TextStyle(fontSize: 18)),
                            const SizedBox(height: 8),
                            Text('Amount: ${donation.amount}',
                                style: const TextStyle(fontSize: 18)),
                            const SizedBox(height: 8),
                            Text('Created At: ${donation.createdAt}',
                                style: const TextStyle(fontSize: 18)),
                            const SizedBox(height: 8),
                            Text('Updated At: ${donation.updatedAt ?? 'N/A'}',
                                style: const TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                      backgroundColor: Colors.black87,
                      isScrollControlled: true,
                    );
                  },
                );
              },
            );
          }
        }),
      ],
    );
  }
}
