import 'package:flutter/material.dart';
import 'package:brelax/core/widgets/gradient_scaffold.dart';
import 'package:brelax/core/constants/colors.dart';
import 'package:brelax/core/widgets/customized_btn.dart';
import 'package:brelax/core/widgets/nav_list.dart';

class BreathingHome extends StatefulWidget {
  const BreathingHome({super.key});

  @override
  State<BreathingHome> createState() => _BreathingHome();
}

class _BreathingHome extends State<BreathingHome> {
  String selectedPage = 'BREATHING';

    void ontapSelected(String label) {
    setState(() {
      selectedPage = label;
    });
    print('選擇頁面: $label');
  }


  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      gradientBackground: AppColors.brBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NavList(selectedPage: selectedPage,onItemSelected: ontapSelected,),
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset('assets/images/suncloud.png'),
            ),
            SizedBox(
                width: 200,
                height: 50,
                child: CustomizedBtn(
                  label: '開始呼吸訓練',
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
