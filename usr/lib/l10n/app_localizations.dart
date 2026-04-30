import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = locale;

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  String get appTitle;
  String get homeTitle;
  String get favorites;
  String get genres;
  String get rating;
  String get episodes;
  String get status;
  String get releaseDate;
  String get synopsis;
  String get ongoing;
  String get completed;
  String get unknown;
  String get errorFetchingData;
  String get noFavoritesYet;
  String get removedFromFavorites;
  String get addedToFavorites;
  String get search;
  String get home;
  String get settings;
  String get language;
}

class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override String get appTitle => "Animeverse";
  @override String get homeTitle => "Trending Anime";
  @override String get favorites => "Favorites";
  @override String get genres => "Genres";
  @override String get rating => "Rating";
  @override String get episodes => "Episodes";
  @override String get status => "Status";
  @override String get releaseDate => "Release Date";
  @override String get synopsis => "Synopsis";
  @override String get ongoing => "Ongoing";
  @override String get completed => "Completed";
  @override String get unknown => "Unknown";
  @override String get errorFetchingData => "Error fetching data. Please try again.";
  @override String get noFavoritesYet => "No favorites yet.";
  @override String get removedFromFavorites => "Removed from favorites";
  @override String get addedToFavorites => "Added to favorites";
  @override String get search => "Search";
  @override String get home => "Home";
  @override String get settings => "Settings";
  @override String get language => "Language";
}

class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override String get appTitle => "عالم الأنمي";
  @override String get homeTitle => "الأنمي الشائع";
  @override String get favorites => "المفضلة";
  @override String get genres => "التصنيفات";
  @override String get rating => "التقييم";
  @override String get episodes => "الحلقات";
  @override String get status => "الحالة";
  @override String get releaseDate => "تاريخ الإصدار";
  @override String get synopsis => "القصة";
  @override String get ongoing => "مستمر";
  @override String get completed => "مكتمل";
  @override String get unknown => "غير معروف";
  @override String get errorFetchingData => "حدث خطأ في جلب البيانات. يرجى المحاولة مرة أخرى.";
  @override String get noFavoritesYet => "لا توجد مفضلة بعد.";
  @override String get removedFromFavorites => "تم الإزالة من المفضلة";
  @override String get addedToFavorites => "تم الإضافة إلى المفضلة";
  @override String get search => "بحث";
  @override String get home => "الرئيسية";
  @override String get settings => "الإعدادات";
  @override String get language => "اللغة";
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    switch (locale.languageCode) {
      case 'ar':
        return SynchronousFuture<AppLocalizations>(AppLocalizationsAr(locale.toString()));
      case 'en':
      default:
        return SynchronousFuture<AppLocalizations>(AppLocalizationsEn(locale.toString()));
    }
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
