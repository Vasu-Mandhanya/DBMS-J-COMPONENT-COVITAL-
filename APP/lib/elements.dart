import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LiveDataContainer extends StatelessWidget {
  const LiveDataContainer({
    Key key,
    @required this.size,
    @required this.value,
    @required this.tag,
    @required this.iconName,
    @required this.valueColor,
    @required this.tagColor,
  }) : super(key: key);

  final Size size;
  final String value;
  final String tag;
  final String iconName;
  final Color valueColor;
  final Color tagColor;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: size.height * 0.16,
        minWidth: size.width * 0.221,
      ),
      child: Container(
        height: size.height * 0.16,
        width: size.width * 0.221,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(2, 3),
              blurRadius: 2.5,
            ),
          ],
          border: Border.all(
            color: Color(0xFFACB3BA),
            width: 1.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.0162,
              ),
              SvgPicture.asset(
                "assets/svg/$iconName.svg",
                height: size.height * 0.045,
                width: size.height * 0.045,
              ),
              SizedBox(
                height: size.height * 0.010,
              ),
              Flexible(
                child: Text(
                  '$value',
                  style: TextStyle(
                    color: valueColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                    fontSize: size.height * 0.02,
                  ),
                ),
              ),
              Spacer(),
              Text(
                '$tag',
                style: TextStyle(
                  color: tagColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  fontSize: size.height * 0.015,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OurServices extends StatelessWidget {
  const OurServices({
    Key key,
    @required this.size,
    @required this.icon,
    @required this.tag1,
    @required this.tag2,
    this.referTo,
  }) : super(key: key);

  final Size size;
  final String icon;
  final String tag1;
  final String tag2;
  final String referTo;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.13,
      width: size.width * 0.221,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 3),
            blurRadius: 2.5,
          ),
        ],
        border: Border.all(
          color: Color(0xFFACB3BA),
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/svg/$icon.svg",
            height: size.height * 0.05,
            width: size.height * 0.05,
          ),
          SizedBox(
            height: size.height * 0.010,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: '$tag1',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: size.height * 0.015,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: '\n$tag2',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: size.height * 0.015,
                          fontWeight: FontWeight.bold)),
                ]),
          ),
        ],
      ),
    );
  }
}

class InfoPageTabs extends StatelessWidget {
  const InfoPageTabs({
    Key key,
    @required this.size,
    @required this.title,
    @required this.tag,
    @required this.icon,
  }) : super(key: key);

  final Size size;
  final String title;
  final String tag;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size.height * 0.151,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: double.infinity,
                color: Color(0xFF8368CF),
                child: SvgPicture.asset(
                  "assets/svg/$icon.svg",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                height: double.infinity,
                color: Color(0xFFEFF6FF),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          '$title',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w900,
                            fontSize: size.height * 0.03,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Flexible(
                        child: Text(
                          '$tag',
                          style: TextStyle(
                            fontFamily: 'Martel',
                            color: Color(0xFFB79191),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class CardButtons extends StatelessWidget {
  const CardButtons({
    Key key,
    @required this.size,
    @required this.tag,
    @required this.value,
  }) : super(key: key);

  final Size size;
  final String tag;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: size.height * 0.1,
        decoration: BoxDecoration(
            color: Color(0xFFFAE1E1),
            border: Border(
                right: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$tag',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SingleChildScrollView(
                    child: (value <= 99999999 && value > 0)
                        ? Text(
                            '${value.toString()}',
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w800,
                            ),
                          )
                        : Text(
                            'INVALID',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w800,
                            ),
                          )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Hospitals extends StatelessWidget {
  Hospitals({
    Key key,
    this.size,
    this.name,
    this.address,
    this.otherServices,
    this.availableBeds,
    this.pricePerBed,
    this.contactNumber,
  }) : super(key: key);

  final Size size;
  String imgUrl;
  String name;
  String address;
  String otherServices;
  int availableBeds;
  int pricePerBed;
  int contactNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      child: Material(
        elevation: 10,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 25,
          ),
          child: Column(
            children: [
              //Text(snapshot.data[index].name),

              //hospital name and address
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 25,
                ),
                child: Container(
                  color: Color(0xFFEFF6FF),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                '$name', //{snapshot.data[index].name}'
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Spacer(),
                            (otherServices ==
                                    "True") //{snapshot.data[index].name}'
                                ? Row(
                                    children: [
                                      SvgPicture.asset("assets/svg/tick1.svg"),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Other services\nare available',
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                : (otherServices == "False")
                                    ? Row(
                                        children: [
                                          SvgPicture.asset(
                                              "assets/svg/delete1.svg"),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                'Other services\nare not available',
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                'Other services\ndetail not known',
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          '$address', //snapshot.data[index].address
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              Row(
                children: [
                  CardButtons(
                    size: size,
                    tag: 'Available Beds',
                    value: availableBeds, //snapshot.data[index].availableBeds
                  ),
                  CardButtons(
                    size: size,
                    tag: 'Price per day (Rs.)',
                    value: pricePerBed,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        print(contactNumber.toString());
                      },
                      child: Container(
                          height: size.height * 0.1,
                          color: Color(0xFFDBB963),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.call,
                                color: Colors.white,
                              )
                            ],
                          )),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
