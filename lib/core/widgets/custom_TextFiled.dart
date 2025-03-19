import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller; // 可選的 Controller
  final bool isPassword;
  final Color backgroundColor;
  final Color borderColor;


  const CustomTextFiled({
    super.key,
    required this.hintText,
    this.controller,
    this.isPassword =false,
    this.backgroundColor =Colors.white,
    this.borderColor = Colors.white,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
                  width: 280,
                  height: 45,
                  child: TextField(
                    controller: controller,
                    obscureText: isPassword, //是否隱藏輸入內容
                decoration: InputDecoration(
                  hintText: hintText,
                  filled: true, // 啟用填充背景
                  fillColor: Colors.white, // 設定背景顏色
                  hintStyle: const TextStyle(color: Color(0xFF999999)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), // 設定圓角半徑
                    borderSide: BorderSide.none, // 移除邊框
                  ),
                ),
              ),
                ),
    );
  }
}