
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:happiness_meter/bloc_provider.dart';
import 'package:happiness_meter/global_translations.dart';
import 'package:happiness_meter/home_page.dart';
import 'package:intl/intl.dart';
import 'package:preferences/preference_service.dart';
import 'meter_page.dart';



// class DemoLocalizations {
//   DemoLocalizations(this.locale);

//   final Locale locale;

//   static DemoLocalizations of(BuildContext context) {
//     return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
//   }

//   static Map<String, Map<String, String>> _localizedValues = {
//     'en': {
//       'title': 'Hello World',
//     },
//     'nl': {
//       'title': 'Hallo weldt',
//     },
//   };

//   String get title {
//     return _localizedValues[locale.languageCode]['title'];
//   }
// }

// class DemoLocalizationsDelegate extends LocalizationsDelegate<DemoLocalizations> {
//   const DemoLocalizationsDelegate();

//   @override
//   bool isSupported(Locale locale) => ['en', 'nl'].contains(locale.languageCode);

//   @override
//   Future<DemoLocalizations> load(Locale locale) {
//     // Returning a SynchronousFuture here because an async "load" operation
//     // isn't needed to produce an instance of DemoLocalizations.
//     return SynchronousFuture<DemoLocalizations>(DemoLocalizations(locale));
//   }

//   @override
//   bool shouldReload(DemoLocalizationsDelegate old) => false;
// }


// class Translations {
//   static Future<Translations> load(Locale locale) {
//     final String name =
//         locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
//     final String localeName = Intl.canonicalizedLocale(name);

//     return initializeMessages(localeName).then((bool _) {
//       Intl.defaultLocale = localeName;
//       return new Translations();
//     });
//   }

//   static Translations of(BuildContext context) {
//     return Localizations.of<Translations>(context, Translations);
//   }

//   String get title2 {
//     return Intl.message(
//       'Hello World',
//       name: 'title3',
//       desc: 'Title for the Demo application',
//     );
//   }
// }

// class TranslationsDelegate extends LocalizationsDelegate<Translations> {
//   const TranslationsDelegate();

//   @override
//   bool isSupported(Locale locale) => ['en', 'fr'].contains(locale.languageCode);

//   @override
//   Future<Translations> load(Locale locale) => Translations.load(locale);

//   @override
//   bool shouldReload(TranslationsDelegate old) => false;
// }

// class SpecifiedLocalizationDelegate
//     extends LocalizationsDelegate<Translations> {
//   final Locale overriddenLocale;

//   const SpecifiedLocalizationDelegate(this.overriddenLocale);

//   @override
//   bool isSupported(Locale locale) => overriddenLocale != null;

//   @override
//   Future<Translations> load(Locale locale) =>
//       Translations.load(overriddenLocale);

//   @override
//   bool shouldReload(SpecifiedLocalizationDelegate old) => true;
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await PrefService.init(prefix: 'pref_'); 
  await allTranslations.init();

runApp(MyApp());
}

class MyApp extends StatefulWidget {
   @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState  extends State<MyApp> {
   TranslationsBloc translationsBloc;

 @override
  void initState() {
    super.initState();
    translationsBloc = TranslationsBloc();
  }
   @override
  void dispose() {
    translationsBloc?.dispose();
    super.dispose();
  }
  
  //   onLocaleChange(Locale l) {
  //   setState(() {
  //     _localeOverrideDelegate = new SpecifiedLocalizationDelegate(l);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
      return BlocProvider<TranslationsBloc>(
      bloc: translationsBloc,
      child: StreamBuilder<Locale>(
        stream: translationsBloc.currentLocale,
        initialData: allTranslations.locale,
        builder: (BuildContext context, AsyncSnapshot<Locale> snapshot) {

    return MaterialApp(
      // onGenerateTitle: (BuildContext context) => DemoLocalizations.of(context).title,
    
locale: snapshot.data ?? allTranslations.locale,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: allTranslations.supportedLocales(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
      ),
        home: HomePage()
    );
  }
      ),
      );
  }
}