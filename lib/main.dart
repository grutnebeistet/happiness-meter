import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:happiness_meter/bloc/bloc_provider.dart';
import 'package:happiness_meter/data/database_helpers.dart';
import 'package:happiness_meter/global_translations.dart';
import 'package:happiness_meter/screens/meter_page.dart';
import 'package:happiness_meter/screens/record_list_page.dart';
import 'package:happiness_meter/theme/happ_meter_icons.dart';
import 'package:flutter_launcher_icons/android.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:flutter_launcher_icons/custom_exceptions.dart';
import 'package:flutter_launcher_icons/ios.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'dart:async';
import 'dart:io';
// import 'package:testfairy/testfairy.dart';

var TOKEN = "SDK-GQZYxIrO";

void main() async {
  // HttpOverrides.runWithHttpOverrides(
  //     () async {
  //       try {
  //         // Enables widget error logging
  //         FlutterError.onError =
  //             (details) => TestFairy.logError(details.exception);

  //         TestFairy.setServerEndpoint("https://7135426.testfairy.com");

  //         // Initializes a session
  //         await TestFairy.begin(TOKEN);

  //         // Runs your app
  //         WidgetsFlutterBinding.ensureInitialized();
  //         // await PrefService.init(prefix: 'pref_');
  //         await allTranslations.init();

  //         runApp(MyApp());
  //       } catch (error) {
  //         // Logs synchronous errors
  //         TestFairy.logError(error);
  //       }
  //     },

  //     // Logs network events
  //     TestFairy.httpOverrides(),

  //     // Logs asynchronous errors
  //     onError: TestFairy.logError,

  //     // Logs console messages
  //     zoneSpecification: new ZoneSpecification(
  //       print: (self, parent, zone, message) {
  //         TestFairy.log(message);
  //       },
  //     ));

  WidgetsFlutterBinding.ensureInitialized();
  // await PrefService.init(prefix: 'pref_');
  await allTranslations.init();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  TranslationsBloc translationsBloc;
  HappinessRecord record;
  bool editMode = false;
  TabController _controller;

  @override
  void initState() {
    super.initState();

    translationsBloc = TranslationsBloc();
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(_onTabChange);
  }

  @override
  void dispose() {
    translationsBloc?.dispose();
    _controller.dispose();
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
                GlobalCupertinoLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate
              ],
              supportedLocales: allTranslations.supportedLocales(),
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primaryColor: Colors.blueGrey,
              ),
              home: DefaultTabController(
                // length: choices.length,
                length: 2,
                child: new GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Scaffold(
                      appBar: AppBar(
                          backgroundColor: Colors.white,
                          bottom: PreferredSize(
                            preferredSize: Size.fromHeight(32),
                            child: Container(
                              child: SafeArea(
                                child: TabBar(
                                    onTap: (f) {
                                      FocusScope.of(context).unfocus();
                                    },
                                    indicator: UnderlineTabIndicator(
                                        borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 4.0),
                                        insets: EdgeInsets.fromLTRB(
                                            40.0, 20.0, 40.0, 0)),
                                    indicatorWeight: 15,
                                    indicatorSize: TabBarIndicatorSize.label,
                                    labelColor: Colors
                                        .blueGrey, //AppColors.colorThemeBlue,
                                    labelStyle: TextStyle(
                                        fontSize: 12,
                                        letterSpacing: 1.3,
                                        fontWeight: FontWeight.w500),
                                    unselectedLabelColor: Colors.black26,
                                    controller: _controller,
                                    tabs: [
                                      Tab(
                                        text: allTranslations
                                            .text('main.tab_meter'),
                                        icon: Icon(HappMeter.meter_tab,
                                            size: 40),
                                      ),
                                      Tab(
                                        text: allTranslations
                                            .text('main.tab_records'),
                                        icon: Icon(HappMeter.list_1,
                                            size: 40), //insert_chart
                                      ),
                                      // Tab(
                                      //   text: "PROFILE",
                                      //   icon: Icon(Icons.supervised_user_circle,
                                      //       size: 40),
                                      // ),
                                    ]),
                              ),
                            ),
                          )),
                      body: TabBarView(
                        controller: _controller,
                        children: <Widget>[
                          Center(
                            child: MeterPage(record), // ToDO optional
                          ),
                          Center(
                            child: RecordListPage(
                                onEditPressed: (HappinessRecord newRecord) {
                              setState(() {
                                debugPrint(
                                    "main: onEditPressed record: ${newRecord.id}");
                                record = newRecord;
                                editMode = true;
                                _controller.index = 0;
                              });
                            }),
                          ),
                          //  Center(
                          //   child: SettingsPage(),
                          // ),
                        ],
                      )),
                ),
              ),
            );
            // home: HomePage());
          }),
    );
  }

  void _onTabChange() {
    debugPrint("main: editMode $editMode");
    if (!editMode) {
      setState(() {
        record = null;
      });
    }
    editMode = false;
  }
}

typedef RecordDetailCallback = void Function(
    HappinessRecord record); // TODO rename -> RecordEdit...
