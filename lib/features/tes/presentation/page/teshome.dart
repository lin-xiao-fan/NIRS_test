import 'package:flutter/material.dart';
import 'package:brelax/core/widgets/gradient_scaffold.dart';
import 'package:brelax/core/constants/colors.dart';
import 'package:brelax/core/widgets/customized_btn.dart';
import 'package:brelax/core/widgets/nav_list.dart';

class TesHome extends StatefulWidget {
  const TesHome({super.key});

  @override
  State<TesHome> createState() => _TesHome();
}

class _TesHome extends State<TesHome> {
  String selectedPage = 'tES';

    void ontapSelected(String label) {
    setState(() {
      selectedPage = label;
    });
    print('選擇頁面: $label');
  }


  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      gradientBackground: AppColors.tesBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NavList(selectedPage: selectedPage,onItemSelected: ontapSelected,),
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset('assets/images/device.png'),
            ),
            SizedBox(
                width: 200,
                height: 50,
                child: CustomizedBtn(
                  label: '開始電刺激',
                  onPressed: () {
                    Navigator.pushNamed(context, '/breathingoptions');
                  },
                )),
          ],
        ),
      ),
    );
  }
}

