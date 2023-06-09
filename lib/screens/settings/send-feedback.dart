import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../components/navbar.dart';
import 'manage-wallet.dart';

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  TextEditingController textEditingController = TextEditingController();
  double rating = 0.0;

  void submitFeedback() {
    String textFieldValue = textEditingController.text;
    print('Feedback: $textFieldValue');
    print('Rating: $rating');

    // Reset the text area and rating bar
    setState(() {
      textEditingController.text = '';
      rating = 0.0;
    });

    // Process the feedback data (e.g., send it to an API)
    // ...

    // Show a success message (optional)
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text('Feedback submitted!'),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          double screenHeight =
              constraints.maxHeight; // Get the height of the safe area
          double screenWidth =
              constraints.maxWidth; // Get the width of the safe area
          return Scaffold(
            resizeToAvoidBottomInset:
                false, //Keyboard doesn't resize the screen
            body: SizedBox(
              //SizedBox to set the height and width of the Page
              height: screenHeight,
              width: screenWidth,
              child: Stack(children: [
                Column(children: [
                  Container(
                    // Top Section
                    height: screenHeight * 0.1,
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(top: 10, left: 20),
                    child: Row(
                      children: [
                        GestureDetector(
                                    onTap: () {
                                      // Add your navigation logic here
                                      // For example, you can use Navigator to navigate to another screen
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ManageWalletScreen()),
                                      );
                                    },
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      size: 30,
                                    ),
                                  ),
                                  SizedBox(width: 1),
                        Container(
                          child: Image(
                            image:
                                AssetImage('assets/icons/Account circle.png'),
                            height: 50,
                            width: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      // Middle section
                      height: screenHeight * 0.9,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(children: [
                        //All your content for the page goes in here (Green zone)
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Send Feedback",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 80),

                        Text(
                          'Say what you think about this app',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 25),
                        Container(
                          //color: Color.fromARGB(255, 192, 192, 192),
                          child: TextField(
                            controller: textEditingController,
                            maxLines: null,
                            decoration: InputDecoration(
                             // hintText: 'Enter text...',
                            ),
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Inter',
                            ), // Replace with your desired font size
                          ),
                        ),

                        // SizedBox(height: 16),
                        // Text(
                        //   'Text Field 2',
                        //   style: TextStyle(
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        // TextField(
                        //   decoration: InputDecoration(
                        //     hintText: 'Enter text...',
                        //   ),
                        // ),
                        SizedBox(height: 50),
                        Text(
                          'How was your experience with us?',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              iconSize: 40,
                              icon: Icon(Icons.star),
                              color: rating >= 1 ? Colors.amber : Colors.grey,
                              onPressed: () {
                                setState(() {
                                  rating = 1.0;
                                });
                              },
                            ),
                            IconButton(
                              iconSize: 40,
                              icon: Icon(Icons.star),
                              color: rating >= 2 ? Colors.amber : Colors.grey,
                              onPressed: () {
                                setState(() {
                                  rating = 2.0;
                                });
                              },
                            ),
                            IconButton(
                              iconSize: 40,
                              icon: Icon(Icons.star),
                              color: rating >= 3 ? Colors.amber : Colors.grey,
                              onPressed: () {
                                setState(() {
                                  rating = 3.0;
                                });
                              },
                            ),
                            IconButton(
                              iconSize: 40,
                              icon: Icon(Icons.star),
                              color: rating >= 4 ? Colors.amber : Colors.grey,
                              onPressed: () {
                                setState(() {
                                  rating = 4.0;
                                });
                              },
                            ),
                            IconButton(
                              iconSize: 40,
                              icon: Icon(Icons.star),
                              color: rating >= 5 ? Colors.amber : Colors.grey,
                              onPressed: () {
                                setState(() {
                                  rating = 5.0;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: submitFeedback,
                          child: Text('Submit'),
                        ),
                      ]))
                ]),
                Positioned(
                  //Navbar
                  bottom: 0,
                  child: Navbar(currentPage: 'settings'),
                ),
              ]),
            ),
          );
        }),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// import '../components/navbar.dart';
// import 'manage-wallet.dart';

// class FeedbackScreen extends StatefulWidget {
//   const FeedbackScreen({Key? key}) : super(key: key);

//   @override
//   _FeedbackScreenState createState() => _FeedbackScreenState();
// }

// class _FeedbackScreenState extends State<FeedbackScreen> {
//   bool showDropdown = false;
//   TextEditingController feedbackController1 = TextEditingController();
//   TextEditingController feedbackController2 = TextEditingController();
//   RatingBarControler _ratingBarController = RatingBarControler();

//   @override
//   void dispose() {
//     feedbackController1.dispose();
//     feedbackController2.dispose();
//     super.dispose();
//   }

//   void submitFeedback() {
//     String feedbackText1 = feedbackController1.text;
//     String feedbackText2 = feedbackController2.text;

//     // Perform actions with the entered feedback text
//     print('Feedback 1: $feedbackText1');
//     print('Feedback 2: $feedbackText2');

//     // Clear the text boxes after submission
//     feedbackController1.clear();
//     feedbackController2.clear();

//     _ratingBarController.reset(); // Reset the rating bar
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SafeArea(
//         child: LayoutBuilder(
//           builder: (BuildContext context, BoxConstraints constraints) {
//             double screenHeight = constraints.maxHeight;
//             double screenWidth = constraints.maxWidth;
//             return Scaffold(
//               resizeToAvoidBottomInset: false,
//               body: SizedBox(
//                 height: screenHeight,
//                 width: screenWidth,
//                 child: Stack(
//                   children: [
//                     Column(
//                       children: [
//                         Container(
//                           height: screenHeight * 0.1,
//                           alignment: Alignment.topLeft,
//                           padding: EdgeInsets.only(top: 10, left: 20),
//                           child: Row(
//                             children: [
//                               Container(
//                                 child: Image(
//                                   image: AssetImage(
//                                       'assets/icons/Account circle.png'),
//                                   height: 50,
//                                   width: 50,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           height: screenHeight * 0.9,
//                           margin: EdgeInsets.symmetric(horizontal: 40),
//                           child: Column(
//                             children: [
//                               Container(
//                                 margin: EdgeInsets.only(bottom: 80),
//                                 child: Row(
//                                   children: [
//                                     GestureDetector(
//                                       onTap: () {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 ManageWalletScreen(),
//                                           ),
//                                         );
//                                       },
//                                       child: Icon(
//                                         Icons.arrow_back_ios,
//                                         size: 30,
//                                       ),
//                                     ),
//                                     SizedBox(width: 1),
//                                     Expanded(
//                                       child: Text(
//                                         "Send Feedback",
//                                         style: TextStyle(
//                                           fontSize: 30,
//                                           fontFamily: 'Inter',
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                         textAlign: TextAlign.center,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 margin: EdgeInsets.symmetric(vertical: 10),
//                                 child: ConstrainedBox(
//                                   constraints: BoxConstraints(
//                                     minHeight: 40,
//                                   ),
//                                   child: TextField(
//                                     controller: feedbackController1,
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontFamily: 'Inter',
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.black,
//                                     ),
//                                     maxLines: null,
//                                     decoration: InputDecoration(
//                                       labelText:
//                                           'Say what you think about this app',
//                                       filled: true,
//                                       fillColor: Color.fromARGB(
//                                           255, 192, 192, 192),
//                                       isDense: true,
//                                       contentPadding: EdgeInsets.symmetric(
//                                         vertical: 20,
//                                         horizontal: 15,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 margin: EdgeInsets.symmetric(vertical: 10),
//                                 child: TextField(
//                                   controller: feedbackController2,
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontFamily: 'Inter',
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black,
//                                   ),
//                                   maxLines: null,
//                                   decoration: InputDecoration(
//                                     labelText: 'Feedback 2',
//                                     filled: true,
//                                     fillColor: Color.fromARGB(
//                                         255, 192, 192, 192),
//                                     isDense: true,
//                                     contentPadding: EdgeInsets.symmetric(
//                                       vertical: 20,
//                                       horizontal: 15,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(height: 20),
//                               RatingBar.builder(
//                                 initialRating: 0,
//                                 minRating: 0,
//                                 maxRating: 5,
//                                 direction: Axis.horizontal,
//                                 allowHalfRating: false,
//                                 itemCount: 5,
//                                 itemSize: 40,
//                                 itemBuilder: (context, _) => Icon(
//                                   Icons.star,
//                                   color: Colors.amber,
//                                 ),
//                                 onRatingUpdate: (rating) {
//                                   _ratingBarController.setRating(rating);
//                                 },
//                               ),
//                               SizedBox(height: 20),
//                               ElevatedButton(
//                                 onPressed: submitFeedback,
//                                 child: Text('Submit'),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       child: Navbar(currentPage: 'settings'),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class RatingBarControler {
//   double _rating = 0;

//   double get rating => _rating;

//   void setRating(double rating) {
//     _rating = rating;
//   }

//   void reset() {
//     _rating = 0;
//   }
// }
