// ignore_for_file: constant_identifier_names

import 'package:bematched/config.dart';

class AppColors {
  static const Color themeColor = Color(0xFFEB4887);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const LOCATION_COLOR = Color(0xff7900FD);
  static const WHITE = Color(0xffFFFFFF);
  static const SILICON_VELLEY = Color(0xffB984F4);
  static const BLACK = Color(0xff162534);
  static const DARK_BLUE = Color(0xff162534);
  static const GREY = Color(0xff8F8F8F);
  static const BACKGROUND_COLOR = Color(0xffF6F5F6);
}

class AppLanguage extends Translations {
  static const appName = 'BeMatch';
  static const welcomeTo = 'Welcome to';
  static const welcomeToDescription =
      'Connecting Mongolians, One Swipe at a Time!';
  static const start = 'Start';
  static const LOGIN = 'Login';

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          appName: appName,
        },
      };
}

class AppFonts {
  static const INTER_BLACK = 'Inter-Black';
  static const INTER_BOLD = 'Inter-Bold';
  static const INTER_EXTRABOLD = 'Inter-ExtraBold';
  static const INTER_EXTRALIGHT = 'Inter-ExtraLight';
  static const INTER_LIGHT = 'Inter-Light';
  static const INTER_MEDIUM = 'Inter-Medium';
  static const INTER_REGULAR = 'Inter-Regular';
  static const INTER_SEMIBOLD = 'Inter-SemiBold';
  static const INTER_THIN = 'Inter-Thin';
}

const LANGLIST = [
  "Afrikaans",
  "Arabic",
  "Azeri",
  "Belarusian",
  "Bosnian",
  "Catalan",
  "Czech",
  "Welsh",
  "Danish",
  "German",
  "Divehi",
  "Greek",
  "English",
  "Esperanto",
  "Spanish",
  "Estonian",
  "Basque",
  "Farsi",
  "Finnish",
  "Faroese",
  "French",
  "Galician",
  "Gujarati",
  "Hebrew",
  "Hindi",
  "Croatian",
  "Hungarian",
  "Armenian",
  "Indonesian",
  "Icelandic",
  "Italian",
  "Japanese",
  "Georgian",
  "Kazakh",
  "Korean",
  "Konkani",
  "Kyrgyz",
  "Lithuanian",
  "Latvian",
  "Maori",
  "FYRO Macedonian",
  "Mongolian",
  "Marathi",
  "Malay",
  "Maltese",
  "Norwegian (Bokm?l)",
  "Dutch",
  "Norwegian (Nynorsk) (Norway)",
  "Northern Sotho",
  "Punjabi",
  "Polish",
  "Pashto",
  "Quechua",
  "Romanian",
  "Russian",
  "Sanskrit",
  "Sami (Northern)",
  "Slovak",
  "Slovenian",
  "Albanian",
  "Serbian ",
  "Swedish",
  "Swahili",
  "Syriac",
  "Tamil",
  "Telugu",
  "Thai",
  "Tagalog",
  "Tswana",
  "Turkish",
  "Tatar",
  "Tsonga",
  "Ukrainian",
  "Urdu",
  "Uzbek (Latin)",
  "Vietnamese",
  "Xhosa",
  "Chinese",
  "Zulu",
];

const List<Map<String, dynamic>> interests = <Map<String, dynamic>>[
  <String, dynamic>{
    'icon': Icons.photo_camera_outlined,
    'text': 'Photography',
  },
  <String, dynamic>{
    'icon': Icons.shopping_bag_outlined,
    'text': 'Shopping',
  },
  <String, dynamic>{
    'icon': Icons.mic_none_outlined,
    'text': 'Karaoke',
  },
  <String, dynamic>{
    'icon': Icons.more_horiz,
    'text': 'Yoga',
  },
  <String, dynamic>{
    'icon': Icons.cookie,
    'text': 'Cooking',
  },
  <String, dynamic>{
    'icon': Icons.more_horiz,
    'text': 'Tennis',
  },
  <String, dynamic>{
    'icon': Icons.run_circle,
    'text': 'Run',
  },
  <String, dynamic>{
    'icon': Icons.waves,
    'text': 'Swimming',
  },
  <String, dynamic>{
    'icon': Icons.art_track,
    'text': 'Art',
  },
  <String, dynamic>{
    'icon': Icons.travel_explore,
    'text': 'Travelling',
  },
  <String, dynamic>{
    'icon': Icons.more_horiz,
    'text': 'Extreme',
  },
  <String, dynamic>{
    'icon': Icons.queue_music,
    'text': 'Music',
  },
  <String, dynamic>{
    'icon': Icons.wine_bar_outlined,
    'text': 'Drink',
  },
  <String, dynamic>{
    'icon': Icons.videogame_asset,
    'text': 'Video games',
  },
];

List connectionList = [
  {'title': 'DATE', 'des': 'Make moves to find that spark'},
  {'title': 'BFF', 'des': 'Make friend and find community'},
  {'title': 'BIZZ', 'des': 'Move your career forward'}
];

enum Choice { Yes, No }

enum RelationStatus { Single, Married }

enum ChatStatus { offline, online, typing }

