import 'package:flutter/material.dart';

import '../../core/widgets/responsive_page.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/custom_button.dart';

import '../../models/bootstrap_response.dart';

import '../login/login_screen.dart';

class WelcomeScreen extends StatefulWidget {

  final BootstrapResponse
  bootstrapResponse;

  const WelcomeScreen({
    super.key,
    required this.bootstrapResponse,
  });

  @override
  State<WelcomeScreen> createState() =>
      _WelcomeScreenState();
}

class _WelcomeScreenState
    extends State<WelcomeScreen> {

  @override
  Widget build(BuildContext context) {

    final width =
        MediaQuery.of(context).size.width;

    final height =
        MediaQuery.of(context).size.height;

    return Scaffold(

      backgroundColor:
      const Color(0xFFF9FBFF),

      body: ResponsivePage(

        child: Stack(

          children: [

            /// TOP LEFT CIRCLE
            Positioned(
              top: -120,
              left: -120,

              child: Container(
                height: 260,
                width: 260,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  color:
                  AppColors.primaryBlue
                      .withOpacity(0.05),
                ),
              ),
            ),

            /// TOP RIGHT DOTS
            Positioned(
              top: 80,
              right: 28,

              child: Column(
                children: List.generate(
                  4,

                      (row) => Row(
                    children: List.generate(
                      4,

                          (col) => Container(
                        margin:
                        const EdgeInsets.all(4),

                        height: 4,
                        width: 4,

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          color:
                          AppColors.primaryBlue
                              .withOpacity(0.22),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            /// RIGHT CIRCLE
            Positioned(
              top: height * 0.32,
              right: -100,

              child: Container(
                height: 220,
                width: 220,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  color:
                  AppColors.primaryBlue
                      .withOpacity(0.04),
                ),
              ),
            ),

            /// MAIN CONTENT
            Padding(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 24,
              ),

              child: Column(

                children: [

                  SizedBox(
                    height: height * 0.10,
                  ),

                  /// TITLE
                  Text(
                    "Welcome to",

                    style: TextStyle(
                      fontSize: 18,

                      fontWeight:
                      FontWeight.w600,

                      color:
                      AppColors.darkText,
                    ),
                  ),

                  SizedBox(
                    height: height * 0.01,
                  ),

                  /// SCHOOL NAME
                  Text(
                    widget.bootstrapResponse
                        .schoolName,

                    textAlign:
                    TextAlign.center,

                    style: TextStyle(
                      fontSize:
                      width * 0.07,

                      fontWeight:
                      FontWeight.w700,

                      height: 1.1,

                      color:
                      const Color(
                          0xFF2457FF),
                    ),
                  ),

                  SizedBox(
                    height: height * 0.01,
                  ),

                  /// SUBTITLE
                  Text(
                    widget.bootstrapResponse
                        .welcomeScreen
                        .subtitle,

                    textAlign:
                    TextAlign.center,

                    style: TextStyle(
                      fontSize:
                      width * 0.042,

                      fontWeight:
                      FontWeight.w500,

                      color:
                      AppColors.lightText,
                    ),
                  ),

                  SizedBox(
                    height: height * 0.035,
                  ),

                  /// BUILDING
                  Expanded(
                    child: Center(

                      child: Opacity(
                        opacity: 0.92,

                        child: Image.asset(
                          'assets/images/school_building.png',

                          width: width * 0.80,

                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),

                  /// FEATURES CARD
                  Container(
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 22,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius:
                      BorderRadius.circular(30),

                      boxShadow: [
                        BoxShadow(
                          color:
                          Colors.black.withOpacity(
                              0.03),

                          blurRadius: 20,

                          offset:
                          const Offset(0, 8),
                        ),
                      ],
                    ),

                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                      children:

                      widget.bootstrapResponse
                          .welcomeScreen
                          .carouselBanners
                          .map(
                            (banner) => Expanded(

                          child: _buildFeature(
                            width: width,

                            icon:
                            getIcon(
                              banner.iconUrl,
                            ),

                            iconColor:
                            hexToColor(
                              banner.iconColor,
                            ),

                            iconBgColor:
                            hexToColor(
                              banner.iconBgColor,
                            ),

                            title:
                            banner.title,

                            subtitle:
                            banner.subtitle,

                            titleColor:
                            hexToColor(
                              banner.iconColor,
                            ),

                            subtitleColor:
                            hexToColor(
                              banner.subtitleColor,
                            ),
                          ),
                        ),
                      )

                          .toList(),
                    ),
                  ),

                  SizedBox(
                    height: height * 0.02,
                  ),

                  /// PAGE INDICATOR
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,

                    children: [

                      _dot(true),
                      _dot(false),
                      _dot(false),
                      _dot(false),
                    ],
                  ),

                  SizedBox(
                    height: height * 0.025,
                  ),

                  /// BUTTON
                  CustomButton(

                    title:
                    widget.bootstrapResponse
                        .welcomeScreen
                        .buttonText,

                    onTap: () {

                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (_) => LoginScreen(
                            bootstrapResponse:
                            widget.bootstrapResponse,
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(
                    height: height * 0.03,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature({

    required double width,

    required IconData icon,

    required Color iconColor,

    required Color iconBgColor,

    required String title,

    required String subtitle,

    required Color titleColor,

    required Color subtitleColor,
  }) {

    return Column(

      children: [

        Container(
          height: width * 0.12,
          width: width * 0.12,

          decoration: BoxDecoration(
            color: iconBgColor,
            shape: BoxShape.circle,
          ),

          child: Icon(
            icon,

            color: iconColor,

            size: width * 0.080,
          ),
        ),

        SizedBox(
          height: width * 0.015,
        ),

        Text(
          title,

          style: TextStyle(
            fontSize: width * 0.040,
            fontWeight: FontWeight.w700,
            color: titleColor,
          ),
        ),

        SizedBox(
          height: width * 0.01,
        ),

        Text(
          subtitle,

          textAlign: TextAlign.center,

          style: TextStyle(
            fontSize: width * 0.028,
            fontWeight: FontWeight.bold,
            color: subtitleColor,
          ),
        ),
      ],
    );
  }

  Widget _dot(bool active) {

    return Container(
      margin:
      const EdgeInsets.symmetric(
          horizontal: 4),

      height: 10,
      width: active ? 24 : 10,

      decoration: BoxDecoration(
        color: active
            ? AppColors.primaryBlue
            : Colors.grey.shade300,

        borderRadius:
        BorderRadius.circular(20),
      ),
    );
  }

  Color hexToColor(String hex) {

    hex = hex.replaceAll("#", "");

    if (hex.length == 6) {
      hex = "FF$hex";
    }

    return Color(
      int.parse(hex, radix: 16),
    );
  }

  IconData getIcon(String iconName) {

    switch (iconName) {

      case "Icons.school_rounded":
        return Icons.school_rounded;

      case "Icons.menu_book_rounded":
        return Icons.menu_book_rounded;

      case "Icons.lightbulb_rounded":
        return Icons.lightbulb_rounded;

      case "Icons.groups_rounded":
        return Icons.groups_rounded;

      default:
        return Icons.star_rounded;
    }
  }
}