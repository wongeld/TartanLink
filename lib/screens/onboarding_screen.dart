import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _index = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/images/onboard1.jpg',
      'title': 'Welcome to TartanLink',
      'subtitle':
          'Find your perfect living match. Exclusively made for Tartans.',
    },
    {
      'image': 'assets/images/onboard2.jpg',
      'title': 'Match with Roommates Who Get You',
      'subtitle':
          'Take our quick compatibility quiz and connect with students who share your lifestyle.',
    },
    {
      'image': 'assets/images/onboard3.jpg',
      'title': 'Explore Verified Housing',
      'subtitle':
          'Browse safe, vetted listings tailored to CMU students in Kigali.',
    },
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _nextPage() {
    if (_index < onboardingData.length - 1) {
      _controller.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      Navigator.pushReplacementNamed(context, '/role');
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            onPageChanged: (i) => setState(() => _index = i),
            itemCount: onboardingData.length,
            itemBuilder: (context, i) {
              final data = onboardingData[i];
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(data['image']!, fit: BoxFit.cover),
                  Container(color: Colors.black.withOpacity(0.55)),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          Column(
                            children: [
                              Text(
                                data['title']!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.3,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 16),
                              Text(
                                data['subtitle']!,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  fontSize: 17,
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(onboardingData.length, (j) {
                              return AnimatedContainer(
                                duration: Duration(milliseconds: 250),
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                width: _index == j ? 20 : 10,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: _index == j
                                      ? Colors.white
                                      : Colors.white38,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: 30),
                          if (i == onboardingData.length - 1)
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: primary,
                                  minimumSize: Size(double.infinity, 52),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: _nextPage,
                                child: Text(
                                  'Proceed',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          if (i != onboardingData.length - 1)
                            SizedBox(height: 80), // spacing for visual balance
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
