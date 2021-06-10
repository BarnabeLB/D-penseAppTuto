import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTx;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.addTx);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Titre'),
              controller:
                  titleController, /* enregistrement des données du clavier dans la propriété titleController, 
                                                  pas besoin de crééer une fonction sur onChanged ici */
              // onChanged: (value) {
              //   titleInput = value;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Montant'),
              controller: amountController,
              //  onChanged: (value) => amountInput = value,
            ),
            FlatButton(
              textColor: Colors.purple,
              child: Text('Ajouter Transaction'),
              onPressed: () {
                addTx(
                  titleController.text,
                  double.parse(amountController.text),
                ); /* double.parse() convertie un nombre écrit dans une string pour un double, ne peut pas convertir des lettres*/
              },
            )
          ],
        ),
      ),
    );
  }
}
