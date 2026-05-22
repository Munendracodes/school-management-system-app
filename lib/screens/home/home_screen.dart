import 'package:flutter/material.dart';
import '../../core/widgets/app_logo.dart';
import '../../core/constants/app_colors.dart';
import '../manage/manage_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int selectedIndex = 0;
  int _selectedIndex = 0;

  final List<Widget> screens = [
    const HomeContent(),
    const ManageScreen()
  ];



  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(

      backgroundColor: const Color(0xFFF9FBFF),

      body: screens[selectedIndex],

      bottomNavigationBar: SizedBox(
        height: width * 0.16,

        child: BottomNavigationBar(

          currentIndex: _selectedIndex,

          onTap: (index) {

            setState(() {
              _selectedIndex = index;
            });
          },

          type: BottomNavigationBarType.fixed,

          showUnselectedLabels: true,

          backgroundColor: Colors.white,

          selectedItemColor:
          AppColors.primaryBlue,

          unselectedItemColor:
          Colors.grey.shade500,

          selectedFontSize:
          width * 0.035,

          unselectedFontSize:
          width * 0.035,

          iconSize:
          width * 0.06,

          elevation: 8,

          items: const [

            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: "Home",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_rounded),
              label: "Manage",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_rounded),
              label: "Reports",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.menu_rounded),
              label: "More",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {

    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {

        setState(() {
          selectedIndex = index;
        });
      },

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          if (isSelected)
            Container(
              margin: const EdgeInsets.only(bottom: 8),

              height: 4,
              width: 70,

              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.circular(20),
              ),
            )
          else
            const SizedBox(height: 12),

          Icon(
            icon,
            size: 30,

            color: isSelected
                ? AppColors.primaryBlue
                : const Color(0xFF626B84),
          ),

          const SizedBox(height: 6),

          Text(
            label,

            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,

              color: isSelected
                  ? AppColors.primaryBlue
                  : const Color(0xFF626B84),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});
  Text getGreeting() {

    final hour =
        DateTime.now().hour;

    if (hour < 12) {
      return Text(
        "Good Morning,",

        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFF081B5C),
          height: 1.2,
        ),
      );
    } else if (hour < 17) {
      return Text(
        "Good Afternoon,",

        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFF081B5C),
          height: 1.2,
        ),
      );
    } else {
      return Text(
        "Good Evening,",

        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFF081B5C),
          height: 1.2,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
          ),

          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 18),

              /// HEADER
              Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  /// MENU
                  const Padding(
                    padding: EdgeInsets.only(top: 10),

                    child: Icon(
                      Icons.menu_rounded,
                      size: 28,
                      color: AppColors.primaryBlue,
                    ),
                  ),

                  const SizedBox(width: 10),

                  /// LOGO + SCHOOL
                  Expanded(
                    child: Row(
                      children: [

                        /// LOGO
                     /*   AppLogo(
                          size: width * 0.12,
                        ),*/

                        const SizedBox(width: 5),

                        /// SCHOOL NAME
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            const Text(
                              "Sunshine Public School",

                              style: TextStyle(
                                fontSize: 18,
                                fontWeight:
                                FontWeight.w700,

                                color:
                                Color(0xFF081B5C),
                              ),
                            ),

                            Text(
                              "Admin Dashboard",

                              style: TextStyle(
                                fontSize: 15,
                                fontWeight:
                                FontWeight.w500,

                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  /// NOTIFICATION
                  Stack(
                    children: [

                      const Padding(
                        padding:
                        EdgeInsets.only(top: 10),

                        child: Icon(
                          Icons.notifications_none_rounded,
                          size: 28,
                          color: Color(0xFF081B5C),
                        ),
                      ),

                      Positioned(
                        right: -1,
                        top: 1,

                        child: Container(
                          height: 22,
                          width: 22,

                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),

                          child: const Center(
                            child: Text(
                              "3",

                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight:
                                FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 25),

              /// GREETING + BUILDING
              Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  /// LEFT TEXT
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [


                        getGreeting(),

                        const SizedBox(height: 2),

                        const Row(
                          children: [

                            Text(
                              "Admin",

                              style: TextStyle(
                                fontSize: 18,
                                fontWeight:
                                FontWeight.normal,

                                color:
                                Color(0xFF081B5C),
                              ),
                            ),

                            SizedBox(width: 8),

                            Text(
                              "👋",
                              style: TextStyle(
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "Thursday, 22 May 2025",

                          style: TextStyle(
                            fontSize: 13,
                            fontWeight:
                            FontWeight.w500,

                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// BUILDING
                  Opacity(
                    opacity: 0.95,

                    child: Image.asset(
                      "assets/images/school_building.png",

                      width: width * 0.42,

                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              /// TODAY OVERVIEW
              const Text(
                "Today’s Overview",

                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF081B5C),
                ),
              ),

              const SizedBox(height: 10),

              /// GRID
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),

                itemCount: 4,

                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,

                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,

                  mainAxisExtent:180
                ),

                itemBuilder: (context, index) {

                  final cards = [

                    _buildOverviewCard(
                      width: width,
                      bgColor: const Color(0xFFF4F7FF),
                      iconColor: AppColors.primaryBlue,
                      title: "Total Students",
                      value: "2,450",
                      subtitle: "",
                      icon: Icons.groups_rounded,
                    ),

                    _buildOverviewCard(
                      width: width,
                      bgColor: const Color(0xFFF3FCF4),
                      iconColor: const Color(0xFF17B62D),
                      title: "Today's Attendance",
                      value: "91%",
                      subtitle: "Present: 2,229",
                      icon: Icons.event_available_rounded,
                    ),

                    _buildOverviewCard(
                      width: width,
                      bgColor: const Color(0xFFFFF7F1),
                      iconColor: const Color(0xFFFF8400),
                      title: "Pending Fees",
                      value: "₹4,20,000",
                      subtitle: "From 342 Students",
                      icon:
                      Icons.account_balance_wallet_rounded,
                    ),

                    _buildOverviewCard(
                      width: width,
                      bgColor: const Color(0xFFF8F5FF),
                      iconColor: const Color(0xFF6D4CFF),
                      title: "Upcoming Exams",
                      value: "3",
                      subtitle: "Next: Unit Test (25 May)",
                      icon: Icons.description_rounded,
                    ),
                  ];

                  return cards[index];
                },
              ),

              const SizedBox(height: 10),

              /// ======================================
              /// FEE COLLECTION SUMMARY CARD
              /// ======================================

              Container(
                padding: EdgeInsets.all(width * 0.045),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                  BorderRadius.circular(28),

                  boxShadow: [
                    BoxShadow(
                      color:
                      Colors.black.withOpacity(0.03),

                      blurRadius: 18,

                      offset: const Offset(0, 8),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    /// HEADER
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                      children: [

                        Text(
                          "Fee Collection Summary",

                          style: TextStyle(
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF081B5C),
                          ),
                        ),

                        Row(
                          children: [

                            Text(
                              "This Month",

                              style: TextStyle(
                                fontSize: width * 0.034,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryBlue,
                              ),
                            ),

                            Icon(
                              Icons.keyboard_arrow_down_rounded,

                              size: width * 0.05,

                              color: Colors.grey.shade600,
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(
                      height: width * 0.05,
                    ),

                    /// CONTENT
                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.center,

                      children: [

                        /// PROGRESS CIRCLE
                        SizedBox(
                          height: width * 0.24,
                          width: width * 0.24,

                          child: Stack(
                            alignment: Alignment.center,

                            children: [

                              SizedBox(
                                height: width * 0.24,
                                width: width * 0.24,

                                child: CircularProgressIndicator(
                                  value: 0.68,

                                  strokeWidth: 10,

                                  backgroundColor:
                                  const Color(0xFFE8EEF9),

                                  valueColor:
                                  const AlwaysStoppedAnimation<Color>(
                                    Color(0xFF31C854),
                                  ),
                                ),
                              ),

                              Text(
                                "68%",

                                style: TextStyle(
                                  fontSize: width * 0.045,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF081B5C),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          width: width * 0.04,
                        ),

                        /// RIGHT SECTION
                        Expanded(
                          child: Row(
                            children: [

                              /// COLLECTED
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,

                                  children: [

                                    FittedBox(
                                      fit: BoxFit.scaleDown,

                                      child: Text(
                                        "₹8,16,000",

                                        style: TextStyle(
                                          fontSize: width * 0.045,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF081B5C),
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      height: width * 0.012,
                                    ),

                                    Text(
                                      "Collected",

                                      textAlign: TextAlign.center,

                                      style: TextStyle(
                                        fontSize: width * 0.03,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF31C854),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              /// DIVIDER
                              Container(
                                height: width * 0.16,
                                width: 1,

                                margin: EdgeInsets.symmetric(
                                  horizontal: width * 0.03,
                                ),

                                color: Colors.grey.shade300,
                              ),

                              /// TOTAL FEES
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,

                                  children: [

                                    FittedBox(
                                      fit: BoxFit.scaleDown,

                                      child: Text(
                                        "₹12,00,000",

                                        style: TextStyle(
                                          fontSize: width * 0.045,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      height: width * 0.012,
                                    ),

                                    Text(
                                      "Total Fees",

                                      textAlign: TextAlign.center,

                                      style: TextStyle(
                                        fontSize: width * 0.03,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: width * 0.05,
                    ),

                    /// BOTTOM GREEN STRIP
                    Container(
                      width: double.infinity,

                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.04,
                        vertical: width * 0.032,
                      ),

                      decoration: BoxDecoration(
                        color: const Color(0xFFF2FBF3),

                        borderRadius:
                        BorderRadius.circular(18),
                      ),

                      child: Row(
                        children: [

                          Icon(
                            Icons.trending_up_rounded,

                            color: const Color(0xFF31C854),

                            size: width * 0.055,
                          ),

                          SizedBox(
                            width: width * 0.025,
                          ),

                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [

                                  TextSpan(
                                    text: "₹2,16,000 ",

                                    style: TextStyle(
                                      fontSize: width * 0.036,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF31C854),
                                    ),
                                  ),

                                  TextSpan(
                                    text:
                                    "more collected than last month",

                                    style: TextStyle(
                                      fontSize: width * 0.033,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF3B4260),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),


              const SizedBox(height: 120)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewCard({
    required double width,
    required Color bgColor,
    required Color iconColor,
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
  }) {

    return Container(
      padding: EdgeInsets.all(
        width * 0.035,
      ),

      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(28),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          /// ICON
          Container(
            height: width * 0.18,
            width: width * 0.18,

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              shape: BoxShape.circle,
            ),

            child: Icon(
              icon,
              size: width * 0.08,
              color: iconColor,
            ),
          ),

          SizedBox(
            height: width * 0.02,
          ),

          /// VALUE
          Text(
            value,
            textAlign: TextAlign.center,

            style: TextStyle(
              fontSize: width * 0.048,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF081B5C),
            ),
          ),

          SizedBox(
            height: width * 0.015,
          ),

          /// TITLE
          Text(
            title,
            textAlign: TextAlign.center,

            style: TextStyle(
              fontSize: width * 0.035,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF3B4260),
            ),
          ),

          if (subtitle.isNotEmpty) ...[

            SizedBox(
              height: width * 0.025,
            ),

          /*  Text(
              subtitle,
              textAlign: TextAlign.center,

              style: TextStyle(
                fontSize: width * 0.032,
                fontWeight: FontWeight.w500,
                color: iconColor,
              ),
            ),*/
          ],
        ],
      ),
    );
  }
}