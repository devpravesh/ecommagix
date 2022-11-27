import 'package:ecommagix/model/cart_model.dart';
import 'package:device_preview/device_preview.dart';

import 'imports.dart';

Future<void> main() async {
  runApp(
    kIsWeb
        ? DevicePreview(
            enabled: !kReleaseMode,
            builder: (context) => MyApp(), // Wrap your app
          )
        : MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: CartItems())],
      child: MaterialApp(
        title: 'Magix Store',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
        home: Splash(),
      ),
    );
  }
}
