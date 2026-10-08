import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const FilterDemo());
}

class FilterDemo extends StatelessWidget {
  const FilterDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final picker = ImagePicker();

  File? image;

  String filter = 'original';

  // التقاط صورة
  Future<void> camera() async {
    final result = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (result != null) {
      setState(() {
        image = File(result.path);
      });
    }
  }

  // اختيار صورة
  Future<void> gallery() async {
    final result = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (result != null) {
      setState(() {
        image = File(result.path);
      });
    }
  }

  // فلاتر تجريبية
  ColorFilter getFilter() {
    switch (filter) {
      case 'warm':
        return const ColorFilter.matrix([
          1.1, 0, 0, 0, 20,
          0, 0.9, 0, 0, 5,
          0, 0, 0.7, 0, 0,
          0, 0, 0, 1, 0,
        ]);

      case 'cool':
        return const ColorFilter.matrix([
          0.8, 0, 0, 0, 0,
          0, 1.0, 0, 0, 0,
          0, 0, 1.2, 0, 20,
          0, 0, 0, 1, 0,
        ]);

      case 'vintage':
        return const ColorFilter.matrix([
          1.0, 0, 0, 0, 20,
          0, 0.8, 0, 0, 10,
          0, 0, 0.6, 0, 0,
          0, 0, 0, 1, 0,
        ]);

      case 'blackWhite':
        return const ColorFilter.matrix([
          0.33, 0.59, 0.11, 0, 0,
          0.33, 0.59, 0.11, 0, 0,
          0.33, 0.59, 0.11, 0, 0,
          0, 0, 0, 1, 0,
        ]);

      case 'pink':
        return const ColorFilter.matrix([
          1.1, 0, 0, 0, 20,
          0, 0.8, 0, 0, 0,
          0, 0, 1.0, 0, 20,
          0, 0, 0, 1, 0,
        ]);

      case 'dramatic':
        return const ColorFilter.matrix([
          1.4, 0, 0, 0, -30,
          0, 1.4, 0, 0, -30,
          0, 0, 1.4, 0, -30,
          0, 0, 0, 1, 0,
        ]);

      case 'sunset':
        return const ColorFilter.matrix([
          1.2, 0, 0, 0, 30,
          0, 0.9, 0, 0, 0,
          0, 0, 0.7, 0, 0,
          0, 0, 0, 1, 0,
        ]);

      case 'blue':
        return const ColorFilter.matrix([
          0.8, 0, 0, 0, 0,
          0, 0.9, 0, 0, 0,
          0, 0, 1.4, 0, 20,
          0, 0, 0, 1, 0,
        ]);

      case 'green':
        return const ColorFilter.matrix([
          0.8, 0, 0, 0, 0,
          0, 1.3, 0, 0, 10,
          0, 0, 0.8, 0, 0,
          0, 0, 0, 1, 0,
        ]);

      default:
        return const ColorFilter.mode(
          Colors.transparent,
          BlendMode.dst,
        );
    }
  }

  Widget filterButton(
    String name,
    String value,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          filter = value;
        });
      },
      child: Container(
        width: 75,
        margin: const EdgeInsets.only(right: 10),
        child: Column(
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: filter == value
                      ? Colors.purple
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.auto_awesome,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              name,
              style: const TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Filter Demo'),
        centerTitle: true,
      ),

      body: Column(
        children: [
          // الصورة
          Expanded(
            child: Center(
              child: image == null
                  ? const Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.photo_camera,
                          size: 80,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 15),
                        Text(
                          'التقط صورة أو اختر صورة',
                        ),
                      ],
                    )
                  : ColorFiltered(
                      colorFilter: getFilter(),
                      child: Image.file(
                        image!,
                        fit: BoxFit.contain,
                      ),
                    ),
            ),
          ),

          // أزرار الكاميرا والمعرض
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: camera,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('الكاميرا'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: gallery,
                    icon: const Icon(Icons.photo),
                    label: const Text('المعرض'),
                  ),
                ),
              ],
            ),
          ),

          // الفلاتر
          SizedBox(
            height: 105,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(10),
              children: [
                filterButton('Original', 'original'),
                filterButton('Warm', 'warm'),
                filterButton('Cool', 'cool'),
                filterButton('Vintage', 'vintage'),
                filterButton('B&W', 'blackWhite'),
                filterButton('Pink', 'pink'),
                filterButton('Dramatic', 'dramatic'),
                filterButton('Sunset', 'sunset'),
                filterButton('Blue', 'blue'),
                filterButton('Green', 'green'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}