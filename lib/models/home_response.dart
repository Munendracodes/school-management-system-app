class HomeResponse {

  final HeaderData header;

  final HeroBanner heroBanner;

  final List<HomeSection> sections;

  final UserData user;

  HomeResponse({
    required this.header,
    required this.heroBanner,
    required this.sections,
    required this.user
  });

  factory HomeResponse.fromJson(
      Map<String, dynamic> json,
      ) {

    return HomeResponse(
      user:
      UserData.fromJson(
        json["user"] ?? {},
      ),
      header:
      HeaderData.fromJson(
        json["header"] ?? {},
      ),

      heroBanner:
      HeroBanner.fromJson(
        json["hero_banner"] ?? {},
      ),

      sections:
      (json["sections"] as List? ?? [])

          .asMap()

          .entries

          .map(
            (entry) => HomeSection.fromJson(
          entry.value,
          entry.key,
        ),
      )

          .toList(),
    );
  }
}
class UserData {

  final String fullName;

  final String role;

  UserData({
    required this.fullName,
    required this.role,
  });

  factory UserData.fromJson(
      Map<String, dynamic> json,
      ) {

    return UserData(

      fullName:
      json["full_name"] ?? "",

      role:
      json["role"] ?? "",
    );
  }
}
class HeaderData {

  final String schoolName;

  final String schoolLogo;

  final String screenTitle;

  final int notificationCount;

  HeaderData({
    required this.schoolName,
    required this.schoolLogo,
    required this.screenTitle,
    required this.notificationCount,
  });

  factory HeaderData.fromJson(
      Map<String, dynamic> json,
      ) {

    return HeaderData(

      schoolName:
      json["school_name"] ?? "",

      schoolLogo:
      json["school_logo"] ?? "",

      screenTitle:
      json["screen_title"] ?? "",

      notificationCount:
      json["notification_count"] ?? 0,
    );
  }
}
class HeroBanner {

  final String title;

  final String subtitle;

  final String imageUrl;

  HeroBanner({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  factory HeroBanner.fromJson(
      Map<String, dynamic> json,
      ) {

    return HeroBanner(

      title:
      json["title"] ?? "",

      subtitle:
      json["subtitle"] ?? "",

      imageUrl:
      json["image_url"] ?? "",
    );
  }
}

class HomeSection {

  final String sectionType;

  final String title;

  final String description;

  final int displayOrder;

  final List<HomeCard> items;

  HomeSection({
    required this.sectionType,
    required this.title,
    required this.description,
    required this.displayOrder,
    required this.items,
  });

  factory HomeSection.fromJson(
      Map<String, dynamic> json,
      int index,
      ) {

    return HomeSection(

      sectionType:
      json["type"] ?? "",

      title:
      json["title"] ?? "",

      description:
      json["description"] ?? "",

     /* displayOrder:
      json["display_order"] ?? 0,*/
      displayOrder: index,

      items:
      (json["items"] as List? ?? [])

          .map(
            (e) => HomeCard.fromJson(e),
      )

          .toList(),
    );
  }
}

class HomeCard {

final String title;

final String value;

final String subtitle;

final String description;

final String icon;

final String iconColor;

final String backgroundColor;

final String redirectUrl;

final String moduleType;

final String mediaType;

final String mediaUrl;

final String ctaText;

final String textColor;

HomeCard({

required this.title,

required this.value,

required this.subtitle,

required this.description,

required this.icon,

required this.iconColor,

required this.backgroundColor,

required this.redirectUrl,

required this.moduleType,
  required this.mediaType,
  required this.mediaUrl,
  required this.ctaText,
  required this.textColor,
});

factory HomeCard.fromJson(
Map<String, dynamic> json,
) {

return HomeCard(

title:
json["title"] ?? "",

  value:
  json["value"] == null
      ? "0"
      : json["value"].toString(),

subtitle:
json["subtitle"] ?? "",

description:
json["description"] ?? "",

icon:
json["icon"] ?? "",

iconColor:
json["icon_color"] ??
"#2457FF",

backgroundColor:
json["background_color"] ??
"#F5F7FF",

redirectUrl:
json["redirect_url"] ?? "",

moduleType:
json["type"] ?? "",

  mediaType:
  json["media_type"] ?? "",

  mediaUrl:
  json["media_url"] ?? "",

  ctaText:
  json["cta_text"] ?? "",

  textColor:
  json["text_color"] ?? "#FFFFFF",
);
}
}