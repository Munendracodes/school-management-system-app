import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {

  final String selectedMenu;

  final Function(String) onMenuTap;

  const AppDrawer({

    super.key,

    required this.selectedMenu,

    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {

    final menuItems = [

      {
        "title": "Home",
        "icon": Icons.home_rounded,
      },

      {
        "title": "Attendance",
        "icon": Icons.fact_check_rounded,
      },

      {
        "title": "Students",
        "icon": Icons.school_rounded,
      },

      {
        "title": "Teachers",
        "icon": Icons.groups_rounded,
      },

      {
        "title": "Fees",
        "icon": Icons.account_balance_wallet_rounded,
      },

      {
        "title": "Timetable",
        "icon": Icons.schedule_rounded,
      },

      {
        "title": "Announcements",
        "icon": Icons.campaign_rounded,
      },

      {
        "title": "Settings",
        "icon": Icons.settings_rounded,
      },
    ];

    return Drawer(

      backgroundColor:
      const Color(0xFFF8FAFF),

      child: SafeArea(

        child: Column(

          children: [

            _buildHeader(),

            Expanded(

              child: ListView(

                padding:
                const EdgeInsets.all(
                  20,
                ),

                children: [

                  const Padding(

                    padding:
                    EdgeInsets.only(
                      left: 6,
                      bottom: 12,
                    ),

                    child: Text(

                      "ACADEMIC",

                      style: TextStyle(

                        fontSize: 12,

                        fontWeight:
                        FontWeight.w700,

                        color:
                        Color(
                          0xFF98A2B3,
                        ),
                      ),
                    ),
                  ),

                  ...menuItems.map(

                        (item) {

                      return _buildMenuCard(

                        title:
                        item["title"]
                        as String,

                        icon:
                        item["icon"]
                        as IconData,

                        isSelected:
                        selectedMenu ==
                            item[
                            "title"],

                        onTap: () {

                          Navigator.pop(
                              context);

                          onMenuTap(

                            item["title"]
                            as String,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),

            Padding(

              padding:
              const EdgeInsets.all(
                20,
              ),

              child: _buildLogoutCard(

                context,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {

    return Container(

      width: double.infinity,

      padding:
      const EdgeInsets.symmetric(

        vertical: 30,
      ),

      decoration:
      const BoxDecoration(

        gradient: LinearGradient(

          begin:
          Alignment.topLeft,

          end:
          Alignment.bottomRight,

          colors: [

            Color(0xFF2457FF),

            Color(0xFF4B7BFF),
          ],
        ),
      ),

      child: Column(

        children: [

          Container(

            height: 80,
            width: 80,

            decoration:
            BoxDecoration(

              color:
              Colors.white,

              borderRadius:
              BorderRadius
                  .circular(
                24,
              ),
            ),

            child: const Icon(

              Icons.school_rounded,

              color:
              Color(
                0xFF2457FF,
              ),

              size: 40,
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          const Text(

            "Sunshine Public School",

            style: TextStyle(

              color: Colors.white,

              fontSize: 22,

              fontWeight:
              FontWeight.w700,
            ),
          ),

          const SizedBox(
            height: 4,
          ),

          Text(

            "Academic Year 2026-27",

            style: TextStyle(

              color:
              Colors.white
                  .withOpacity(
                0.9,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard({

    required String title,

    required IconData icon,

    required bool isSelected,

    required VoidCallback onTap,
  }) {

    return GestureDetector(

      onTap: onTap,

      child: Container(

        margin:
        const EdgeInsets.only(
          bottom: 12,
        ),

        padding:
        const EdgeInsets.symmetric(

          horizontal: 16,

          vertical: 16,
        ),

        decoration:
        BoxDecoration(

          gradient: isSelected

              ? const LinearGradient(

            colors: [

              Color(
                  0xFF2457FF),

              Color(
                  0xFF4B7BFF),
            ],
          )

              : null,

          color: isSelected

              ? null

              : Colors.white,

          borderRadius:
          BorderRadius
              .circular(
            20,
          ),

          boxShadow: [

            BoxShadow(

              color: isSelected

                  ? const Color(
                0xFF2457FF,
              ).withOpacity(
                0.18,
              )

                  : Colors.black
                  .withOpacity(
                0.04,
              ),

              blurRadius: 15,

              offset:
              const Offset(
                0,
                6,
              ),
            ),
          ],
        ),

        child: Row(

          children: [

            Icon(

              icon,

              color: isSelected

                  ? Colors.white

                  : const Color(
                0xFF081B5C,
              ),
            ),

            const SizedBox(
              width: 16,
            ),

            Expanded(

              child: Text(

                title,

                style: TextStyle(

                  fontSize: 15,

                  fontWeight:
                  FontWeight.w600,

                  color: isSelected

                      ? Colors.white

                      : const Color(
                    0xFF081B5C,
                  ),
                ),
              ),
            ),

            Icon(

              Icons
                  .arrow_forward_ios_rounded,

              size: 16,

              color: isSelected

                  ? Colors.white

                  : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutCard(
      BuildContext context,
      ) {

    return GestureDetector(

      onTap: () {

        Navigator.pop(
          context,
        );

        onMenuTap(
          "Logout",
        );
      },

      child: Container(

        padding:
        const EdgeInsets.symmetric(

          horizontal: 16,

          vertical: 16,
        ),

        decoration:
        BoxDecoration(

          color:
          Colors.red.shade50,

          borderRadius:
          BorderRadius
              .circular(
            20,
          ),
        ),

        child: const Row(

          children: [

            Icon(

              Icons.logout_rounded,

              color: Colors.red,
            ),

            SizedBox(
              width: 16,
            ),

            Text(

              "Logout",

              style: TextStyle(

                color: Colors.red,

                fontWeight:
                FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}