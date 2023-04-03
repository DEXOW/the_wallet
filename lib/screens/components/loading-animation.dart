import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with SingleTickerProviderStateMixin{
  
  late bool _isLoading;

  late Animation<double> _angleAnimation;
  late Animation<double> _scaleAnimation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _isLoading = true;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _angleAnimation = Tween(begin: 0.0, end: 360.0).animate(_controller)
    ..addListener(() {
      setState(() {
        
      });
    });
    _scaleAnimation = Tween(begin: 0.0, end: 6.0).animate(_controller)
    ..addListener(() {
      setState(() {
        
      });
    });

    _angleAnimation.addStatusListener((status) { 
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
    return Scaffold(
      body: _buildBody(),
    );
  }
  Widget _buildBody() {
    if (_isLoading) {
      return Center(
        child: _buildAnimation(),
      );
    } else {
      return const Center(
        child: Text('Done'),
      );
    }
  }

   Widget _buildAnimation() {
    double circleWidth = 10.0 * _scaleAnimation.value;
    Widget circles = Container(
      width: circleWidth * 2.0,
      height: circleWidth * 2.0,
      child: Column(
        children: <Widget>[
          Row (
              children: <Widget>[
                _buildCircle(circleWidth,Colors.blue),
                _buildCircle(circleWidth,Colors.red),
              ],
          ),
          Row (
            children: <Widget>[
              _buildCircle(circleWidth,Colors.yellow),
              _buildCircle(circleWidth,Colors.green),
            ],
          ),
        ],
      ),
    );
 
    double angleInDegrees = _angleAnimation.value;
    return Container(
        child: circles,
      );
  }
 
  Widget _buildCircle(double circleWidth, Color color) {
    return Container(
      width: circleWidth,
      height: circleWidth,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }

  // Future _loadData() async {
  //   await Future.delayed(const Duration(seconds: 5));
  //   setState(() {
  //     _dataLoaded();
  //   });
  // }

  void _dataLoaded() {
    setState(() {
      _isLoading = false;
    });
  }
}
