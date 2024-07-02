import 'package:flutter/material.dart';
import 'package:my_shop/controllers/categories_controller.dart';
import 'package:my_shop/models/category.dart';
import 'package:my_shop/utils/extensions.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Categories
        SizedBox(
          // color: Colors.cyan,
          height: 200,
          child: StreamBuilder(
              stream: context.read<CategoriesController>().categories,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(
                    child: Text("Couldn't fetch categories."),
                  );
                }

                if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("No categories found."),
                  );
                }

                final categories = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category =
                        Kategory.fromQuerySnapshot(categories[index]);
                    return ListTile(
                      leading: Image.network(category.imageUrl),
                      title: Text(category.title),
                      subtitle: Text(category.id),
                    );
                  },
                );
              }),
        ),
        10.height,

        /// Products
        // Expanded(child: StreamBuilder(
        //   stream: context.read<ProductsController>(),
        //   builder: (context, snapshot) {
        //     return ListView.builder(itemBuilder: (context, index) {
        //       return Text('data');
        //     },);
        //   }
        // ))
      ],
    );
  }
}
