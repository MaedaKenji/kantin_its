import 'package:flutter/material.dart';
import 'package:kantin_its/core/configs/theme/app_theme.dart';
import 'package:kantin_its/core/configs/theme/app_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kantin ITS',
      theme: AppTheme.getAppTheme(),
      home: const KantinPage(),
    );
  }
}

class KantinPage extends StatelessWidget {
  const KantinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.getGradientBackground(),
        child: const Column(
          children: [
            Logo(),
            KantinText(),
            SearchBar(),
            SizedBox(height: 20),
            ScrollableButtonSection(),
            KantinCard(title: "Kantin 1", description: "description")
          ],
        ),
      ),
    );
  }
}

class KantinCard extends StatelessWidget {
  final String title;
  final String description;

  const KantinCard({
    super.key,
    required this.title,
    required this.description,
  });

@override
Widget build(BuildContext context) {
  return SizedBox(
    width: 328,
    height: 139,
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: AppColors.accentDarkColor,
              ),
            ),
            const SizedBox(height: 4), // Jarak antara teks dan garis
            Container(
              width: 100, // Atur panjang garis sesuai kebutuhan
              height: 2, // Ketebalan garis
              color: AppColors.accentDarkColor, // Warna garis
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                description,
                style: const TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}}

class ScrollableButtonSection extends StatefulWidget {
  const ScrollableButtonSection({Key? key}) : super(key: key);

  @override
  State<ScrollableButtonSection> createState() =>
      _ScrollableButtonSectionState();
}

class _ScrollableButtonSectionState extends State<ScrollableButtonSection> {
  int _activeIndex = 0;

  void _setActiveButton(int index) {
    setState(() {
      _activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            CustomButton(
              text: 'Button 1',
              isActive: _activeIndex == 0,
              onPressed: () => _setActiveButton(0),
            ),
            const SizedBox(width: 10),
            CustomButton(
              text: 'Button 2',
              isActive: _activeIndex == 1,
              onPressed: () => _setActiveButton(1),
            ),
            const SizedBox(width: 10),
            CustomButton(
              text: 'Button 3',
              isActive: _activeIndex == 2,
              onPressed: () => _setActiveButton(2),
            ),
            const SizedBox(width: 10),
            CustomButton(
              text: 'Button 4',
              isActive: _activeIndex == 3,
              onPressed: () => _setActiveButton(3),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: isActive ? Colors.white : AppColors.accentSearchColor,
        backgroundColor: isActive ? AppColors.accentSearchColor : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
          side: const BorderSide(color: AppColors.accentSearchColor),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        elevation: isActive ? 5 : 0,
      ),
      child: Text(text),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      width: 178,
      height: 173,
    );
  }
}

class KantinText extends StatelessWidget {
  const KantinText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Kantin ITS',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.accentColor,
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(9.43)),
            borderSide: BorderSide(color: Colors.white, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(9.43)),
            borderSide: BorderSide(color: Colors.white, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(9.43)),
            borderSide: BorderSide(color: Colors.white, width: 1.0),
          ),
          filled: true,
          fillColor: AppColors.accentSearchColor,
          hintText: 'Cari makanan atau minuman',
        ),
      ),
    );
  }
}
