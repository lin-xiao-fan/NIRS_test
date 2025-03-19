import 'package:flutter/material.dart';
import 'package:brelax/core/widgets/gradient_scaffold.dart';
import 'package:brelax/core/constants/colors.dart';
import 'package:brelax/core/widgets/customized_btn.dart';
import 'package:brelax/core/widgets/nav_list.dart';

class NirsHome extends StatefulWidget {
  const NirsHome({super.key});

  @override
  State<NirsHome> createState() => _NirsHome();
}

class _NirsHome extends State<NirsHome> {
  String selectedPage = 'NIRS';

    void ontapSelected(String label) {
    setState(() {
      selectedPage = label;
    });
    print('選擇頁面: $label');
  }


  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      gradientBackground: AppColors.nirsBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NavList(selectedPage: selectedPage,onItemSelected: ontapSelected,),
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset('assets/images/nirscloud.png'),
            ),
            SizedBox(
                width: 200,
                height: 50,
                child: CustomizedBtn(
                  label: '開始測量',
                  onPressed: () {
                    Navigator.pushNamed(context, '/BleConnectPage');
                  },
                )),
          ],
        ),
      ),
    );
  }
}

