import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/app/progress_button.dart';

class ProductDetails extends StatelessWidget {
  final ProductEntity product;
  final Function onDelete;
  final Function(ProductEntity, BuildContext) onSaveClicked;
  final bool isLoading;
  final bool isDirty;

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ProductDetails({
    Key key,
    @required this.product,
    @required this.onDelete,
    @required this.onSaveClicked,
    @required this.isLoading,
    @required this.isDirty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final localizations = ArchSampleLocalizations.of(context);

    String _productKey;
    String _notes;
    double _cost;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.id > 0 ? product.productKey : 'New Product'), // Text(localizations.productDetails),
        actions: [
          /*
          IconButton(
            //tooltip: localizations.deleteProduct,
            //key: ArchSampleKeys.deleteProductButton,
            icon: Icon(Icons.delete),
            onPressed: () {
            },
          )
          */
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              elevation: 2.0,
              margin: EdgeInsets.all(0.0),
              child: Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        autocorrect: false,
                        onSaved: (value) => _productKey = value,
                        initialValue: product.productKey,
                        decoration: InputDecoration(
                          //border: InputBorder.none,
                          labelText: 'Product',
                        ),
                      ),
                      TextFormField(
                        initialValue: product.notes,
                        onSaved: (value) => _notes = value,
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: 'Notes',
                        ),
                      ),
                      TextFormField(
                        initialValue: product.cost > 0 ? product.cost.toStringAsFixed(2) : null,
                        onSaved: (value) => _cost = double.tryParse(value) ?? 0.0,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          //border: InputBorder.none,
                          labelText: 'Cost',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            new Builder(
              builder: (BuildContext context) {
                return ProgressButton(
                  label: 'SAVE',
                  isLoading: this.isLoading,
                  isDirty: this.isDirty,
                  onPressed: () {
                    _formKey.currentState.save();
                    this.onSaveClicked(product.rebuild((b) => b
                      ..productKey = _productKey.trim()
                      ..notes = _notes.trim()
                      ..cost = _cost
                    ), context);
                  },
                );
              }
            ),
          ]
        ),
      ),
      /*
      floatingActionButton: FloatingActionButton(
        key: ArchSampleKeys.editProductFab,
        tooltip: localizations.editProduct,
        child: Icon(Icons.edit),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return EditProduct(
                  product: product,
                );
              },
            ),
          );
        },
      ),
      */
    );
  }
}
