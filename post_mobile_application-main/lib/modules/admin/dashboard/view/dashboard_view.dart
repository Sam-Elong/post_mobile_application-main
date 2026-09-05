import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_mobile_application/modules/admin/dashboard/controller/dashboard_controller.dart';
import 'package:post_mobile_application/routes/app_route_name.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  IconData getMenuIcon(String? title) {
    switch (title?.toLowerCase()) {
      case "posts":
        return Icons.article_outlined;
      case "categories":
        return Icons.category_outlined;
      case "users":
        return Icons.people_outline;
      case "settings":
        return Icons.settings_outlined;
      default:
        return Icons.dashboard_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),

        appBar: AppBar(
          backgroundColor: const Color(0xFF00FDD7),
          elevation: 0,
          centerTitle: false,
          title: const Text(
            "Dashboard",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 12),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  color: Color(0xFF0F172A),
                ),
              ),
            ),
          ],
        ),

        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                "Welcome Back 👋",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                "Manage your posts and categories",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: GridView.builder(
                  itemCount: controller.menuList.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (context, index) {
                    final menu = controller.menuList[index];

                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          menu.routeName ??
                              AppRouteName.adminDashboard,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF2563EB),
                              Color(0xFF3B82F6),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.25),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [

                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius:
                                  BorderRadius.circular(18),
                                ),
                                child: Icon(
                                  getMenuIcon(menu.nameEn),
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),

                              const SizedBox(height: 20),

                              Text(
                                menu.nameEn ?? "",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}