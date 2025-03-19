import 'package:brelax/demo.dart';
import 'package:brelax/features/authentication/presentation/page/login_options.dart';
import 'package:brelax/features/breathing/presentation/pages/breathing_options.dart';
import 'package:brelax/features/breathing/presentation/pages/home.dart';
import 'package:brelax/features/authentication/presentation/page/login.dart';
import 'package:brelax/features/authentication/presentation/page/register.dart';
import 'package:brelax/features/nirs/presentation/page/nirs_ble.dart';
import 'package:brelax/features/nirs/presentation/page/nirshome.dart';
import 'package:brelax/features/tes/presentation/page/teshome.dart';
import 'package:flutter/material.dart';
import 'package:brelax/features/breathing/presentation/pages/breathinghome.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'features/ble/application/ble_provider.dart';
import 'features/ble/presentation/page/ble_connect_page.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
   runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BleProvider()),  // <-- 加入 BLE provider
        // 如果有其他 provider，也可以在這裡加入
      ],
      child: const MyApp(),  // 你的主應用 widget
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        sliderTheme: const SliderThemeData(
          thumbColor: Colors.white,
          overlayColor: Colors.transparent,
          activeTrackColor: Color.fromRGBO(138, 138, 138, 0.15),
          inactiveTrackColor: Color.fromRGBO(138, 138, 138, 0.15),
          trackShape: CustomSliderTrackShape(),
          trackHeight: 30,
        ),
      ),
      home: const loginpage(),
      routes: {
        '/login': (context) => const loginpage(),
        '/home1': (context) => const Home(),
        '/brhome': (context) => const BreathingHome(),
        '/breathingoptions': (context) => const BreathingOptions(),
        '/register': (context) => const Register(),
        '/teshome': (context) => const TesHome(),
        '/nirshome': (context) => const NirsHome(),
        '/nirsbleconnect': (context) => const NirsBleConnect(),
        '/BleConnectPage': (context) => const BleConnectPage(),

      },
    );
  }
}

class CustomSliderTrackShape extends RoundedRectSliderTrackShape {
  const CustomSliderTrackShape();
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    // final trackHeight = parentBox.size.height;
    final trackLeft = offset.dx;
    final trackTop = offset.dy;
    // final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight!);
  }
}
