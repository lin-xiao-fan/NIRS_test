import 'package:brelax/core/constants/colors.dart';
import 'package:brelax/core/widgets/Custom_TextFiled.dart';
import 'package:brelax/core/widgets/customized_btn.dart';
import 'package:brelax/core/widgets/gradient_scaffold.dart';
import 'package:flutter/material.dart';

class loginpage extends StatelessWidget {
  const loginpage({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      gradientBackground: AppColors.brBackground,
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Brelax',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              width: 150,
              height: 150,
              child: Image.asset('assets/images/suncloud.png'),
            ),
            const SizedBox(height: 10),
            const Text(
              '電子郵件',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const CustomTextFiled(hintText: '電子郵件'),
            const SizedBox(height: 10),
            const Text(
              '密碼',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const CustomTextFiled(hintText: '密碼',isPassword: true,),
            const SizedBox(height: 30,),
           SizedBox(
              width: 200,
              height: 50,
              child: CustomizedBtn(label: '登入', onPressed: () {
                    Navigator.pushNamed(context, '/home1');
                  },
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: CustomizedBtn(label: '註冊', onPressed: () {
                Navigator.pushNamed(context,'/register');
              },),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          ],
        ),
      )),
    );
  }
}
