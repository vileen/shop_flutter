import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/product_details.dart';

class ProductItem extends StatelessWidget {
//  final String id;
//  final String title;
//  final String imageUrl;
//
//  ProductItem({
//    this.id,
//    this.title,
//    this.imageUrl,
//  });

  @override
  Widget build(BuildContext context) {
    // listen: false because we don't want to update the whole page on product change
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailsScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          // Customer allows to update only relevant part of the page
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              onPressed: () => product.toggleFavoriteStatus(),
              color: Theme.of(context).accentColor,
            ),
//            this child will be passed to the builder as a third parameter to use within the widget which wouldn't rebuild
//            child: Text('Never changes!'),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
