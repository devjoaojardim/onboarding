import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late PageController _pageController;
  int _pageIndex = 0;
  late Timer _timer;

  @override
  void initState() {

    _pageController = PageController(initialPage: 0);
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (_pageIndex < 2) {
        _pageIndex++;
        _pageController.animateToPage(
          _pageIndex,
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      } else {
        _pageIndex = 0;
        _pageController.animateToPage(
          _pageIndex,
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xff15478E),
      statusBarBrightness: Brightness.dark,
    ));
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 0, top: 24),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/ui/login");
                  },
                  child: Text(
                    "ENTRAR",
                    style: TextStyle(
                        color: Color(0xff15478E), fontFamily: 'Poppins'),
                  ),
                  style: ButtonStyle(),
                ),
              ),
            ],
          ),
          Expanded(
              child: PageView.builder(
                  itemCount: demo_data.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) => OnboardingContent(
                        image: demo_data[index].image,
                        title: demo_data[index].title,
                        subtitle: demo_data[index].subtitle,
                      ))),
          SizedBox(
            child: Container(
              color: Color(0xff15478E),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(
                        demo_data.length,
                            (index) => Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: DotIndicator(
                            isActive: index == _pageIndex,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Onboard {
  final String image, title, subtitle;

  const Onboard(
      {required this.title, required this.image, required this.subtitle});
}

final List<Onboard> demo_data = [
  Onboard(
    image: 'images/exempla.png',
    title: "Exemplo titulo 1",
    subtitle: "Exemplo de subtitulo 1 funcionando page",
  ),
  Onboard(
    image: 'images/exempla.png',
    title: "Exemplo titulo 2",
    subtitle: "Exemplo de subtitulo 2 funcionando page",
  )
];

class DotIndicator extends StatelessWidget {
  const DotIndicator({Key? key, this.isActive = false}) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: isActive ? 20 : 10,
        width: 4,
        decoration: BoxDecoration(
          color: isActive ? Colors.white: Colors.white.withOpacity(0.4), 
            borderRadius: BorderRadius.all(Radius.circular(12))
           )
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final String image, title, subtitle;

  const OnboardingContent(
      {Key? key,
      required this.title,
      required this.image,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: Center(
                child: Image.asset(
                  image,
                  height: 200,
                  width: 200,
                ),
              ),
            )),
            Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xff15478E),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'),
                    ),
                    SizedBox(height: 8),
                    Text(
                      subtitle,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Poppins'),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

