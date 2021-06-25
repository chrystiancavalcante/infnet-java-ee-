import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

import 'package:catcher/catcher.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'package:infnet/src/infra/sessao.dart';
import 'package:infnet/src/infra/locator.dart';
import 'package:infnet/src/infra/rotas.dart';
import 'package:infnet/src/infra/infra.dart';
import 'package:infnet/src/view_model/view_model.dart';
import 'package:infnet/src/view/menu/home_page.dart';
import 'package:infnet/src/view/shared/page/splash_screen_page.dart';

void main() async {
  await DotEnv.load(fileName: ".env");
  setupLocator();

  // runApp(MyApp()); // 2021-06-04 - CHRYSTIAN - Comentado para dar lugar à configuração do Catcher como feito no Pegasus PDV

  ///configuração para tratar erros em modo de debug (desenvolvimento)
  CatcherOptions debugOptions = CatcherOptions(
    ///Vai mostrar o erro numa caixa de diálogo
    PageReportMode(),
    [
      //Manda os erros para o Sentry
      SentryHandler(
        SentryClient(SentryOptions(dsn: Constantes.sentryDns)),
      ),

      ///Imprime os erros no Console
      ConsoleHandler()
    ],
    localizationOptions: [
      LocalizationOptions.buildDefaultPortugueseOptions(),
    ],
  );

  ///configuração para tratar erros em modo de release 
  CatcherOptions releaseOptions = CatcherOptions(
    ///Vai mostrar o erro numa página
    PageReportMode(),
    [
      //Manda os erros para o Sentry
      SentryHandler(
        SentryClient(SentryOptions(dsn: Constantes.sentryDns)),
      ),

      ///Imprime os erros no Console
      ConsoleHandler(),
    ],
    localizationOptions: [
      LocalizationOptions.buildDefaultPortugueseOptions(),
    ],
  );

  ///Inicia o Catcher e então inicia a aplicação. 
  ///O Catcher vai pegar e reportar os erros de forma global
  Catcher(
    runAppFunction: () {
      runApp(MyApp());
    },
    debugConfig: debugOptions,
    releaseConfig: releaseOptions,
  );  

}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // cadastros
        ChangeNotifierProvider(create: (_) => locator<BancoViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<BancoAgenciaViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<PessoaViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<ProdutoViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<BancoContaCaixaViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<CargoViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<CepViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<CfopViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<ClienteViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<CnaeViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<ColaboradorViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<SetorViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<ContadorViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<CsosnViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<CstCofinsViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<CstIcmsViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<CstIpiViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<CstPisViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<EstadoCivilViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<FornecedorViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<MunicipioViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<NcmViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<NivelFormacaoViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<TransportadoraViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<UfViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<VendedorViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<ProdutoGrupoViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<ProdutoMarcaViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<ProdutoSubgrupoViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<ProdutoUnidadeViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<UsuarioViewModel>()),

       
	    ],
      builder: (context, value) {
        return FutureBuilder(
          future: Future.delayed(Duration(seconds: 3), () async {
            await Sessao.popularObjetosPrincipais(context);
            if (Biblioteca.isDesktop()) {
              await DesktopWindow.setMinWindowSize(Size(800, 600));
              await DesktopWindow.resetMaxWindowSize();
              await DesktopWindow.toggleFullScreen();
            }
          }),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _materialApp(splash: true);
            } else {
              return _materialApp(splash: false);
            }
          },
        );
      }      
    );
  }
}

Widget _materialApp({bool splash}) {
  return MaterialApp(
    navigatorKey: Catcher.navigatorKey,
    //********************************************
    // builder: (BuildContext context, Widget widget) {
    //   Catcher.addDefaultErrorWidget(
    //       showStacktrace: true,
    //       title: "Custom error title",
    //       description: "Custom error description",
    //       maxWidthForSmallMode: 15);
    //   return widget;
    // },
    //********************************************    
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: [
      const Locale('en', 'US'),
      const Locale('pt', 'PT'),
    ],
    debugShowCheckedModeBanner: false,
    title: Constantes.nomeApp,
    onGenerateRoute: Rotas.definirRotas,
    theme: ThemeData(),
    home: splash == true ? SplashScreenPage() : HomePage(), // TODO: alterar para Login no momento oportuno 
  );
}