import 'package:brelax/core/constants/colors.dart';
import 'package:brelax/core/constants/font_style.dart';
import 'package:brelax/core/widgets/Custom_TextFiled.dart';
import 'package:brelax/core/widgets/customized_btn.dart';
import 'package:brelax/core/widgets/gradient_scaffold.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
        gradientBackground: AppColors.brBackground,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.05),
                const Text(
                  '歡迎來到Brelax',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 30,),
                Text('名字', style: FontStyles.text15),

                const SizedBox(height: 10,),

                const CustomTextFiled(hintText: '名字'),
                const SizedBox(
                  height: 10,
                ),
                Text('電子郵件', style: FontStyles.text15),

                const SizedBox(height: 10,),

                const CustomTextFiled(hintText: '電子郵件'),

                const SizedBox(height: 10,),
                Text('密碼', style: FontStyles.text15),

                const SizedBox(height: 10,),

                const CustomTextFiled(
                  hintText: '密碼', isPassword: true,
                ),

                const SizedBox(height: 20,),

                const CustomTextFiled(
                  hintText: '密碼', isPassword: true,
                ),
                const SizedBox(height: 30,),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: CustomizedBtn(
                    label: '完成註冊',onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              ],
            ),
          ),
        ));
  }
}
