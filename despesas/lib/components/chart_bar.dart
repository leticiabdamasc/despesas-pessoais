import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double valor;
  final double percentage;
  const ChartBar({
    Key? key,
    required this.label,
    required this.valor,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20,
          child: FittedBox(
            child: Text(
              '${valor.toStringAsFixed(2)}',
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 60,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: const Color.fromRGBO(220, 220, 200, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                heightFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(label),
      ],
    );
  }
}
