import 'package:flutter/material.dart';

class Bar extends StatelessWidget {
  const Bar(
      {super.key,
      required this.label,
      required this.spendingAmount,
      required this.percentageOfTotal});
  final String label;
  final double spendingAmount;
  final double percentageOfTotal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('R${spendingAmount.toStringAsFixed(0)}'),
        const SizedBox(
          height: 4,
        ),
        SizedBox(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: percentageOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
