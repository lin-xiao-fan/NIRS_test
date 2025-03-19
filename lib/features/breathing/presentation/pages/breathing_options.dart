import 'package:brelax/core/constants/br_detail_data.dart';
import 'package:brelax/core/constants/colors.dart';
import 'package:brelax/core/constants/font_style.dart';
import 'package:brelax/core/widgets/br_details.dart';
import 'package:brelax/core/widgets/customized_btn.dart';
import 'package:brelax/core/widgets/gradient_scaffold.dart';
import 'package:brelax/core/widgets/timepicker.dart';
import 'package:brelax/features/breathing/presentation/pages/breathing_animation.dart';
import 'package:brelax/features/breathing/presentation/pages/breathing_method.dart';
import 'package:flutter/material.dart';

class BreathingOptions extends StatefulWidget {
  const BreathingOptions({super.key});
  @override
  State<BreathingOptions> createState() => _BreathingOptions();
}

class _BreathingOptions extends State<BreathingOptions> {
  int onTimeSelected = 1;
  int selectedIndex = 0;
  final List<String> btnLabels = ['4-7-8', '4-2-6', '盒式呼吸', '3-3-3'];

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      gradientBackground: AppColors.brBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context); // 回上一頁
                },
                icon: const Icon(Icons.arrow_back_ios_new),
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 150,
              height: 150,
              child: Image.asset('assets/images/sun.png'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 25),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), // 禁止 GridView 滾動
                childAspectRatio: 4.1,
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: List.generate(btnLabels.length, (index) {
                  bool isSelected = (selectedIndex == index);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                        width: 165,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          color: isSelected
                              ? const Color(0xFFFFFFFF)
                              : const Color.fromRGBO(255, 255, 255, 0.6),
                        ),
                        child: Center(
                          child: Text(
                            btnLabels[index],
                            style: TextStyle(
                                color: isSelected
                                    ? const Color(0xFF4B4B4B)
                                    : const Color(0xFF989898),
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        )),
                  );
                }),
              ),
            ),
            Center(
              // 讓 BrDetails 置中
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: BrDetails(
                  title: breathingInfo[selectedIndex]['title'] ?? '',
                  shortID: breathingInfo[selectedIndex]['shortID'] ??
                      '', // 確保 key 正確
                  detailed: breathingInfo[selectedIndex]['detailed'] ?? '',
                  inhale: breathingInfo[selectedIndex]['inhale'] ?? '',
                  hold: breathingInfo[selectedIndex]['hold'] ?? '',
                  exhale: breathingInfo[selectedIndex]['exhale'] ?? '',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                '呼吸分鐘',
                style: FontStyles.text15,
              ),
            ),
            Timepicker(
              onTimeSelected: (value) {
                print("選擇的分鐘數: $value");
                setState(() {
                  onTimeSelected = value;
                });
              }, //時間選擇
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 200,
              height: 50,
              child: CustomizedBtn(
                label: '開始呼吸訓練',
                onPressed: () {
                  BreathingMethod selectedMethod =
                      BreathingMethod.breathingMethods[selectedIndex];

                  BreathingSession session = BreathingSession(
                    methodName:
                        btnLabels[selectedIndex], // 方法名稱，可以使用 btnLabels[index]
                    duration: onTimeSelected, // 使用選擇的時間
                    inhale: selectedMethod.inhale,
                    hold: selectedMethod.hold,
                    exhale: selectedMethod.exhale,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BreathingAnimation(
                              inhale: selectedMethod.inhale,
                              hold: selectedMethod.hold,
                              exhale: selectedMethod.exhale,
                              duration: onTimeSelected,
                            )),
                  );
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.05),
          ],
        ),
      ),
    );
  }
}
