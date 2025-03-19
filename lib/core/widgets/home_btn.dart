import 'package:brelax/core/constants/colors.dart';
import 'package:flutter/material.dart';

class HomeBtn extends StatelessWidget {
  final String text; // 改為小寫
  final String imagePath; // 圖片路徑
  final VoidCallback onPressed; // 函數類型改為 VoidCallback
  final List<Color>? gradientColors;

  const HomeBtn({
    super.key,
    required this.text,
    required this.imagePath,
    required this.onPressed,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 300,
        height: 90,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24), // 調整內邊距，避免按鈕太小
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors ?? AppColors.brBackground, // 使用預先定義的漸層顏色
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8), // 圓角設置
          boxShadow: const [
            BoxShadow(
              color: Colors.black26, // 設定陰影顏色
              blurRadius: 6, // 模糊半徑
              offset: Offset(2, 4), // 陰影偏移
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // 讓元素水平居中
          children: [
            Image.asset(
              imagePath, // 使用傳遞的圖片路徑
              width: 100, // 圖片寬度
              height: 100, // 圖片高度
            ),
            const SizedBox(width: 10), // 圖片與文字之間的間距
            Text(
              text, // 顯示的文字
              style: const TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
