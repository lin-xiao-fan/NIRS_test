import 'package:brelax/core/constants/colors.dart';
import 'package:brelax/core/widgets/home_btn.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HomeBtn(
                  text: '呼吸訓練',
                  imagePath: 'assets/images/suncloud.png',
                  onPressed: () {
                    Navigator.pushNamed(context, '/brhome');
                  },),
              const SizedBox(height: 45,),
              HomeBtn(
                  text: 'tES',
                  imagePath: 'assets/images/head.png',
                  gradientColors: AppColors.tesBackground,
                  onPressed: () {}),
              const SizedBox(height: 45,),
              HomeBtn(
                  text: 'NIRS',
                  imagePath: 'assets/images/cloud.png',
                  gradientColors: AppColors.nirsBackground,
                  onPressed: () { Navigator.pushNamed(context, '/nirshome');}),
              const SizedBox(height: 45,),
              HomeBtn(
                  text: '使用者',
                  imagePath: 'assets/images/sun.png',
                  gradientColors: AppColors.orangBackground,
                  onPressed: () {}),
            ],
          ),
        ));
  }
}
