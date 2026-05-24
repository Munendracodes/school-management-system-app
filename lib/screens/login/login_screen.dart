import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/custom_button.dart';
import '../../models/bootstrap_response.dart';
import '../../services/home_service.dart';
import '../home/home_screen.dart';
import '../../core/widgets/app_logo.dart';
import '../../models/login_request.dart';
import '../../models/login_response.dart';

import '../../services/login_service.dart';
class LoginScreen extends StatefulWidget {
  final BootstrapResponse
  bootstrapResponse;

  const LoginScreen({
    super.key,
    required this.bootstrapResponse,
  });

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final TextEditingController mobileController =
  TextEditingController();

  final TextEditingController mpinController =
  TextEditingController();

  bool obscureMpin = true;
  bool rememberMe = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    final width =
        MediaQuery.of(context).size.width;

    final height =
        MediaQuery.of(context).size.height;
    final loginData =
        widget.bootstrapResponse.loginScreen;

    return Scaffold(

      backgroundColor: const Color(0xFFF9FBFF),
      resizeToAvoidBottomInset: true,

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
            top: height * 0.30,
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
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),

            child: SingleChildScrollView(

              keyboardDismissBehavior:
              ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(

                children: [

                  SizedBox(
                    height: height * 0.05,
                  ),

                  /// LOGO
                AppLogo(
                    size: width * 0.24,
                  ),


                  SizedBox(
                    height: height * 0.012,
                  ),

                  /// SCHOOL NAME
                  Text(
                    widget.bootstrapResponse
                        .schoolName
                        .split(" ")
                        .first,

                    style: TextStyle(
                      fontSize: width * 0.075,
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
                    widget.bootstrapResponse
                        .schoolName
                        .replaceFirst(
                      "${widget.bootstrapResponse.schoolName.split(" ").first} ",
                      "",
                    ),

                    style: TextStyle(
                      fontSize: width * 0.075,
                      fontWeight:
                      FontWeight.w700,
                      color:
                      AppColors.primaryBlue,
                      height: 1,
                    ),
                  ),

                  SizedBox(
                    height: height * 0.012,
                  ),

                  /// TAGLINE
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .center,

                    children: [

                      Container(
                        width: width * 0.08,
                        height: 2,
                        color:
                        AppColors.primaryBlue,
                      ),

                      SizedBox(
                        width: width * 0.03,
                      ),

                      Text(
                        widget.bootstrapResponse.tagLine,

                        style: TextStyle(
                          fontSize:
                          width * 0.028,

                          fontWeight:
                          FontWeight.w700,

                          letterSpacing: 1,

                          color:
                          const Color(
                              0xFF081B5C),
                        ),
                      ),

                      SizedBox(
                        width: width * 0.015,
                      ),

                      Container(
                        width: width * 0.08,
                        height: 2,
                        color:
                        AppColors.primaryBlue,
                      ),
                    ],
                  ),

                  SizedBox(
                    height: height * 0.008,
                  ),


                  /// BUILDING
                  SizedBox(
                    height: height * 0.24,

                    child: Center(
                      child: Opacity(
                        opacity: 0.95,

                        child: Image.asset(
                          "assets/images/school_building.png",

                          width: width * 0.78,

                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                  /// LOGIN CARD
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.050,
                      vertical: height * 0.010,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                        BorderRadius.circular(22),

                      boxShadow: [
                        BoxShadow(
                          color:
                          Colors.black
                              .withOpacity(
                              0.03),

                          blurRadius: 14,

                          offset:
                          const Offset(0, 8),
                        ),
                      ],
                    ),

                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [

                        Text(
                          loginData.welcomeTitle,

                          style: TextStyle(
                            fontSize:
                            width * 0.05,

                            fontWeight:
                            FontWeight.w700,

                            color:
                            const Color(
                                0xFF081B5C),
                          ),
                        ),

                        SizedBox(
                          height: height * 0.004,
                        ),

                        Text(
                          loginData.welcomeSubtitle,

                          style: TextStyle(
                            fontSize:
                            width * 0.034,

                            fontWeight:
                            FontWeight.w500,

                            color:
                            AppColors.lightText,
                          ),
                        ),

                        SizedBox(
                          height: height * 0.022,
                        ),

                        _buildInputField(
                          width: width,
                          icon:
                          Icons.phone_android_rounded,
                          title:
                          loginData.mobileNumberLabel,
                          hint:
                          loginData.mobileNumberPlaceholder,
                          controller:
                          mobileController,
                        ),

                        SizedBox(
                          height: height * 0.010,
                        ),

                        _buildInputField(
                          width: width,
                          icon:
                          Icons.lock_rounded,
                          title: loginData.mpinLabel,
                          hint:
                          loginData.mpinPlaceholder,
                          controller:
                          mpinController,
                          isPassword: true,
                        ),

                        SizedBox(
                          height: height * 0.018,
                        ),

                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,

                          children: [

                            Row(
                              children: [

                                GestureDetector(
                                  onTap: () {

                                    setState(() {
                                      rememberMe =
                                      !rememberMe;
                                    });
                                  },

                                  child: Container(
                                    height: 22,
                                    width: 22,

                                    decoration:
                                    BoxDecoration(
                                      color: rememberMe
                                          ? AppColors
                                          .primaryBlue
                                          : Colors
                                          .white,

                                      borderRadius:
                                      BorderRadius.circular(
                                          6),

                                      border:
                                      Border.all(
                                        color:
                                        AppColors.primaryBlue,
                                      ),
                                    ),

                                    child: rememberMe
                                        ? const Icon(
                                      Icons
                                          .check,
                                      color: Colors
                                          .white,
                                      size: 14,
                                    )
                                        : null,
                                  ),
                                ),

                                SizedBox(
                                  width:
                                  width * 0.025,
                                ),

                                Text(
                                  loginData.rememberMeText,

                                  style:
                                  TextStyle(
                                    fontSize:
                                    width *
                                        0.032,

                                    fontWeight:
                                    FontWeight
                                        .w500,

                                    color:
                                    const Color(
                                        0xFF3B4260),
                                  ),
                                ),
                              ],
                            ),

                            Text(
                              loginData.forgotMpinText,

                              style: TextStyle(
                                fontSize:
                                width *
                                    0.032,

                                fontWeight:
                                FontWeight
                                    .w600,

                                color: AppColors
                                    .primaryBlue,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: height * 0.015,
                        ),
                        isLoading

                            ? const Center(
                          child:
                          CircularProgressIndicator(),
                        )

                            : CustomButton(
                          title: loginData.loginButtonText,

                          onTap: () async {

                            setState(() {
                              isLoading = true;
                            });

                            try {

                              final loginResponse =
                              await LoginService.login(
                                request: LoginRequest(
                                  mobileNumber:
                                  mobileController.text,

                                  password:
                                  mpinController.text,
                                ),
                              );

                              /// CALL HOME API
                              final homeResponse =
                              await HomeService.getHomeData(

                                accessToken:
                                loginResponse.accessToken,
                              );

                              if (!mounted) return;

                              Navigator.pushReplacement(

                                context,

                                MaterialPageRoute(

                                  builder: (_) => HomeScreen(

                                    accessToken:
                                    loginResponse.accessToken,

                                    homeResponse:
                                    homeResponse,

                                    userName:
                                    loginResponse.user.fullName,

                                    role:
                                    loginResponse.user.role,
                                  ),
                                ),
                              );

                            } catch (e) {

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(

                                SnackBar(
                                  content:
                                  Text(e.toString()),
                                ),
                              );
                            }

                            finally {

                              if (mounted) {

                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: height * 0.02,
                  ),

                  /// FOOTER
                  RichText(
                    textAlign: TextAlign.center,

                    text: TextSpan(
                      children: [

                        TextSpan(
                          text: loginData.footerText,

                          style: TextStyle(
                            fontSize:
                            width * 0.03,

                            fontWeight:
                            FontWeight.w500,

                            color:
                            AppColors.lightText,
                          ),
                        ),

                        TextSpan(
                          text:
                          loginData.footerHighlightText,

                          style: TextStyle(
                            fontSize:
                            width * 0.03,

                            fontWeight:
                            FontWeight.w600,

                            color: AppColors
                                .primaryBlue,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: height * 0.02,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required double width,
    required IconData icon,
    required String title,
    required String hint,
    required TextEditingController controller,
    bool isPassword = false,
  }) {

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),

        border: Border.all(
          color: const Color(0xFFE2E8F5),
        ),
      ),

      child: Row(
        children: [

          Container(
            height: width * 0.09,
            width: width * 0.09,

            decoration: BoxDecoration(
              color: AppColors.blueCard,
              shape: BoxShape.circle,
            ),

            child: Icon(
              icon,
              color: AppColors.primaryBlue,
              size: width * 0.05,
            ),
          ),

          SizedBox(
            width: width * 0.035,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style: TextStyle(
                    fontSize: width * 0.032,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF3B4260),
                  ),
                ),

                SizedBox(
                  height: width * 0.012,
                ),

                TextField(
                  controller: controller,
                  maxLength: title == "Mobile Number" ? 10 : null,
                  keyboardType: TextInputType.number,
                  obscureText:
                  isPassword ? obscureMpin : false,

                  decoration: InputDecoration(
                    hintText: hint,
                    counterText: "",

                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,

                    isDense: true,
                    contentPadding: EdgeInsets.zero,

                    hintStyle: TextStyle(
                      fontSize: width * 0.04,
                      color: Colors.grey.shade400,
                    ),
                  ),

                  style: TextStyle(
                    fontSize: width * 0.035,
                    fontWeight: FontWeight.w500,
                    color:
                    const Color(0xFF081B5C),
                  ),
                ),
              ],
            ),
          ),

          if (isPassword)
            GestureDetector(
              onTap: () {

                setState(() {
                  obscureMpin = !obscureMpin;
                });
              },

              child: Icon(
                obscureMpin
                    ? Icons.visibility_outlined
                    : Icons
                    .visibility_off_outlined,

                color: Colors.grey.shade500,
                size: width * 0.05,
              ),
            ),
        ],
      ),
    );
  }
}