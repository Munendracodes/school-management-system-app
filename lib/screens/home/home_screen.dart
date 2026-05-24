import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/widgets/app_logo.dart';
import '../../core/constants/app_colors.dart';
import '../../services/home_service.dart';
import '../manage/manage_screen.dart';
import '../../models/home_response.dart';


class HomeScreen extends StatefulWidget {

  final String accessToken;

  final String userName;

  final String role;

  final HomeResponse homeResponse;

  const HomeScreen({
    super.key,
    required this.accessToken,
    required this.userName,
    required this.role,
    required this.homeResponse,
  });
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int selectedIndex = 0;
  int _selectedIndex = 0;
  HomeResponse? homeResponse;

  bool isLoading = true;

  @override




  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final screens = [

      HomeContent(
        homeResponse: widget.homeResponse,
      ),

      const ManageScreen(),
    ];

    return Scaffold(

      backgroundColor: const Color(0xFFF9FBFF),

      body: screens[_selectedIndex],

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

  final HomeResponse? homeResponse;

  const HomeContent({
    super.key,
    required this.homeResponse,
  });

  Text getGreeting() {

    final hour =
        DateTime.now().hour;

    if (hour < 12) {
      return Text(
        homeResponse?.heroBanner.title ?? "",

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
    final sortedSections =
    (homeResponse?.sections ?? [])

        .toList()

      ..sort(
            (a, b) =>
            a.displayOrder.compareTo(
              b.displayOrder,
            ),
      );

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

                            Text(
                              homeResponse?.header.schoolName ?? "",

                              style: TextStyle(
                                fontSize: 18,
                                fontWeight:
                                FontWeight.w700,

                                color:
                                Color(0xFF081B5C),
                              ),
                            ),

                            Text(
                              homeResponse?.header.screenTitle ?? "",

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
                        const SizedBox(height: 10),
                        getGreeting(),

                        const SizedBox(height: 15),

                        Text(
                          homeResponse?.heroBanner.subtitle ?? "",

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

              /// GRID
              Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [
                  ...sortedSections.map(

                        (section) {

                      /// OVERVIEW CARDS
                      if (section.sectionType ==
                          "OVERVIEW_CARDS") {

                        return Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [
                             Text(
                              section.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF081B5C),
                              ),
                            ),

                            GridView.builder(

                              shrinkWrap: true,

                              physics:
                              const NeverScrollableScrollPhysics(),

                              itemCount:
                              section.items.length,

                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(

                                crossAxisCount: 2,

                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,

                                mainAxisExtent: 180,
                              ),

                              itemBuilder: (context, index) {

                                final card =
                                section.items[index];

                                return _buildOverviewCard(

                                  width: width,

                                  bgColor:
                                  _hexToColor(
                                    card.bgColor,
                                  ),

                                  iconColor:
                                  _hexToColor(
                                    card.iconColor,
                                  ),

                                  title:
                                  card.title,

                                  value:
                                  card.value,

                                  subtitle:
                                  card.subtitle,

                                  icon:
                                  _getIcon(
                                    card.icon,
                                  ),
                                );
                              },
                            ),

                            const SizedBox(height: 20),
                          ],
                        );
                      }
                      if (section.sectionType ==
                          "OVERVIEW_CARDS") {

                        return Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            Text(
                              section.title,

                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF081B5C),
                              ),
                            ),

                            const SizedBox(height: 14),

                            GridView.builder(

                              shrinkWrap: true,

                              physics:
                              const NeverScrollableScrollPhysics(),

                              itemCount:
                              section.items.length,

                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(

                                crossAxisCount: 2,

                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,

                                mainAxisExtent: 180,
                              ),

                              itemBuilder: (context, index) {

                                final card =
                                section.items[index];

                                return _buildOverviewCard(

                                  width: width,

                                  bgColor:
                                  _hexToColor(
                                    card.bgColor,
                                  ),

                                  iconColor:
                                  _hexToColor(
                                    card.iconColor,
                                  ),

                                  title:
                                  card.title,

                                  value:
                                  card.value,

                                  subtitle:
                                  card.subtitle,

                                  icon:
                                  _getIcon(
                                    card.icon,
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      }

                      else if (section.sectionType ==
                          "QUICK_ACTIONS") {

                        return Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            Text(
                              section.title,

                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF081B5C),
                              ),
                            ),

                            const SizedBox(height: 14),

                            GridView.builder(

                              shrinkWrap: true,

                              physics:
                              const NeverScrollableScrollPhysics(),

                              itemCount:
                              section.items.length,

                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(

                                crossAxisCount: 4,

                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,

                                mainAxisExtent: 90,
                              ),

                              itemBuilder: (context, index) {

                                final item =
                                section.items[index];

                                return Material(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24),
                                  elevation: 2,
                                  shadowColor: Colors.black.withOpacity(0.08),

                                  child: InkWell(

                                    borderRadius: BorderRadius.circular(24),

                                    onTapDown: (_) {
                                      HapticFeedback.lightImpact();
                                    },

                                    onTap: () {

                                      print("items");

                                      // TODO:
                                      // Navigate based on redirect_url
                                    },

                                    splashColor:
                                    AppColors.primaryBlue.withOpacity(0.15),

                                    highlightColor:
                                    AppColors.primaryBlue.withOpacity(0.08),

                                    child: Ink(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 2,
                                      ),

                                      decoration: BoxDecoration(
                                        color: AppColors.blueCard,

                                        borderRadius:
                                        BorderRadius.circular(24),

                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1.2,
                                        ),

                                        boxShadow: [

                                          BoxShadow(
                                            color:
                                            Colors.black.withOpacity(0.03),

                                            blurRadius: 8,

                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),

                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,

                                        children: [

                                          Icon(
                                            _getIcon(item.icon),

                                            color:
                                            AppColors.primaryBlue,

                                            size: 25,
                                          ),

                                          const SizedBox(height: 6),

                                          Text(
                                            item.title,

                                            textAlign: TextAlign.center,

                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.darkText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),

                            const SizedBox(height: 20),
                          ],
                        );
                      }
                      else if (section.sectionType ==
                          "MODULE_GRID") {

                        return Column(

                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            /// TITLE
                            Text(
                              section.title,

                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF081B5C),
                              ),
                            ),

                            const SizedBox(height: 4),

                            /// DESCRIPTION
                            Text(
                              section.description,

                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade600,
                              ),
                            ),

                            const SizedBox(height: 16),

                            GridView.builder(

                              shrinkWrap: true,

                              physics:
                              const NeverScrollableScrollPhysics(),

                              itemCount:
                              section.items.length,

                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(

                                crossAxisCount: 2,

                                crossAxisSpacing: 14,
                                mainAxisSpacing: 14,

                                mainAxisExtent: 135,
                              ),

                              itemBuilder: (context, index) {

                                final item =
                                section.items[index];

                                return Material(

                                  color: Colors.transparent,

                                  borderRadius:
                                  BorderRadius.circular(28),

                                  child: InkWell(

                                    borderRadius:
                                    BorderRadius.circular(28),

                                    splashColor:
                                    AppColors.primaryBlue.withOpacity(0.12),

                                    highlightColor:
                                    AppColors.primaryBlue.withOpacity(0.05),

                                    onTap: () {

                                      print(
                                        item.redirectUrl,
                                      );
                                    },

                                    child: Ink(

                                      padding:
                                      const EdgeInsets.all(16),

                                      decoration: BoxDecoration(

                                        color:
                                        _hexToColor(
                                          item.backgroundColor,
                                        ),

                                        borderRadius:
                                        BorderRadius.circular(28),
                                      ),

                                      child: Column(

                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                        children: [

                                          /// ICON
                                          Container(

                                            height: 48,
                                            width: 48,

                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                              BorderRadius.circular(16),
                                            ),

                                            child: Icon(

                                              _getIcon(
                                                item.icon,
                                              ),

                                              color:
                                              AppColors.primaryBlue,

                                              size: 24,
                                            ),
                                          ),

                                          const Spacer(),

                                          /// TITLE
                                          Text(
                                            item.title,

                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight:
                                              FontWeight.w700,
                                              color:
                                              Color(0xFF081B5C),
                                            ),
                                          ),
                                          SizedBox(height: 5.0),

                                          /// DESCRIPTION
                                          Text(
                                            item.description,

                                            maxLines: 2,
                                            overflow:
                                            TextOverflow.ellipsis,

                                            style: TextStyle(
                                              fontSize: 11,
                                              height: 1.4,
                                              fontWeight:
                                              FontWeight.w500,
                                              color:
                                              Colors.grey.shade700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),

                            const SizedBox(height: 22),
                          ],
                        );
                      }






                      /// FEE COLLECTION SECTION
                      else if (section.sectionType ==
                          "FEE_COLLECTION") {

                        final card =
                            section.items.first;

                        return Column(

                          children: [

                            _buildFeeCollectionCard(
                              width,
                              card,
                            ),

                            const SizedBox(height: 20),
                          ],
                        );
                      }

                      return const SizedBox.shrink();
                    },

                  ).toList(),

                ],
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

  Widget _buildFeeCollectionCard(
      double width,
      HomeCard card,
      ) {

    return Container(

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(

        color: _hexToColor(
          card.bgColor,
        ),

        borderRadius:
        BorderRadius.circular(28),
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

            children: [

              Text(
                card.title,

                style: TextStyle(
                  fontSize: width * 0.040,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF081B5C),
                ),
              ),

              Container(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(20),
                ),

                child: Text(
                  card.value,

                  style: TextStyle(
                    fontSize: width * 0.032,
                    fontWeight: FontWeight.w700,
                    color: _hexToColor(
                      card.iconColor,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          ClipRRect(
            borderRadius:
            BorderRadius.circular(20),

            child: LinearProgressIndicator(
              value: 0.68,
              minHeight: 12,
              backgroundColor:
              Colors.white,

              valueColor:
              AlwaysStoppedAnimation<Color>(
                _hexToColor(
                  card.iconColor,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          Text(
            card.subtitle,

            style: TextStyle(
              fontSize: width * 0.034,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF3B4260),
            ),
          ),
        ],
      ),
    );
  }
  IconData _getIcon(
      String iconName,
      ) {

    switch (iconName) {

      case "students":
        return Icons.groups_rounded;

      case "attendance":
        return Icons.fact_check_rounded;

      case "fees":
        return Icons.account_balance_wallet_rounded;

      case "exam":
        return Icons.description_rounded;

      case "teachers":
        return Icons.person;
      case "student_add":
        return Icons.person_add_alt_1_rounded;

      default:
        return Icons.dashboard_rounded;
    }
  }
  Color _hexToColor(
      String hexColor,
      ) {

    hexColor =hexColor.replaceAll("#", "");

    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }

    return Color(
      int.parse(
        hexColor,
        radix: 16,
      ),
    );
  }
}