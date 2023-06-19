import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

import 'package:the_wallet/screens/components/global.dart';


Widget boldText (String text){
  return Text(
    text,
    style: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
  );
}

Widget stdCardView({required Map<String, dynamic> cardData}){
  frequentCards(cardData['cardId']);
  return Container(
    width: 300,
    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
    decoration: const BoxDecoration(
      color: Color(0xFF7574C4),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    child: FittedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Student Identity Card',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Container(
            constraints: const BoxConstraints(maxWidth: 200),
            child: Text(
              cardData['institute']['name'],
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: const Icon(
              Icons.person,
              size: 60,
              color: Color(0xFF7574C4),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Table(
                        columnWidths: const {
                          0: FixedColumnWidth(70),
                          1: FixedColumnWidth(10),
                          2: FixedColumnWidth(120),
                        },
                        children: [
                          TableRow(
                            children: [
                              boldText('ID No'),
                              boldText(':'),
                              Text(cardData['idPassport']),
                            ]
                          ),
                          TableRow(
                            children: [
                              boldText('Name'),
                              boldText(':'),
                              Text(cardData['name']),
                            ]
                          ),
                          TableRow(
                            children: [
                              boldText('Student No'),
                              boldText(':'),
                              Text(cardData['stdNo']),
                            ]
                          ),
                          TableRow(
                            children: [
                              boldText('Batch No'),
                              boldText(':'),
                              Text(cardData['batNo']),
                            ]
                          ),
                          TableRow(
                            children: [
                              boldText('Expiry Date'),
                              boldText(':'),
                              Text((cardData['expDate'] as Timestamp).toDate().toString().substring(0, 10).split('-').join(' - ')),
                            ]
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            child: BarcodeWidget(
              barcode: Barcode.qrCode(),
              data: cardData.toString(),
              errorBuilder: (context, error) => const Text('Qr code error'),
              height: 100,
            ),
          ),
        ]
      ),
    ),
  );
}

Widget stdCardTemplate({required Map<String, dynamic> cardData}){
  return Container(
    height: 180,
    width: 300,
    margin: const EdgeInsets.only(bottom: 20),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    decoration: const BoxDecoration(
      color: Color(0xFF7574C4),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const Text(
              'Student Identity Card',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              cardData['name'],
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: const Icon(
                Icons.person,
                size: 30,
                color: Color(0xFF7574C4),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  child: Table(
                    columnWidths: const {
                      0: FixedColumnWidth(70),
                      1: FixedColumnWidth(10),
                      2: FixedColumnWidth(100),
                    },
                    children: [
                      TableRow(
                        children: [
                          boldText('Student No'),
                          boldText(':'),
                          Text(cardData['stdNo']),
                        ]
                      ),
                      TableRow(
                        children: [
                          boldText('Batch No'),
                          boldText(':'),
                          Text(cardData['batNo']),
                        ]
                      ),
                      TableRow(
                        children: [
                          boldText('Expiry Date'),
                          boldText(':'),
                          Text((cardData['expDate'] as Timestamp).toDate().toString().substring(0, 10).split('-').join(' - ')),
                        ]
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        DefaultTextStyle(
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(cardData['institute']['abbv']),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget nicCardView({required Map<String, dynamic> cardData}){
  frequentCards(cardData['cardId']);
  return Container(
    width: 300,
    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
    decoration: const BoxDecoration(
      color: Color(0xFFD7C790),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    child: FittedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'National Identity Card',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFF4F4F4F),
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: const Icon(
              Icons.person,
              size: 60,
              color: Color(0xFFD7C790),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RotatedBox(
                quarterTurns: 1,
                child: Column(
                  children: [
                    BarcodeWidget(
                      barcode: Barcode.code128(),
                      data: cardData['serialNo'],
                      errorBuilder: ((context, error) => Center(child: Text(error),)),
                      color: Colors.black,
                      drawText: false,
                      height: 25,
                      width: 150,
                    ),
                    Text(
                      cardData['serialNo'],
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
                child: Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Table(
                    columnWidths: const {
                      0: FixedColumnWidth(50),
                      1: FixedColumnWidth(10),
                      2: FixedColumnWidth(120),
                    },
                    children: [
                      TableRow(
                        children: [
                          boldText('NIC No'),
                          boldText(':'),
                          Text(cardData['idNo']),
                        ]
                      ),
                      TableRow(
                        children: [
                          boldText('Name'),
                          boldText(':'),
                          Text(cardData['name']),
                        ]
                      ),
                      TableRow(
                        children: [
                          boldText('Date Of Birth'),
                          boldText(':'),
                          Text((cardData['dob'] as Timestamp).toDate().toString().substring(0, 10).split('-').join(' - ')),
                        ]
                      ),
                      TableRow(
                        children: [
                          boldText('Gender'),
                          boldText(':'),
                          Text("${cardData['gender'][0].toUpperCase()}${cardData['gender'].substring(1).toLowerCase()}"),
                        ]
                      ),
                      TableRow(
                        children: [
                          boldText('Place Of Birth'),
                          boldText(':'),
                          Text(cardData['placeOfBirth']),
                        ]
                      ),
                      TableRow(
                        children: [
                          boldText('Address'),
                          boldText(':'),
                          Text('${cardData['address']['address1']}, ${cardData['address']['address2']}, ${cardData['address']['city']}'),
                        ]
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            child: BarcodeWidget(
              barcode: Barcode.qrCode(),
              data: cardData.toString(),
              errorBuilder: (context, error) => const Text('Qr code error'),
              height: 100,
            ),
          ),
          Text(
            'Date Of Issue : ${(cardData['doi'] as Timestamp).toDate().toString().substring(0, 10).split('-').join(' - ')}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ]
      ),
    ),
  );
}

Widget nicCardTemplate({required Map<String, dynamic> cardData}){
  return Container(
    height: 180,
    width: 300,
    margin: const EdgeInsets.only(bottom: 20),
    padding: const EdgeInsets.all(20),
    decoration: const BoxDecoration(
      color: Color(0xFFD7C790),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cardData['country']['shortCode'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'National Identity Card',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  cardData['country']['dialCode'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Text(
              cardData['name'],
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Color(0xFF4F4F4F),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: const Icon(
                Icons.person,
                size: 30,
                color: Color(0xFFD7C790),
              ),
            ),
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
              child: Table(
                columnWidths: const {
                  0: FixedColumnWidth(50),
                  1: FixedColumnWidth(10),
                  2: FixedColumnWidth(120),
                },
                children: [
                  TableRow(
                    children: [
                      boldText('NIC No'),
                      boldText(':'),
                      Text(cardData['idNo']),
                    ]
                  ),
                  TableRow(
                    children: [
                      boldText('City'),
                      boldText(':'),
                      Text(cardData['address']['city']),
                    ]
                  ),
                  TableRow(
                    children: [
                      boldText('Dob'),
                      boldText(':'),
                      Text((cardData['dob'] as Timestamp).toDate().toString().substring(0, 10).split('-').join(' - ')),
                    ]
                  ),
                ],
              ),
            ),
          ],
        ),
        DefaultTextStyle(
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Date Of Issue: ${(cardData['doi'] as Timestamp).toDate().toString().substring(0, 10).split('-').join('/')}'),
              Text(cardData['serialNo'])
            ],
          ),
        )
      ],
    ),
  );
}