library service;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/routes/app_pages.dart';
import '../../../../database/models/app_models.dart';
import '../../../../database/providers/app_providers.dart';
import '../../../../shared/widgets/sidebar_header.dart';
import '../../../../utils/services/authetication_services.dart';
import '../../../../utils/services/local_secure_storage_services.dart';
import '../../../../shared/constants/app_constants.dart';
import '../../../../shared/widgets/chatting_card.dart';
import '../../../../shared/widgets/project_card.dart';
import '../../../../utils/ui/ui_utils.dart';

// component
import '../../../../shared/widgets/sidebar.dart';
import '../components/header.dart';

// binding
part '../../bindings/service_binding.dart';

// controller
part '../../controllers/service_controller.dart';

class ServiceScreen extends StatelessWidget {
  ServiceScreen({Key? key}) : super(key: key);

  final ServiceController controller = Get.find();

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
                      _buildServicesSection(),
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
          const Expanded(child: Header()),
        ],
      ),
    );
  }

  _buildServicesSection() {
    return Column(children: [
      ElevatedButton(
        onPressed: () {
          // Add a new service
          controller.addService(Service(
              pk: 1,
              name: 'New Service',
              description: 'Description',
              createdAt: DateTime.now()));
        },
        child: const Text('Add Service'),
      ),
      Expanded(
        child: Obx(() {
          return ListView.builder(
            itemCount: controller.services.length,
            itemBuilder: (context, index) {
              final service = controller.services[index];
              return ListTile(
                title: Text(service.name),
                subtitle: Text(service.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Edit service
                        controller.updateService(Service(
                            pk: service.pk,
                            name: 'Updated Service',
                            description: 'Updated Description',
                            createdAt: service.createdAt));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // Delete service
                        controller.deleteService(service.pk);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }),
      )
    ]);
  }
}
