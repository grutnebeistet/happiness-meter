import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:happiness_meter/bloc/bloc_provider.dart';
import 'package:happiness_meter/bloc/bloc_provider.dart';
import 'package:happiness_meter/global_translations.dart';
import 'package:preferences/preference_page.dart';
import 'package:preferences/preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}
  class  _SettingsPageState extends State<SettingsPage> {
@override
  Widget build(BuildContext context) {
  //
    // Retrieves the BLoC that handles the changes to the current language
    //
    final TranslationsBloc translationsBloc = BlocProvider.of<TranslationsBloc>(context);
    
    //
    // Retrieves the title of the page, from the translations
    //
    final String pageTitle = allTranslations.text("settings.page_title");
    
    //
    // Retrieves the caption of the button
    //
    final String buttonCaption = allTranslations.text("page.changeLanguage");

  return Scaffold(
      body: PreferencePage([
        PreferenceTitle(allTranslations.text("settings.change_language")),
        RadioPreference(
          'English',
          'en',
          'app_language',
             onSelect: (){ translationsBloc.setNewLanguage("en");},
          isDefault: true,
        ),
        RadioPreference(
          'Nederlands',
          'nl',
          'app_language',
          onSelect: (){ translationsBloc.setNewLanguage("nl");},
        ),
      ],
      ),
      
    );
  }
}