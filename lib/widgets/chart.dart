import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions) {
    print("Constructor Chart");
  }

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        //on donne à la variable weekDay la valeur date d'aujourd'hui, cette valeur change si on change de jour
        Duration(
            days:
                index), // days est initialisé à 0, sera soustraint ainsi 1, si on change de jour
      );
      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        // si les transactions à un index donnée sont faites le même jour, mois et année que la date stockée dans la variable weekDay
        if (recentTransactions[i].date!.day == weekDay.day &&
            recentTransactions[i].date!.month == weekDay.month &&
            recentTransactions[i].date!.year == weekDay.year) {
          totalSum += recentTransactions[i]
              .amount!; //alors la variable totalSum reçoit la valeur de la transaction à l'index donnée
        }
      }

      return {
        'jour': DateFormat.E().format(weekDay),
        /*.substring(0,1),*/
        'montant': totalSum
      }; // on retourne la date et le montant autant de fois que la List le demande (return dans un return)
    })
        .reversed
        .toList(); // .reserverd.toList() inverse l'ordre de la liste généré et met ainsi les jour les plus ancien à gauche
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['montant'] as num);
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build() Chart ");

    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                (data['jour'] as String),
                (data['montant'] as double),
                totalSpending == 0.0
                    ? 0.0
                    : (data['montant'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
