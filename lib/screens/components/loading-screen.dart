// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:the_wallet/screens/startup/startup-screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with SingleTickerProviderStateMixin{

  late bool _isLoading;

  late Animation<double> _positionAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _dotAnimation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _isLoading = true;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _positionAnimation = Tween(begin: 0.0, end: 10.0).animate(_controller)
    ..addListener(() {
      setState(() {
        
      });
    });
    _scaleAnimation = Tween(begin: 0.0, end: 6.0).animate(_controller)
    ..addListener(() {
      setState(() {
        
      });
    });
    _dotAnimation = Tween(begin: 0.0, end: 5.0).animate(_controller)
    ..addListener(() {
      setState(() {
        
      });
    });

    _positionAnimation.addStatusListener((status) { 
      if (status == AnimationStatus.completed) {
        if (_isLoading){
          _controller.reverse();
        }
      } else if (status == AnimationStatus.dismissed) {
        if (_isLoading){
          _controller.forward();
        }
      }
    });
    _controller.forward();
    // _loadData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(alignment: AlignmentDirectional.center, children: [
        Positioned(
          top: screenHeight * 0.25,
          child: Column(
            children: const [
              Image(
                image: AssetImage('assets/icons/icon.png'),
                width: 250,
                height: 250,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: screenHeight * 0.1,
          child: _buildBody()
        ),
      ]),
    );
  }
  Widget _buildBody() {
    if (_isLoading) {
      return Container(
        child: _buildAnimation(),
      );
    } else {
      //Navigate to next page
      Navigator.push(context, MaterialPageRoute(builder: (context) => StartupScreen()));
      return Center(child: Text("Done"));
    }
  }
  Widget _buildAnimation() {
    double circleWidth = 10.0;
    Widget circles = Container(
      // width: circleWidth * 8,
      // height: circleWidth * 2,
      child: Column(
        children: <Widget>[
          Row (
              children: <Widget>[
                for (int i = 0; i < 4; i++)
                  // if ()
                  _buildCircle(circleWidth),
              ],
          ),
        ],
      ),
    );
 
    double positionInNum = _positionAnimation.value;
    return Container(
      child: circles,
    );
  }

  Widget _buildCircle (double circleWidth) { 
    return Container(
      width: circleWidth,
      height: circleWidth,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: Color(0xFF4F4F4F),
        shape: BoxShape.circle,
      ),
    );
  }
}

// class LoadingScreen extends StatelessWidget {
//   final count = 0;
//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: Stack(alignment: AlignmentDirectional.center, children: [
//         Positioned(
//           top: screenHeight * 0.25,
//           child: Column(
//             children: const [
//               Image(
//                 image: AssetImage('assets/icons/icon.png'),
//                 width: 250,
//                 height: 250,
//               ),
//             ],
//           ),
//         ),
//         Positioned(
//           bottom: screenHeight * 0.1,
//           child: Row(
//             children: const [
//               LoadingIcon(),
//               // for (int i = 0; i < 5; i++)
//               //   Container(
//               //     padding: const EdgeInsets.all(5.0),
//               //     margin: const EdgeInsets.symmetric(horizontal: 5.0),
//               //     decoration: BoxDecoration(
//               //       color: Color(0xFF4F4F4F),
//               //       shape: BoxShape.circle,
//               //     ),
//               //   ),
//             ],
//           ),
//         ),
//       ]),
//     );
//   }
// }
