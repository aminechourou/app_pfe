import 'package:flutter/material.dart';

class NavBarItemUserEval extends StatefulWidget {
  final IconData icon;
  final Function touched;
  final String text;
  final bool active;
  NavBarItemUserEval({
    required this.icon,
    required this.touched,
    required this.active, required this.text,
  });
  @override
  _NavBarItemUserEvalState createState() => _NavBarItemUserEvalState();
}

class _NavBarItemUserEvalState extends State<NavBarItemUserEval> {
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
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          color: widget.active ? Colors.white : Colors.transparent,
          child: Row(
            children: [
              Container(
                height:MediaQuery.of(context).size.height * 0.12,
                width: MediaQuery.of(context).size.width * 0.07,
                child: Column(
                  children: [
                    Column(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 475),
                          height: 5.0,
                          width: MediaQuery.of(context).size.width * 0.07,
                          decoration: BoxDecoration(
                            color: widget.active ? Colors.red : Colors.transparent,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.015),
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
                    Padding(padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.015,),
                      child: Center(child: Expanded(child: Text(widget.text,textAlign: TextAlign.center,))),)
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