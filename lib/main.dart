import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  double _width = 0;
  String _result = '0';
  String _operation;
  double _first;
  double _second;

  Widget _oper(String txt){
    return Expanded(
      child: Material(
        color: Color.fromRGBO(99, 99, 99, 1.0),
        child: InkWell(
          onTap: (){
            if(_second != null) return;
            if(_result != '0') {
              _operation = txt;
              _first = double.parse(_result);
            }
          },
          borderRadius: BorderRadius.all(Radius.circular(90.0)),
          child: Center(
            child: Text(
              txt,
              style: TextStyle(color: Colors.white, fontSize: _width-40),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _btn(String txt){
    return Expanded(
      child: Material(
        color: Color.fromRGBO(67, 67, 67, 1.0),
        child: InkWell(
          onTap: (){
            if(_first == null) {
              _result = '0';
              _first = 0;
            }
            if(_operation != null && _second == null) {
              _result = '0';
              _second = 0;
            }
            if(_result == '0') _result = '';
            _result = _result + txt;
            setState((){});
          },
          borderRadius: BorderRadius.all(Radius.circular(90.0)),
          child: Center(
            child: Text(
              txt,
              style: TextStyle(color: Colors.white, fontSize: _width-40, fontFamily: 'Montserrat-Medium'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _res(){
    return Expanded(
      child: Material(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(45.0)),
        color: Color.fromRGBO(99, 99, 99, 1.0),
        child: InkWell(
          onTap: (){
            if(_first == null || _second == null || _operation == null) return;
            double res;
            _second = double.parse(_result);
            switch(_operation){
              case '÷': _second == 0 ? res = _first : res = _first / _second; break;
              case '×': res = _first * _second; break;
              case '-': res = _first - _second; break;
              case '+': res = _first + _second;
            }
            _result = res.toStringAsFixed(2).toString();
            if (_result.substring(_result.length-2) == '00') _result = res.toStringAsFixed(0).toString();
            _first = null;
            _second = null;
            _operation = null;
            setState((){});
          },
          borderRadius: BorderRadius.only(topLeft: Radius.circular(45.0)),
          child: Center(
            child: Text(
              '=',
              style: TextStyle(color: Colors.white, fontSize: _width-40, fontFamily: 'Montserrat-Medium'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _del(){
    return Expanded(
      child: Material(
        borderRadius: BorderRadius.only(topRight: Radius.circular(45.0)),
        color: Color.fromRGBO(252, 137, 2, 1.0),
        child: InkWell(
          onTap: (){
            _result = '0';
            _first = null;
            _second = null;
            _operation = null;
            setState((){});
          },
          borderRadius: BorderRadius.only(topRight: Radius.circular(45.0)),
          splashColor: Color.fromRGBO(254, 182, 92, 1.0),
          highlightColor: Color.fromRGBO(254, 182, 92, 0.7),
          child: Center(
            child: Text(
              'C',
              style: TextStyle(color: Colors.white, fontSize: _width-40, fontFamily: 'Montserrat-Medium'),
            ),
          ),
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width/3;
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Container(
                    alignment: AlignmentDirectional.centerEnd,
                    width: _width*3-20.0,
                    child: Text(
                      _result,
                      style: TextStyle(color: Colors.black87, fontSize: _width-30),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                    ),
                  ),
                ),
              )
            ),
            Row(
              children: <Widget>[
                _oper('÷'), _oper('×'), _oper('-'), _oper('+')
              ],
            ),
            Row(
              children: <Widget>[
                _btn('9'), _btn('8'), _btn('7')
              ],
            ),
            Row(
              children: <Widget>[
                _btn('6'), _btn('5'), _btn('4')
              ],
            ),
            Row(
              children: <Widget>[
                _btn('3'), _btn('2'), _btn('1')
              ],
            ),
            Container(
              color: Color.fromRGBO(67, 67, 67, 1.0),
              child: Row(
                children: <Widget>[
                  _del(), _btn('0'), _res()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
