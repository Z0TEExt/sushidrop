import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cal_store.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  Widget buttonCal(String symbol, Color x, VoidCallback func, bool isWhite) {
    return Expanded(
      child: ElevatedButton(
        onPressed: func,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: x,
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.025,
          ),
        ),
        child: Text(
          symbol,
          style: TextStyle(
            fontSize: 30,
            color: isWhite ? Colors.white : Colors.black,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var providerRead = context.read<CalStore>();
    var brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.navigate_before_rounded,
            size: 30,
            color: brightness == Brightness.light
                ? const Color(0xFF505050)
                : Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(right: 25),
                child: Consumer(
                  builder:
                      (BuildContext context, CalStore value, Widget? child) {
                    return Text(
                      value.shownumFunc(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 80,
                      ),
                      maxLines: 1,
                    );
                  },
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buttonCal(
                    providerRead.num1 == '0' || providerRead.sum == 0
                        ? 'AC'
                        : 'C',
                    const Color.fromARGB(255, 200, 200, 200),
                    () => providerRead.resetFunc(),
                    false,
                  ),
                  buttonCal(
                    '+/-',
                    const Color.fromARGB(255, 200, 200, 200),
                    () => providerRead.minustoggleFunc(),
                    false,
                  ),
                  buttonCal(
                    '%',
                    const Color.fromARGB(255, 200, 200, 200),
                    () => providerRead.modFunc(),
                    false,
                  ),
                  buttonCal(
                    '÷',
                    const Color.fromARGB(255, 255, 167, 38),
                    () => providerRead.getopFunc('/'),
                    true,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buttonCal(
                    '7',
                    const Color.fromARGB(255, 50, 50, 50),
                    () => providerRead.getnumFunc(7),
                    true,
                  ),
                  buttonCal(
                    '8',
                    const Color.fromARGB(255, 50, 50, 50),
                    () => providerRead.getnumFunc(8),
                    true,
                  ),
                  buttonCal(
                    '9',
                    const Color.fromARGB(255, 50, 50, 50),
                    () => providerRead.getnumFunc(9),
                    true,
                  ),
                  buttonCal(
                    'x',
                    const Color.fromARGB(255, 255, 167, 38),
                    () => providerRead.getopFunc('x'),
                    true,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buttonCal(
                    '4',
                    const Color.fromARGB(255, 50, 50, 50),
                    () => providerRead.getnumFunc(4),
                    true,
                  ),
                  buttonCal(
                    '5',
                    const Color.fromARGB(255, 50, 50, 50),
                    () => providerRead.getnumFunc(5),
                    true,
                  ),
                  buttonCal(
                    '6',
                    const Color.fromARGB(255, 50, 50, 50),
                    () => providerRead.getnumFunc(6),
                    true,
                  ),
                  buttonCal(
                    '-',
                    const Color.fromARGB(255, 255, 167, 38),
                    () => providerRead.getopFunc('-'),
                    true,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buttonCal(
                    '1',
                    const Color.fromARGB(255, 50, 50, 50),
                    () => providerRead.getnumFunc(1),
                    true,
                  ),
                  buttonCal(
                    '2',
                    const Color.fromARGB(255, 50, 50, 50),
                    () => providerRead.getnumFunc(2),
                    true,
                  ),
                  buttonCal(
                    '3',
                    const Color.fromARGB(255, 50, 50, 50),
                    () => providerRead.getnumFunc(3),
                    true,
                  ),
                  buttonCal(
                    '+',
                    const Color.fromARGB(255, 255, 167, 38),
                    () => providerRead.getopFunc('+'),
                    true,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.04,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.height * 0.225,
                      child: ElevatedButton(
                        onPressed: () => providerRead.getnumFunc(0),
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height * 0.025,
                          ),
                          alignment: Alignment.centerLeft,
                          backgroundColor:
                              const Color.fromARGB(255, 50, 50, 50),
                        ),
                        child: const Text(
                          '0',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),
                  buttonCal(
                    '.',
                    const Color.fromARGB(255, 50, 50, 50),
                    () => providerRead.decimFunc(),
                    true,
                  ),
                  buttonCal(
                    '=',
                    const Color.fromARGB(255, 255, 167, 38),
                    providerRead.calFunc,
                    true,
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
