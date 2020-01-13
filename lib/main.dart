
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:happiness_meter/bloc/bloc_provider.dart';
import 'package:happiness_meter/global_translations.dart';
import 'package:happiness_meter/screens/home_page.dart';
import 'package:intl/intl.dart';
import 'package:preferences/preference_service.dart';

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
  

  @override
  Widget build(BuildContext context) {
      return BlocProvider<TranslationsBloc>(
      bloc: translationsBloc,
      child: StreamBuilder<Locale>(
        stream: translationsBloc.currentLocale,
        initialData: allTranslations.locale,
        builder: (BuildContext context, AsyncSnapshot<Locale> snapshot) {

    return MaterialApp(  
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