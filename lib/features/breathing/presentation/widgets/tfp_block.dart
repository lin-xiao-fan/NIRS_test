import 'package:brelax/core/constants/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TfpBlock extends StatefulWidget {
  final Function(int, int, int) update;

  const TfpBlock({super.key, required this.update});

  @override
  State<TfpBlock> createState() => _TfpBlockState();
}

class _TfpBlockState extends State<TfpBlock> {
  int frequency = 600;
  int pulseWidth = 600;
  int stimulationTime = 10;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.schedule)),
              const SizedBox(),
              CircleAvatar(backgroundColor: Colors.white, child: SvgPicture.asset('assets/images/frequency.svg')),
              const SizedBox(),
              CircleAvatar(backgroundColor: Colors.white, child: SvgPicture.asset('assets/images/pulse_width.svg')),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: DropdownButton<int>(
                  value: stimulationTime,
                  dropdownColor: Colors.grey.shade200,
                  isExpanded: true,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  icon: const SizedBox.shrink(),
                  underline: Container(),
                  menuMaxHeight: MediaQuery.of(context).size.height * 0.3,
                  onChanged: (int? newValue) {
                    if (newValue != null) {
                      setState(() {
                        stimulationTime = newValue;
                      });
                      widget.update(stimulationTime, frequency, pulseWidth);
                    }
                  },
                  items: [5, 10, 15, 20].map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Center(child: Text('$value 分鐘')),
                    );
                  }).toList(),
                ),
              ),
              // SizedBox(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Text('Frequency(Hz)', style: FontStyles.smallContent),
                        SizedBox(
                          height: 30,
                          child: Slider(
                              min: 0,
                              max: 1200,
                              divisions: 1200 ~/ 5,
                              value: frequency.toDouble(),
                              onChanged: (value) {
                                setState(() {
                                  frequency = value.toInt();
                                });
                                widget.update(stimulationTime, frequency, pulseWidth);
                              }),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        '$frequency',
                        style: FontStyles.smallContent?.copyWith(height: 2),
                      ),
                    ),
                  ),
                ],
              ),
              // SizedBox(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Text('Pulse Width(ms)', style: FontStyles.smallContent),
                        SizedBox(
                          height: 30,
                          child: Slider(
                              min: 0,
                              max: 1200,
                              divisions: 1200 ~/ 5,
                              value: pulseWidth.toDouble(),
                              onChanged: (value) {
                                setState(() {
                                  pulseWidth = value.toInt();
                                });
                                widget.update(stimulationTime, frequency, pulseWidth);
                              }),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        '$pulseWidth',
                        style: FontStyles.smallContent?.copyWith(height: 2),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
