import 'package:flutter/material.dart';
import 'package:my_ecommerce_delivery/api_links.dart';
import 'package:my_ecommerce_delivery/data/models/items_model.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(
      {super.key,
      required this.item,
      required this.onCartTap,
      required this.amount});
  final ItemModel item;
  final void Function() onCartTap;

  final int amount;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        onTap: onCartTap,
        subtitle: Text(
          "${amount * item.priceAfterDiscount!} (${item.priceAfterDiscount!}) د.ع .",
          style: const TextStyle(fontSize: 16),
        ),
        trailing: Text(amount.toString()),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        // tileColor: Colors.red,
        leading: Image.network(
          "${APILinks.itemImages}/${item.imageUrl!}",
          height: 100,
          width: 50,
        ),
        title: Text(
          item.itemsName!,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
