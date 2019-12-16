import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Split the Bill',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: SplitBill(),
    );
  }
}

class SplitBill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //SplashScreen();
            TitleSection(),
            MyCustomForm2(),
            //FooterSection(),
            //MyImage(),
            MyImageOne(),
          ],
        ),
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          //padding: (EdgeInsets.only(top: 49.0)),
          margin: EdgeInsets.symmetric(
            horizontal: 0.0,
            vertical: 0.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(35.0),
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            //Icon(Icons.attach_money, color: Colors.white,),
                            Text(
                              ' S P L I T   Y O U R   B I L L ',
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'GeoSansLight',
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            //Icon(Icons.attach_money, color: Colors.white),
                          ]),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class MyImageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: CarouselSlider(
          height: 350.0,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          pauseAutoPlayOnTouch: Duration(seconds: 10),
          enlargeCenterPage: true,
          enableInfiniteScroll: true,
          viewportFraction: 1.0,
          autoPlayCurve: Curves.linear,
          aspectRatio: 1,
          items: [
            'assets/h1.png',
            'assets/h3.png',
            'assets/h4.png',
          ].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    child: FittedBox(
                        alignment: Alignment.bottomCenter,
                        fit: BoxFit.contain,
                        child: Image.asset(
                          '$i',
                        )));
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class MyCustomForm2 extends StatefulWidget {
  @override
  MyCustomFormState2 createState() {
    return MyCustomFormState2();
  }
}

class MyCustomFormState2 extends State<MyCustomForm2> {
  final _formKey = GlobalKey<FormState>();

  String _bill = '0';
  String _friend = '0';
  String _tip = '0';
  bool _tipIsGiven = false;

  TextEditingController _controllerBill = TextEditingController(text: '0.0');
  TextEditingController _controllerTip = TextEditingController(text: '0.0');
  TextEditingController _controllerFriend = TextEditingController(text: '0');

