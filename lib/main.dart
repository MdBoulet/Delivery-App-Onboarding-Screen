import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnBoardingScreen(),
    );
  }
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int selectedIndex = 0;

  PageController _controller = PageController();



  Widget BuildNavigation(){
    return Container(
      width: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(3, (index) => PointIndicator(index)),
      ),
    );
  }

  Widget PointIndicator(int index){
    return GestureDetector(
      onTap: (){
        setState(() {
          selectedIndex = index;
          _controller.jumpToPage(index);
        });
      },
      child: Container(
        height: 6,
        width: 6,
        decoration: BoxDecoration(
            color: selectedIndex == index ? Colors.white : Colors.white24,
            borderRadius: BorderRadius.circular(3)
        ),
      ),
    );
  }

  Widget AnimationImage(String image, String title, String content){
    return Column(
      children: [
        Lottie.asset(image),
        SizedBox(height: 40),
        OnBoardingContent('${title}', '${content}')
      ],
    );
  }

  Widget OnBoardingContent(String title, String content){
    return Column(
      children: [
        Text('${title}', style: GoogleFonts.roboto(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            color: Colors.white
        )
        ),
        SizedBox(height: 20),
        Text('${content}',
          style: GoogleFonts.lato(
              fontSize: 20,
              color: Colors.white70
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.black,
            ),
            Container(
              height: 420,
              decoration: BoxDecoration(
                  color: Colors.orange,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(200),
                  bottomLeft: Radius.circular(200)
                )
              ),
            ),
            Container(
              height: 360,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(200),
                      bottomLeft: Radius.circular(200)
                  )
              ),
            ),
            PageView(
              controller: _controller,
              onPageChanged: (index){
                setState(() {
                  selectedIndex = index;
                });
              },
              children: [
                Stack(
                  children: [
                    AnimationImage(
                        'assets/lotties/67221-food-market-app-interaction.json',
                        'Choose A Tasty',
                        'When you order Eat Street, we\'ll \n'
                            'hook you up with exlusive\n'
                            'coupons'
                    ),
                  ],
                ),
                Stack(
                  children: [
                    AnimationImage(
                        'assets/lotties/67226-food-app-interaction.json',
                        'Discover Places',
                        'We make it simple to find the\n'
                            'food you crave. Enter your \n'
                            'adress and let'
                    )
                  ],
                ),
                Stack(
                  children: [
                    AnimationImage(
                        'assets/lotties/67225-delivery-food-interaction.json',
                        'Pick Up Or',
                        'We make food ordering fast, \n'
                            'simple an free - no matter if you\n '
                            'order'
                    )
                  ],
                )
              ],
            ),
            Positioned(
              left: 180,
              bottom: 20,
              child: BuildNavigation(),
            ),
            Positioned(
              bottom: 4,
              left: 330,
              child: IconButton(
                icon: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 30,),
                onPressed: (){
                  setState(() {
                    if(selectedIndex < 2){
                      selectedIndex++;
                      _controller.jumpToPage(selectedIndex);
                    }
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
