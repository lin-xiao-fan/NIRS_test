import 'package:brelax/core/constants/colors.dart';
import 'package:brelax/core/widgets/customized_btn.dart';
import 'package:brelax/core/widgets/gradient_scaffold.dart';
import 'package:flutter/material.dart';

class BreathingEnd extends StatelessWidget {
  const BreathingEnd({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
        gradientBackground: AppColors.brBackground, 
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.05),
              const Text('完成訓練啦！',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              const SizedBox(height: 60,),
              SizedBox(
                width: 200,
                child: Image.asset('assets/images/lightsun.png'),
              ),
              const SizedBox(height: 60,),
              SizedBox(
                width: 200,
                height: 50,
                child: CustomizedBtn(label: '再一次',onPressed: () {
                    Navigator.pushNamed(context, '/breathingoptions');
                  },),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: 200,
                height: 50,
                child: CustomizedBtn(label: '回首頁',onPressed: () {
                    Navigator.pushNamed(context, '/brhome');
                  },),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.05),
            ],
          ),
        ));
  }
}
