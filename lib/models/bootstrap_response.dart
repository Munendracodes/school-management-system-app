class BootstrapResponse {
  final String schoolName;
  final String tagLine;
  final String logoUrl;
  final String primaryColor;
  final String secondaryColor;

  final WelcomeScreenData welcomeScreen;
  final LoginScreenData loginScreen;

  BootstrapResponse({
    required this.schoolName,
    required this.tagLine,
    required this.logoUrl,
    required this.primaryColor,
    required this.secondaryColor,
    required this.welcomeScreen,
    required this.loginScreen,
  });

  factory BootstrapResponse.fromJson(
      Map<String, dynamic> json,
      ) {
    return BootstrapResponse(
      schoolName: json["school_name"] ?? "",
      tagLine: json["tag_line"] ?? "",
      logoUrl: json["logo_url"] ?? "",
      primaryColor: json["primary_color"] ?? "",
      secondaryColor: json["secondary_color"] ?? "",

      welcomeScreen: WelcomeScreenData.fromJson(
        json["welcome_screen"],
      ),
      loginScreen: LoginScreenData.fromJson(
        json["login_screen"],
      ),
    );
  }
}

class WelcomeScreenData {
  final String title;
  final String subtitle;
  final String buttonText;

  final List<CarouselBanner> carouselBanners;

  WelcomeScreenData({
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.carouselBanners,
  });

  factory WelcomeScreenData.fromJson(
      Map<String, dynamic> json,
      ) {
    return WelcomeScreenData(
      title: json["title"] ?? "",
      subtitle: json["subtitle"] ?? "",
      buttonText: json["button_text"] ?? "",

      carouselBanners:
      (json["carousel_banners"] as List)
          .map(
            (e) => CarouselBanner.fromJson(e),
      )
          .toList(),
    );
  }
}

class LoginScreenData {

  final String backgroundImageUrl;

  final String welcomeTitle;
  final String welcomeSubtitle;

  final String mobileNumberLabel;
  final String mobileNumberPlaceholder;

  final String mpinLabel;
  final String mpinPlaceholder;

  final String rememberMeText;
  final String forgotMpinText;

  final String loginButtonText;

  final String footerText;
  final String footerHighlightText;

  final bool showRememberMe;
  final bool showForgotMpin;

  LoginScreenData({
    required this.backgroundImageUrl,

    required this.welcomeTitle,
    required this.welcomeSubtitle,

    required this.mobileNumberLabel,
    required this.mobileNumberPlaceholder,

    required this.mpinLabel,
    required this.mpinPlaceholder,

    required this.rememberMeText,
    required this.forgotMpinText,

    required this.loginButtonText,

    required this.footerText,
    required this.footerHighlightText,

    required this.showRememberMe,
    required this.showForgotMpin,
  });

  factory LoginScreenData.fromJson(
      Map<String, dynamic> json,
      ) {

    return LoginScreenData(

      backgroundImageUrl:
      json["background_image_url"] ?? "",

      welcomeTitle:
      json["welcome_title"] ?? "",

      welcomeSubtitle:
      json["welcome_subtitle"] ?? "",

      mobileNumberLabel:
      json["mobile_number_label"] ?? "",

      mobileNumberPlaceholder:
      json["mobile_number_placeholder"] ?? "",

      mpinLabel:
      json["mpin_label"] ?? "",

      mpinPlaceholder:
      json["mpin_placeholder"] ?? "",

      rememberMeText:
      json["remember_me_text"] ?? "",

      forgotMpinText:
      json["forgot_mpin_text"] ?? "",

      loginButtonText:
      json["login_button_text"] ?? "",

      footerText:
      json["footer_text"] ?? "",

      footerHighlightText:
      json["footer_highlight_text"] ?? "",

      showRememberMe:
      json["show_remember_me"] ?? false,

      showForgotMpin:
      json["show_forgot_mpin"] ?? false,
    );
  }
}

class CarouselBanner {
  final String title;
  final String subtitle;

  final String iconUrl;

  final String iconColor;
  final String iconBgColor;
  final String titleColor;
  final String subtitleColor;

  CarouselBanner({
    required this.title,
    required this.subtitle,
    required this.iconUrl,
    required this.iconColor,
    required this.iconBgColor,
    required this.titleColor,
    required this.subtitleColor,
  });

  factory CarouselBanner.fromJson(
      Map<String, dynamic> json,
      ) {
    return CarouselBanner(
      title: json["title"] ?? "",
      subtitle: json["subtitle"] ?? "",
      iconUrl: json["icon_url"] ?? "",

      iconColor: json["icon_color"] ?? "",
      iconBgColor: json["icon_bgcolor"] ?? "",
      titleColor: json["title_color"] ?? "",
      subtitleColor:
      json["subtitle_color"] ?? "",
    );
  }
}