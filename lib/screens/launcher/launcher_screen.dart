import 'dart:async';

import 'package:flutter/material.dart';
import 'package:school_management_app/core/utils/responsive.dart';

import '../../core/constants/app_colors.dart';
import '../../core/widgets/app_logo.dart';

import '../welcome/welcome_screen.dart';

import '../../models/bootstrap_response.dart';
import '../../services/bootstrap_service.dart.dart';


class LauncherScreen extends StatefulWidget {
  const LauncherScreen({super.key});

  @override
  State<LauncherScreen> createState() =>
      _LauncherScreenState();
}

class _LauncherScreenState
    extends State<LauncherScreen> {

  BootstrapResponse? bootstrapResponse;

  @override
  void initState() {
    super.initState();

    _loadBootstrapData();
  }

  Future<void> _loadBootstrapData() async {

    try {

      final response =
      await BootstrapService.getBootstrapData();

      bootstrapResponse = response;

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => WelcomeScreen(
            bootstrapResponse:
            bootstrapResponse!,
          ),
        ),
      );

    } catch (e) {

      debugPrint(
        "Bootstrap API Error : $e",
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth =
        MediaQuery.of(context).size.width;
    final isWeb =
    Responsive.isDesktop(context);

    final contentWidth =
    Responsive.contentWidth(context);

    final height =
        MediaQuery.of(context).size.height;

    return Scaffold(

      backgroundColor:
      const Color(0xFFF9FBFF),

      body: Stack(

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

          /// RIGHT SIDE CIRCLE
          Positioned(
            top: height * 0.18,
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

          if (Responsive.isDesktop(context))
            Positioned.fill(
              child: Row(
                children: [

                  Expanded(
                    child: Container(
                      color: const Color(0xFFF5F8FF),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

          /// MAIN CONTENT
          Center(
            child: Container(
              width: contentWidth,
              padding:
              const EdgeInsets.symmetric(
                horizontal: 24,
              ),

              child: SizedBox(
                height: isWeb
                    ? height * 0.92
                    : height,

                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [

                    SizedBox(
                      height: isWeb
                          ? 40
                          : height * 0.12,
                    ),

                    /// LOGO
                    AppLogo(
                      size: isWeb
                          ? 140
                          : contentWidth * 0.34,
                    ),

                    SizedBox(
                      height: isWeb ? 10 : height * 0.025,
                    ),

                    /// SCHOOL NAME
                    Text(
                      "Sunshine",

                      style: TextStyle(
                        fontSize:
                        isWeb
                            ? 42
                            : contentWidth * 0.09,

                        fontWeight:
                        FontWeight.w700,

                        color:
                        const Color(
                            0xFF081B5C),

                        height: 1,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "Public School",

                      style: TextStyle(
                        fontSize:
                        contentWidth  * 0.09,

                        fontWeight:
                        FontWeight.w700,

                        color:
                        AppColors.primaryBlue,

                        height: 1,
                      ),
                    ),

                    SizedBox(
                      height: isWeb ? 8 : height * 0.018,
                    ),

                    /// TAGLINE
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .center,

                      children: [

                        Container(
                          width:
                          contentWidth  * 0.12,

                          height: 2,

                          color:
                          AppColors.primaryBlue,
                        ),

                        SizedBox(
                          width:
                          contentWidth  * 0.03,
                        ),

                        Text(
                          "LEARN • GROW • SUCCEED",

                          style: TextStyle(
                            fontSize:
                            contentWidth  * 0.034,

                            fontWeight:
                            FontWeight.w700,

                            letterSpacing: 1,

                            color:
                            const Color(
                                0xFF081B5C),
                          ),
                        ),

                        SizedBox(
                          width:
                          contentWidth  * 0.03,
                        ),

                        Container(
                          width:
                          contentWidth  * 0.12,

                          height: 2,

                          color:
                          AppColors.primaryBlue,
                        ),
                      ],
                    ),

                    /// SCHOOL BUILDING
                    Expanded(
                      child: Opacity(
                        opacity: 0.10,
                      
                        child: Image.asset(
                          "assets/images/school_building.png",
                      
                          width: isWeb
                              ? 320
                              : contentWidth * 0.78,
                      
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),



                    /// LOADING
                    Column(
                      children: [

                        SizedBox(
                          height:
                          Responsive.isDesktop(context)
                              ? 36
                              : contentWidth * 0.08,

                          width:
                          Responsive.isDesktop(context)
                              ? 36
                              : contentWidth * 0.08,

                          child:
                          CircularProgressIndicator(
                            strokeWidth: 4,
                            color:
                            AppColors.primaryBlue,
                          ),
                        ),

                        SizedBox(
                          height:
                          height * 0.018,
                        ),

                        Text(
                          "Loading...",

                          style: TextStyle(
                            fontSize:
                            contentWidth  * 0.045,

                            fontWeight:
                            FontWeight.w500,

                            color:
                            const Color(
                                0xFF3B4260),
                          ),
                        ),
                        SizedBox(
                          height:
                          height * 0.050,
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}