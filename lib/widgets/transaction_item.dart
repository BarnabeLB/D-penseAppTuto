import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import'../models/transaction.dart';



class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          //CircleAvatar est un racourci pour un Container dont les bords sont arrondis
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text('€' +
                  transaction.amount!.toStringAsFixed(2)),
            ),
          ),
        ),
        title: Text(
          transaction.title!,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date!),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                icon: const Icon(Icons.delete),
                label: const Text("Supprimer"),
                textColor: Theme.of(context).errorColor,
                onPressed: () => deleteTx(transaction.id),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => deleteTx(transaction.id),
              ),
      ),
    );
     // return Card(
              //   child: Row(
              //     children: <Widget>[
              //       Container(
              //         margin: EdgeInsets.symmetric(
              //           vertical: 10,
              //           horizontal: 15,
              //         ),
              //         decoration: BoxDecoration(
              //           border: Border.all(
              //             color: Theme.of(context).primaryColor,
              //             width: 2,
              //           ),
              //         ),
              //         padding: EdgeInsets.all(10),
              //         child: Text(
              //           //' \$${tx.amount}', // par ce que le signe $ est réservé en dart, il faut ruser (string interpolation) pour afficher un prix en dollar
              //           '€' +
              //               transactions[index].amount!.toStringAsFixed(
              //                   2), //on va rester en Euro nous
              //           style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             fontSize: 20,
              //             color: Theme.of(context).primaryColor,
              //           ),
              //         ),
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: <Widget>[
              //           Text(
              //             transactions[index].title!,
              //             style: Theme.of(context)
              //                 .textTheme
              //                 .headline6, //linké au textTheme dans le main.dart
              //           ),
              //           Text(
              //             DateFormat.yMMMd()
              //                 .format(transactions[index].date!),
              //             style: TextStyle(
              //               color: Colors.grey,
              //             ),
              //           ),
              //         ],
              //       )
              //     ],
              //   ),
              // );
  }
}