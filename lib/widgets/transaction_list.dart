import 'package:flutter/material.dart';
import '../models/transaction.dart';

import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    print("build() TransactionList");
    /* pour des listes de plus de 6 ou 7 éléments utiliser le ListView.builder qui ne charge les éléments qu'avant d'apparaître à l'écran */
    return transactions
            .isEmpty //  '?' = si la transaction est vide on affiche text+ image, ':' = sinon on affiche les transactions
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'Pas encore de transactions enregistrées !',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  // permet d'espacer le text de l'image
                  height: 20,
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png', // Image.asset wraped dans un container afin que l'image ne prenne pas toute la place, car sinon dépend du parent column qui demande de prendre le plus de place possible à l'écran
                      fit: BoxFit.cover,
                    )),
              ],
            );
          })
        : ListView.builder(
            
            itemBuilder: (context, index) {
              return TransactionItem(transaction: transactions[index], deleteTx: deleteTx);
             
            },
            itemCount: transactions.length,
          );
  }
}

