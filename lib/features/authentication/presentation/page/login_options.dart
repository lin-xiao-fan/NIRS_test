import 'package:brelax/core/constants/colors.dart';
import 'package:brelax/core/widgets/customized_btn.dart';
import 'package:brelax/core/widgets/gradient_scaffold.dart';
import 'package:flutter/material.dart';

class LoginOptions extends StatelessWidget {
  const LoginOptions({super.key});

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
            const Text(
              'Brelax',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 55,
                  fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 35,),
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset(
              "assets/images/suncloud.png",
            ),
            ),
            const SizedBox(height: 40,),
            SizedBox(
              width: 200,
              height: 50,
              child: CustomizedBtn(label: '一般用戶',
              onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
              ),
            ),
            const SizedBox(height: 20,),
            const SizedBox(
              width: 200,
              height: 50,
              child:CustomizedBtn(label: '工程用戶'),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.05),
          ],
        ),
      ),
    );
  }
}
