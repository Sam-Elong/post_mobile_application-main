import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_mobile_application/modules/home/controller/home_controller.dart';
import 'package:post_mobile_application/routes/app_route_name.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF7900FD),
                Color(0xFF00CFFD),
              ],
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.admin_panel_settings,
                        size: 40,
                        color: Color(0xFF00FDB5),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Post Mobile App",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              ListTile(
                leading: const Icon(
                  Icons.dashboard,
                  color: Colors.white,
                ),
                title: const Text(
                  "Dashboard",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(AppRouteName.adminDashboard);
                },
              ),

              ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                title: const Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Get.offAllNamed(AppRouteName.login);
                },
              ),
            ],
          ),
        ),
      ),

      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: const Color(0xFFBE00FD),
      ),

      body: const Center(
        child: Text("Home Page"),
      ),
    );
  }
}