import 'package:flutter/material.dart';

class PageNotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final maxHeight = constraints.maxHeight;

          final isMobile = maxWidth < 700;

          return Container(
            width: maxWidth,
            height: maxHeight,
            color: Colors.white,
            child:
                isMobile
                    ? Column(
                      children: [
                        Expanded(flex: 5, child: _TextSection(isMobile: true)),
                        Expanded(flex: 5, child: _ImageSection()),
                      ],
                    )
                    : Row(
                      children: [
                        Expanded(flex: 5, child: _TextSection(isMobile: false)),
                        Expanded(flex: 5, child: _ImageSection()),
                      ],
                    ),
          );
        },
      ),
    );
  }
}

class _TextSection extends StatelessWidget {
  final bool isMobile;

  const _TextSection({Key? key, required this.isMobile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // We'll use FittedBox to scale text to fit available space nicely
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 70),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: isMobile ? Alignment.center : Alignment.centerLeft,
        child: Column(
          mainAxisAlignment:
              isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          crossAxisAlignment:
              isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "404",
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w800,
                fontSize: isMobile ? 80 : 100,
              ),
            ),
            Text(
              "Travel in Space",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: isMobile ? 50 : 70,
              ),
            ),
            SizedBox(height: isMobile ? 8 : 12),
            Container(
              height: isMobile ? 6 : 8,
              width: isMobile ? 70 : 110,
              color: Colors.black,
            ),
            SizedBox(height: isMobile ? 15 : 25),
            SizedBox(
              width: isMobile ? 250 : 350,
              child: Text(
                "You've ventured into the unknown.\n"
                "This page is lost in space — but you can always return home.",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: isMobile ? 18 : 22,
                  height: 1.4,
                  color: Colors.black87,
                ),
                textAlign: isMobile ? TextAlign.center : TextAlign.left,
              ),
            ),
            SizedBox(height: isMobile ? 25 : 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 25 : 40,
                  vertical: isMobile ? 12 : 18,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                "Go Home",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 14 : 16,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use FittedBox to scale the image within available space without overflow
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Image.asset("assets/images/content/main.png"),
      ),
    );
  }
}
