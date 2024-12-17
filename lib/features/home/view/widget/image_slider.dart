import 'package:eco/utils/colors_box.dart';
import 'package:eco/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:eco/utils/images.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  State<ImageSlider> createState() => ImageSliderState();
}

class ImageSliderState extends State<ImageSlider> {
  int _currentIndex = 0;
  List<String> banners = [
    AssetsBox.userAvatar,
    AssetsBox.userAvatar,
    AssetsBox.userAvatar,
    AssetsBox.userAvatar,
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> dots = [];

    for (int i = 0; i < banners.length; i++) {
      dots.add(
        _DotWidget(isSelected: _currentIndex == i),
      );
    }
    if (banners.isNotEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          20.ph,
          SizedBox(
            height: 100,
            child: PageView.builder(
              itemCount: banners.length,
              onPageChanged: (int index) =>
                  setState(() => _currentIndex = index),
              itemBuilder: (_, index) {
                return InkWell(
                  onTap: () => print('Tapped on image $index'),
                  child: Image.asset(banners[index], fit: BoxFit.cover),
                );
              },
            ),
          ),
          10.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [...dots],
          )
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}

class _DotWidget extends StatelessWidget {
  const _DotWidget({required this.isSelected});

  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 7,
      height: 7,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: isSelected ? ColorsBox.lighterPurple : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}
