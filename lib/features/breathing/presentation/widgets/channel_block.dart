import 'package:brelax/core/constants/font_style.dart';
import 'package:brelax/features/breathing/presentation/widgets/custom_rect.dart';
import 'package:flutter/material.dart';

class ChannelBlock extends StatefulWidget {
  final Function(List<int>,List<int>) update;
  const ChannelBlock({super.key, required this.update});

  @override
  State<ChannelBlock> createState() => _ChannelBlockState();
}

class _ChannelBlockState extends State<ChannelBlock> {
  final int itemCount = 8;
  List<bool> itemIsSelected = []; // channel是否被選擇
  List<GlobalKey> itemKeys = []; //channel globalKey
  double itemWidth = 0;
  double itemHeight = 0;
  int selectedIndex = 0;
  GlobalKey expKey = GlobalKey();
  double expWidth = 0;
  double expHeight = 0;
  List<int> intensity = [];
  List<int> offSet = [];

  @override
  void initState() {
    super.initState();
    // 為每個 item 建立 GlobalKey 和 bool
    itemKeys = List.generate(itemCount, (index) => GlobalKey());
    itemIsSelected = List.generate(itemCount, (index) => false);
    intensity = List.generate(itemCount, (index)=>250);
    offSet = List.generate(itemCount, (index)=>250);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getContainerInfo(itemKeys[0], expKey);
      setState(() {

      });
    });
  }

  // 取得每個 item 的起始座標
  void _getContainerInfo(GlobalKey containerKey, GlobalKey expKey) {
    RenderBox? renderBox = containerKey.currentContext?.findRenderObject() as RenderBox?;
    RenderBox? expBox = expKey.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox != null && expBox != null) {
      itemWidth = renderBox.size.width;
      itemHeight = renderBox.size.height;
      expWidth = expBox.size.width;
      expHeight = expBox.size.height;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Color.fromRGBO(255, 255, 255, 0.5)),
        child: Column(
          children: [
            Text(
              'Channel',
              style: FontStyles.content,
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipPath(
                      clipper: LShapeClipper(w: itemWidth, h: itemHeight, index: selectedIndex, expW: expWidth, expH: expHeight),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(color: Colors.grey.shade500, spreadRadius: 0.1, blurRadius: 70, offset: const Offset(-50, 850)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GridView.builder(
                    scrollDirection: Axis.vertical,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8, childAspectRatio: 0.5),
                    itemCount: itemCount,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        key: itemKeys[index],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(child: Text('${index + 1}', style: FontStyles.smallContent)),
                            Checkbox(
                              value: itemIsSelected[index],
                              onChanged: (value) {
                                setState(() {
                                  selectedIndex = index;
                                  itemIsSelected[index] = value!;
                                  _getContainerInfo(itemKeys[index], expKey);
                                });
                              },
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              activeColor: Colors.amber,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Positioned.fill(
                    key: expKey,
                    top: itemHeight,
                    left: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.transparent,
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(backgroundColor: Colors.grey, child: Icon(Icons.image)),
                              CircleAvatar(backgroundColor: Colors.grey, child: Icon(Icons.image)),
                            ],
                          )),
                          Expanded(
                            flex: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        children: [
                                          Text('Intensity(uA)', style: FontStyles.smallContent),
                                          SizedBox(
                                            height: 30,
                                            child: Slider(
                                                min: 0,
                                                max: 500,
                                                divisions: 500 ~/ 5,
                                                value: intensity[selectedIndex].toDouble(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    intensity[selectedIndex] = value.toInt();
                                                  });
                                                  widget.update(intensity,offSet);
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Text(
                                          '${intensity[selectedIndex]}',
                                          style: FontStyles.smallContent?.copyWith(height: 2),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        children: [
                                          Text('Offset(uA)', style: FontStyles.smallContent),
                                          SizedBox(
                                            height: 30,
                                            child: Slider(
                                                min: 0,
                                                max: 500,
                                                divisions: 500 ~/ 5,
                                                value: offSet[selectedIndex].toDouble(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    offSet[selectedIndex] = value.toInt();
                                                  });
                                                  widget.update(intensity,offSet);
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Text(
                                          "${offSet[selectedIndex]}",
                                          style: FontStyles.smallContent?.copyWith(height: 2),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
