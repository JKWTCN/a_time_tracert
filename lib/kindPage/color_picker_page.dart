import 'package:flutter/material.dart';

class ColorPickerPage extends StatefulWidget {
  const ColorPickerPage({super.key});

  @override
  State<ColorPickerPage> createState() => _ColorPickerPageState();
}

class _ColorPickerPageState extends State<ColorPickerPage> {
  // 初始颜色值 (0-255)
  double redValue = 128;
  double greenValue = 128;
  double blueValue = 128;

  @override
  Widget build(BuildContext context) {
    // 根据滑块值创建颜色
    final selectedColor = Color.fromRGBO(
      redValue.toInt(),
      greenValue.toInt(),
      blueValue.toInt(),
      1.0,
    );
    // 将RGB值转换为16进制字符串
    final hexColor =
        '#${redValue.toInt().toRadixString(16).padLeft(2, '0')}${greenValue.toInt().toRadixString(16).padLeft(2, '0')}${blueValue.toInt().toRadixString(16).padLeft(2, '0')}';

    return Scaffold(
      appBar: AppBar(title: const Text('RGB颜色选择')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 显示当前颜色
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: selectedColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  hexColor.toUpperCase(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: selectedColor.computeLuminance() > 0.5
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // 红色滑块
            _buildColorSlider(
              label: '红',
              value: redValue,
              activeColor: Colors.red,
              onChanged: (value) {
                setState(() {
                  redValue = value;
                });
              },
            ),
            const SizedBox(height: 16),
            // 绿色滑块
            _buildColorSlider(
              label: '绿',
              value: greenValue,
              activeColor: Colors.green,
              onChanged: (value) {
                setState(() {
                  greenValue = value;
                });
              },
            ),
            const SizedBox(height: 16),
            // 蓝色滑块
            _buildColorSlider(
              label: '蓝',
              value: blueValue,
              activeColor: Colors.blue,
              onChanged: (value) {
                setState(() {
                  blueValue = value;
                });
              },
            ),
            const SizedBox(height: 32),
            // 显示RGB数值
            _buildColorValueText(),
          ],
        ),
      ),
    );
  }

  // 构建颜色滑块组件
  Widget _buildColorSlider({
    required String label,
    required double value,
    required Color activeColor,
    required ValueChanged<double> onChanged,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 40,
          child: Text(
            '$label:',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Slider(
            value: value,
            min: 0,
            max: 255,
            divisions: 255,
            label: value.round().toString(),
            activeColor: activeColor,
            inactiveColor: activeColor,
            onChanged: onChanged,
          ),
        ),
        SizedBox(
          width: 40,
          child: Text(
            value.round().toString(),
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  // 构建RGB数值显示文本
  Widget _buildColorValueText() {
    return Column(
      children: [
        Text(
          'RGB: ($redValue, $greenValue, $blueValue)',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 8),
        Text(
          'HEX: #${redValue.toInt().toRadixString(16).padLeft(2, '0')}'
          '${greenValue.toInt().toRadixString(16).padLeft(2, '0')}'
          '${blueValue.toInt().toRadixString(16).padLeft(2, '0')}',
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
