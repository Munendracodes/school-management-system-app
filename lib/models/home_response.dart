class HomeResponse {

  final HeaderData header;

  final HeroBanner heroBanner;

  final List<HomeSection> sections;

  HomeResponse({
    required this.header,
    required this.heroBanner,
    required this.sections,
  });

  factory HomeResponse.fromJson(
      Map<String, dynamic> json,
      ) {

    return HomeResponse(
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

          .map(
            (e) => HomeSection.fromJson(e),
      )

          .toList(),
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
      ) {

    return HomeSection(

      sectionType:
      json["section_type"] ?? "",

      title:
      json["title"] ?? "",

      description:
      json["description"] ?? "",

      displayOrder:
      json["display_order"] ?? 0,

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

final String bgColor;

final String backgroundColor;

final String redirectUrl;

final String moduleType;

HomeCard({

required this.title,

required this.value,

required this.subtitle,

required this.description,

required this.icon,

required this.iconColor,

required this.bgColor,

required this.backgroundColor,

required this.redirectUrl,

required this.moduleType,
});

factory HomeCard.fromJson(
Map<String, dynamic> json,
) {

return HomeCard(

title:
json["title"] ?? "",

value:
json["value"]?.toString() ?? "",

subtitle:
json["subtitle"] ?? "",

description:
json["description"] ?? "",

icon:
json["icon"] ?? "",

iconColor:
json["icon_color"] ??
"#2457FF",

bgColor:
json["bg_color"] ??
"#F5F7FF",

backgroundColor:
json["background_color"] ??
"#F5F7FF",

redirectUrl:
json["redirect_url"] ?? "",

moduleType:
json["module_type"] ?? "",
);
}
}