import 'package:flutter/material.dart';

class NavBarItem extends StatefulWidget {
  final IconData icon;
  final Function touched;
  final String text;
  final bool active;
  NavBarItem({
    required this.icon,
    required this.touched,
    required this.active, required this.text,
  });
  @override
  _NavBarItemState createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {

          widget.touched();
        },
        splashColor: Colors.red,
        hoverColor: Colors.grey.shade200,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 3.0),
          child: Row(
            children: [
              Container(
                height: 60.0,
                width: MediaQuery.of(context).size.width * 0.07,
                child: Column(
                  children: [
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 475),
                          height: 35.0,
                          width: 5.0,
                          decoration: BoxDecoration(
                            color: widget.active ? Colors.red : Colors.transparent,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.025),
                          child: Center(
                            child: Icon(
                              widget.icon,
                              color: widget.active ? Colors.red : Colors.black,
                              size: 19.0,
                            ),
                          ),
                        ),

                      ],
                    ),
                    Padding(padding: const EdgeInsets.only(left: 0.0),
                    child:  Text(widget.text,textAlign: TextAlign.center,style: TextStyle(fontSize: 10),))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}