  FocusNode _focusNodeBill = FocusNode();
  FocusNode _focusNodeFriend = FocusNode();
  FocusNode _focusNodeTip = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNodeBill.addListener(_handleBillFocus);
    _focusNodeFriend.addListener(_handleFriendFocus);
    _focusNodeTip.addListener(_handleTipFocus);
  }

  void _handleBillFocus() {
    if (_focusNodeBill.hasFocus) {
      setState(() {
        if (_controllerBill.text == '0.0') _controllerBill.text = '';
      });
    } else if (!_focusNodeBill.hasFocus &&
        (_controllerBill.text == '0.0' || _controllerBill.text == '')) {
      setState(() {
        _controllerBill.text = '0.0';
      });
    } else
      setState(() {});
  }

  void _handleFriendFocus() {
    if (_focusNodeFriend.hasFocus) {
      setState(() {
        if (_controllerFriend.text == '0') _controllerFriend.text = '';
      });
    } else if (!_focusNodeFriend.hasFocus &&
        (_controllerFriend.text == '0' || _controllerFriend.text == '')) {
      setState(() {
        _controllerFriend.text = '0';
      });
    } else
      setState(() {});
  }

  void _handleTipFocus() {
    if (_focusNodeTip.hasFocus) {
      setState(() {
        if (_controllerTip.text == '0.0') _controllerTip.text = '';
      });
    } else if (!_focusNodeTip.hasFocus &&
        (_controllerTip.text == '0.0' || _controllerTip.text == '')) {
      setState(() {
        _controllerTip.text = '0.0';
      });
    } else
      setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      //color: Colors.blue.shade50,
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(5.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              billFormField(),
              friendFormField(),
              tipFormField(),
              Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: calculateButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  RaisedButton calculateButton() {
    return RaisedButton(
      onPressed: () {
        _calculator();
      },
      color: Theme.of(context).primaryColor,
      child: Text(
        'S P L I T   I T !',
        style: TextStyle(
            fontSize: 25.0,
            fontFamily: 'GeoSansLight',
            fontWeight: FontWeight.bold),
      ),
      textColor: Colors.white,
    );
  }

  TextFormField billFormField() {
    return TextFormField(
      controller: _controllerBill,
      focusNode: _focusNodeBill,
      keyboardType: TextInputType.number,
      onSaved: (value) {
        _bill = value;
        /*setState(() {

        });*/
      },
      decoration: InputDecoration(
        labelText: 'How much is the total bill?',
        icon: Icon(Icons.monetization_on),
        fillColor: Theme.of(context).primaryColor,
        prefixText: '\$',
      ),
    );
  }

  TextFormField friendFormField() {
    return TextFormField(
      controller: _controllerFriend,
      focusNode: _focusNodeFriend,
      keyboardType: TextInputType.number,
      onSaved: (value) {
        _friend = value;
      },
      decoration: InputDecoration(
        labelText: 'For how many people?',
        icon: Icon(Icons.person_pin),
        fillColor: Theme.of(context).primaryColor,
      ),
    );
  }

  TextFormField tipFormField() {
    return TextFormField(
      controller: _controllerTip,
      focusNode: _focusNodeTip,
      keyboardType: TextInputType.number,
      onSaved: (value) {
        _tipIsGiven = true;
        _tip = value;
      },
      decoration: InputDecoration(
        labelText: 'Feeling generous? Give them a tip!',
        icon: Icon(Icons.insert_emoticon),
        fillColor: Theme.of(context).primaryColor,
        prefixText: '\$',
      ),
    );
  }

  void _calculator() {
    _formKey.currentState.save();
    var _billVal = double.parse(_bill);
    var _friendVal = double.parse(_friend);
    var _tipVal = (_tipIsGiven) ? double.parse(_tip) : 0.0;

    //if (_billVal != 0.0 || )

    _onLoading(_billVal, _friendVal, _tipVal);
  }

  showReceipt(double bill, double friend, [double tip]) {
    double _totalBill = (bill / friend);
    double _totalTip = (_tipIsGiven) ? (tip / friend) : 0.0;

    var _roundedOffBill = _totalBill.toStringAsFixed(2);
    //var _roundedOffTip = _totalTip.toStringAsFixed(2);
    var _billPlusTip = (_totalBill + _totalTip).toStringAsFixed(2);

    if (bill != 0.0 && friend != 0.0 && _totalTip == 0.0) {
      // set up the button
      Widget okButton = FlatButton(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "O K",
            style: TextStyle(
                fontFamily: 'GeoSansLight',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18.0),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
          setState(() {
            _controllerBill.text = '0.0';
            _controllerFriend.text = '0';
            _controllerTip.text = '0.0';
          });
        },
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Text(
            "Y O U R   T O T A L   B I L L", // \$$bill
            style: TextStyle(
                fontFamily: 'GeoSansLight',
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
        ),
        content: Text(
          'You have to pay \$$_roundedOffBill each on your bill. Thank you!',
          //'Your share on tip is \$$_roundedOffTip per person. ',
          softWrap: true,
          textAlign: TextAlign.justify,
        ),
        actions: [
          okButton,
          //tipButton,
        ],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else if (bill != 0.0 && friend != 0.0 && _totalTip != 0.0) {
      // set up the button
      Widget okButton = FlatButton(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "O K",
            style: TextStyle(
                fontFamily: 'GeoSansLight',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18.0),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
          setState(() {
            _controllerBill.text = '0.0';
            _controllerFriend.text = '0';
            _controllerTip.text = '0.0';
          });
        },
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Text(
            "Y O U R   T O T A L   B I L L", // \$$bill
            style: TextStyle(
                fontFamily: 'GeoSansLight',
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
        ),
        content: Text(
          'You have to pay \$$_billPlusTip each on your bill. This will include your tip for them. Thank you!',
          //'Your share on tip is \$$_roundedOffTip per person. ',
          softWrap: true,
          textAlign: TextAlign.justify,
        ),
        actions: [
          okButton,
          //tipButton,
        ],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else if (bill == 0.0 || friend == 0.0) {
      // set up the button
      Widget okButton = FlatButton(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "O K",
            style: TextStyle(
                fontFamily: 'GeoSansLight',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18.0),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
          setState(() {
            _controllerBill.text = '0.0';
            _controllerFriend.text = '0';
            _controllerTip.text = '0.0';
          });
        },
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Padding(
          padding: const EdgeInsets.only(right: 20.0),
        ),
        content: Text(
          'You have to enter valid values for the required fields.',
          softWrap: true,
          textAlign: TextAlign.justify,
        ),
        actions: [
          okButton,
          //tipButton,
        ],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  void _onLoading(_billVal, _friendVal, [_tipVal]) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: new Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: new CircularProgressIndicator(),
                ),
                new Text(
                  "        C A L C U L A T I N G ...",
                  style: TextStyle(fontFamily: 'GeoSansLight'),
                ),
              ],
            ),
          ),
        );
      },
    );
    new Future.delayed(new Duration(seconds: 1), () {
      Navigator.pop(context); //pop dialog
      showReceipt(_billVal, _friendVal, _tipVal);
    });
  }
}