enum ZodiacSigns {
  Aries,
  Taurus,
  Gemini,
  Cancer,
  Leo,
  Virgo,
  Libra,
  Scorpio,
  Sagittarius,
  Capricorn,
  Aquarius,
  Pisces
}

class ImageAssets {
  static const splashLogo = 'assets/images/splash_logo.png';
  static const logo = 'assets/images/logo.png';
  static const homeBG = 'assets/images/home_bg.png';
  static const GIRL_IMAGE = 'assets/images/girl_image.png';
  static const MATCH_IMAGE = 'assets/images/match.png';
  static const KEEP_DATING = 'assets/images/keep_dating.png';
  static const DUMY_IMAGE = 'assets/images/dumy_image.png';
  static const DUMY_IMAGE1 = 'assets/images/dumy_image1.png';
  static const SELFIE_WITH_TWO_FINGERS =
      'assets/images/selfie_with_two_fingers.jpg';
  static const PERSONAL_HEART_ICON = 'assets/images/personal_heart_icon.png';
  static const ANIMATION = 'assets/images/animation.json';
  static const LOCATION = 'assets/images/location.json';
}

class SvgAssets {
  static const FACEBOOK_ICON = 'assets/svgs/facebook_icon.svg';
  static const GOOGLE_ICON = 'assets/svgs/google_icon.svg';
  static const SEARCH_ICON = 'assets/svgs/search_icon.svg';
  static const BELL_ICON = 'assets/svgs/bell_icon.svg';
  static const LIKE_ICON = 'assets/svgs/like_icon.svg';
  static const COMMENT_ICON = 'assets/svgs/comment_icon.svg';
  static const LIST_ICON = 'assets/svgs/list_icon.svg';
  static const FILTER_ICON = 'assets/svgs/filter_icon.svg';
  static const DATE_LIKE_ICON = 'assets/svgs/date_like_icon.svg';

  static const SELECTED_HOME_ICON = 'assets/svgs/selected_home_icon.svg';
  static const UNSELECTED_HOME_ICON = 'assets/svgs/unselected_home_icon.svg';

  static const SELECTED_HEART_ICON = 'assets/svgs/selected_heart_icon.svg';
  static const UNSELECTED_HEART_ICON = 'assets/svgs/unselected_heart_icon.svg';

  static const SELECTED_CHAT_ICON = 'assets/svgs/selected_chat_icon.svg';
  static const UNSELECTED_CHAT_ICON = 'assets/svgs/unselected_chat_icon.svg';

  static const ADD_ICON = 'assets/svgs/add_icon.svg';

  static const PROFILE_ICON = 'assets/svgs/profile_icon.svg';
  static const SELECTED_PROFILE_ICON = 'assets/svgs/selected_profile_icon.svg';
  static const VIDEO_CALL_ICON = 'assets/svgs/video_icon.svg';
  static const AUDIO_CALL_ICON = 'assets/svgs/audio_call_icon.svg';
  static const CHAT_LIST_ICON = 'assets/svgs/chat_list_icon.svg';
  static const EMOJI_ICON = 'assets/svgs/emoji_icon.svg';
  static const SEND_ICON = 'assets/svgs/send_icon.svg';
  static const CAMERA_ICON = 'assets/svgs/camera_icon.svg';
  static const CLOSE_ICON = 'assets/svgs/close_icon.svg';
  static const STAR_ICON = 'assets/svgs/star_icon.svg';
  static const MESSAGE_ICON = 'assets/svgs/message_icon.svg';
  static const DOWN_ARROW_ICON = 'assets/svgs/down_arrow_icon.svg';
  static const CALENDER_ICON = 'assets/svgs/calender_icon.svg';
  static const SETTING_ICON = 'assets/svgs/setting_icon.svg';
  static const ARCHIVE_ICON = 'assets/svgs/archive_icon.svg';
  static const ATTACH_ICON = 'assets/svgs/attach_icon.svg';
  static const LOGOUT_ICON = 'assets/svgs/logout_icon.svg';

  static const ACCOUNT_ICON = 'assets/svgs/account_icon.svg';
  static const CONNECTION_ICON = 'assets/svgs/connection_icon.svg';
  static const NOTIFICATION_ICON = 'assets/svgs/notification_icon.svg';
  static const VIP_ICON = 'assets/svgs/vip_icon.svg';
  static const PAYMENT_ICON = 'assets/svgs/payment_icon.svg';
  static const DELETE_ICON = 'assets/svgs/delete_icon.svg';
  static const HELP_ICON = 'assets/svgs/help_icon.svg';
  static const TERM_ICON = 'assets/svgs/term_icon.svg';
  static const PRIVACY_ICON = 'assets/svgs/privacy_icon.svg';

  static const PACKAGE_STAR_ICON = 'assets/svgs/star_package_icon.svg';
  static const DAIMOND_ICON = 'assets/svgs/daimond_icon.svg';
  static const CROWN_ICON = 'assets/svgs/crown_icon.svg';
  static const SAFETY_ICON = 'assets/svgs/safety.svg';

  static const PERSONAL_LIKE_ICON = 'assets/svgs/personal_like_icon.svg';
  static const PERSONAL_COMMENT_ICON = 'assets/svgs/personal_comment_icon.svg';
}
