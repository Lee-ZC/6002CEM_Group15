import 'package:flutter/material.dart';

class PageForOnboarding extends StatelessWidget {
  const PageForOnboarding(this.heading, this.image, this.backGround, {super.key});
  final String heading;
  final String image;
  final Color backGround;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGround,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              heading,
              style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 60.0),
            Image.asset(image,height: 250,),
            const SizedBox(
              height: 80,
            )
          ],
        ),
      ),
    );
  }
}