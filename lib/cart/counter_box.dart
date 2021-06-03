import 'package:flutter/material.dart';

typedef void CountButtonClickCallBack(int count);

class CountButtonView extends StatefulWidget {
  final int initialCount;
  final CountButtonClickCallBack onChange;

  CountButtonView({this.initialCount, this.onChange});

  @override
  _CountButtonViewState createState() => _CountButtonViewState();
}

class _CountButtonViewState extends State<CountButtonView> {
  int count;

  @override
  void initState() {
    super.initState();
    count = widget.initialCount;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void updateCount(int addValue) {
    if (count + addValue >= 0) {
      setState(() {
        count += addValue;
      });
      if (widget.onChange != null) {
        widget.onChange(count);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right:2.0),
      child: SizedBox(
        height: 25,
        width: MediaQuery.of(context).size.width * 0.25,
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xddFFFFFF),
              border: Border.all(color: Color.fromARGB(
                  255, 71, 54, 111), width: 1.0),
              borderRadius: BorderRadius.circular(5.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    updateCount(-1);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: Container(
                        width: (MediaQuery.of(context).size.width * 0.25)/ 3,
                        child: Center(
                            child: Icon(Icons.remove, color: Color.fromARGB(
                            255, 71, 54, 111) )
                        )),
                  )),
              Expanded(
                child: Text("|",
                    style: TextStyle(
                        color: Color.fromARGB(
                            255, 71, 54, 111))),
              ),
              Container(
                child: Center(
                    child: Text(
                  '$count',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(
                          255, 71, 54, 111),
                      decoration: TextDecoration.none),
                )),
              ),
              Text("|",
                  style: TextStyle(
                      color: Color.fromARGB(
                          255, 71, 54, 111))),
              GestureDetector(
                  onTap: () {
                    updateCount(1);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom:2.0),
                    child: Container(
                        width: (MediaQuery.of(context).size.width * 0.25)/ 3,
                        child: Center(
                            child: Icon(Icons.add, color: Color.fromARGB(
                                         255, 71, 54, 111) )

                        )),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
