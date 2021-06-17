import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      /* pour des listes de plus de 6 ou 7 éléments utiliser le ListView.builder qui ne charge les éléments qu'avant d'apparaître à l'écran */
      child: transactions.isEmpty //  '?' = si la transaction est vide on affiche text+ image, ':' = sinon on affiche les transactions
          ? Column(children: <Widget>[
              Text(
                'Pas encore de transactions enregistrées !',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox( // permet d'espacer le text de l'image
                height: 20, 
              ),
              Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png', // Image.asset wraped dans un container afin que l'image ne prenne pas toute la place, car sinon dépend du parent column qui demande de prendre le plus de place possible à l'écran
                    fit: BoxFit.cover,
                  )),
            ])
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          //' \$${tx.amount}', // par ce que le signe $ est réservé en dart, il faut ruser (string interpolation) pour afficher un prix en dollar
                          '€' +
                              transactions[index].amount!.toStringAsFixed(
                                  2), //on va rester en Euro nous
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            transactions[index].title!,
                            style: Theme.of(context)
                                .textTheme
                                .headline6, //linké au textTheme dans le main.dart
                          ),
                          Text(
                            DateFormat.yMMMd()
                                .format(transactions[index].date!),
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
