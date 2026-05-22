import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/widgets/module_card.dart';

class ManageScreen extends StatelessWidget {
  const ManageScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              /// HEADER
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

                children: [

                  Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      const Text(
                        "Manage",

                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                          color: AppColors.darkText,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        "Manage school operations",

                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.lightText,
                        ),
                      ),
                    ],
                  ),

                  Container(
                    padding: const EdgeInsets.all(14),

                    decoration: BoxDecoration(
                      color: AppColors.blueCard,
                      borderRadius:
                      BorderRadius.circular(18),
                    ),

                    child: const Icon(
                      Icons.search_rounded,
                      size: 30,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 36),

              /// QUICK ACTIONS
              const Text(
                "Quick Actions",

                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkText,
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [

                  Expanded(
                    child: _buildQuickAction(
                      title: "Add Student",
                      icon: Icons.person_add_alt_1_rounded,
                      color: AppColors.blueCard,
                      iconColor: AppColors.primaryBlue,
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: _buildQuickAction(
                      title: "Attendance",
                      icon: Icons.fact_check_rounded,
                      color: AppColors.greenCard,
                      iconColor: AppColors.green,
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: _buildQuickAction(
                      title: "Invoices",
                      icon:
                      Icons.account_balance_wallet_rounded,
                      color: AppColors.orangeCard,
                      iconColor: AppColors.orange,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              /// ACADEMIC STRUCTURE
              _buildSectionTitle("Academic Structure"),

              const SizedBox(height: 20),

              GridView.count(
                shrinkWrap: true,
                physics:
                const NeverScrollableScrollPhysics(),

                crossAxisCount: 2,
                crossAxisSpacing: 18,
                mainAxisSpacing: 18,
                childAspectRatio: 0.95,

                children: [

                  ModuleCard(
                    title: "Classes",
                    subtitle: "Manage all classes",

                    icon: Icons.school_rounded,

                    iconColor: AppColors.primaryBlue,

                    backgroundColor:
                    AppColors.blueCard,
                  ),

                  ModuleCard(
                    title: "Sections",
                    subtitle: "Manage sections",

                    icon: Icons.grid_view_rounded,

                    iconColor: AppColors.green,

                    backgroundColor:
                    AppColors.greenCard,
                  ),

                  ModuleCard(
                    title: "Subjects",
                    subtitle: "Manage subjects",

                    icon: Icons.menu_book_rounded,

                    iconColor: AppColors.orange,

                    backgroundColor:
                    AppColors.orangeCard,
                  ),

                  ModuleCard(
                    title: "Timetables",
                    subtitle: "Manage schedules",

                    icon: Icons.schedule_rounded,

                    iconColor: AppColors.purple,

                    backgroundColor:
                    AppColors.purpleCard,
                  ),
                ],
              ),

              const SizedBox(height: 40),

              /// STUDENT OPERATIONS
              _buildSectionTitle("Student Operations"),

              const SizedBox(height: 20),

              GridView.count(
                shrinkWrap: true,
                physics:
                const NeverScrollableScrollPhysics(),

                crossAxisCount: 2,
                crossAxisSpacing: 18,
                mainAxisSpacing: 18,
                childAspectRatio: 0.95,

                children: [

                  ModuleCard(
                    title: "Students",
                    subtitle: "Student management",

                    icon: Icons.groups_rounded,

                    iconColor: AppColors.primaryBlue,

                    backgroundColor:
                    AppColors.blueCard,
                  ),

                  ModuleCard(
                    title: "Attendance",
                    subtitle: "Track attendance",

                    icon:
                    Icons.event_available_rounded,

                    iconColor: AppColors.green,

                    backgroundColor:
                    AppColors.greenCard,
                  ),

                  ModuleCard(
                    title: "Examinations",
                    subtitle: "Manage exams",

                    icon: Icons.description_rounded,

                    iconColor: AppColors.orange,

                    backgroundColor:
                    AppColors.orangeCard,
                  ),

                  ModuleCard(
                    title: "Progress Reports",
                    subtitle: "Academic reports",

                    icon: Icons.analytics_rounded,

                    iconColor: AppColors.purple,

                    backgroundColor:
                    AppColors.purpleCard,
                  ),
                ],
              ),

              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {

    return Text(
      title,

      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.darkText,
      ),
    );
  }

  Widget _buildQuickAction({
    required String title,
    required IconData icon,
    required Color color,
    required Color iconColor,
  }) {

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
      ),

      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
      ),

      child: Column(
        children: [

          Icon(
            icon,
            color: iconColor,
            size: 34,
          ),

          const SizedBox(height: 12),

          Text(
            title,
            textAlign: TextAlign.center,

            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
            ),
          ),
        ],
      ),
    );
  }
}