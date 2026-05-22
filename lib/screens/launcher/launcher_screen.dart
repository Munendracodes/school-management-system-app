import 'dart:async';

import 'package:flutter/material.dart';

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

    final width =
        MediaQuery.of(context).size.width;

    final height =
        MediaQuery.of(context).size.height;

    return Scaffold(

      backgroundColor:
      const Color(0xFFF9FBFF),

      body: SafeArea(

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

            /// MAIN CONTENT
            Padding(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 24,
              ),

              child: SizedBox(
                height: height,

                child: Column(

                  children: [

                    SizedBox(
                      height: height * 0.12,
                    ),

                    /// LOGO
                    AppLogo(
                      size: width * 0.34,
                    ),

                    SizedBox(
                      height: height * 0.025,
                    ),

                    /// SCHOOL NAME
                    Text(
                      "Sunshine",

                      style: TextStyle(
                        fontSize:
                        width * 0.09,

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
                        width * 0.09,

                        fontWeight:
                        FontWeight.w700,

                        color:
                        AppColors.primaryBlue,

                        height: 1,
                      ),
                    ),

                    SizedBox(
                      height: height * 0.018,
                    ),

                    /// TAGLINE
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .center,

                      children: [

                        Container(
                          width:
                          width * 0.12,

                          height: 2,

                          color:
                          AppColors.primaryBlue,
                        ),

                        SizedBox(
                          width:
                          width * 0.03,
                        ),

                        Text(
                          "LEARN • GROW • SUCCEED",

                          style: TextStyle(
                            fontSize:
                            width * 0.034,

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
                          width * 0.03,
                        ),

                        Container(
                          width:
                          width * 0.12,

                          height: 2,

                          color:
                          AppColors.primaryBlue,
                        ),
                      ],
                    ),

                    const Spacer(),

                    /// SCHOOL BUILDING
                    Opacity(
                      opacity: 0.10,

                      child: Image.asset(
                        "assets/images/school_building.png",

                        width: width * 0.78,

                        fit: BoxFit.contain,
                      ),
                    ),

                    SizedBox(
                      height: height * 0.04,
                    ),

                    /// LOADING
                    Column(
                      children: [

                        SizedBox(
                          height: width * 0.08,
                          width: width * 0.08,

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
                            width * 0.045,

                            fontWeight:
                            FontWeight.w500,

                            color:
                            const Color(
                                0xFF3B4260),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: height * 0.06,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}