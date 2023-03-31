import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task/provider/product_provider.dart';
import 'package:task/view/home/components/product_card.dart';
import 'package:task/view/product_details/details_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final List<String> categories = [
    "electronics",
    "jewelery",
    "men's clothing",
    "women's clothing"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          color: Colors.grey,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            color: Colors.grey,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined),
            color: Colors.grey,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Home',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black54,
                fontSize: 25,
              ),
            ),
            Container(
              height: 30,
              margin: const EdgeInsets.only(top: 20, bottom: 15),
              child: FutureBuilder(
                  future: Provider.of<ProductProvider>(context, listen: false)
                      .getCategories(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return ListView.separated(
                          itemCount: 10,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 30,
                            );
                          },
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Colors.grey,
                                  highlightColor:
                                      const Color.fromRGBO(93, 139, 180, 1),
                                  child: const Text(
                                    'Category',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Shimmer.fromColors(
                                  baseColor: Colors.grey,
                                  highlightColor:
                                      const Color.fromRGBO(93, 139, 180, 1),
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 5), //top padding 5
                                    height: 2,
                                    width: 30,
                                  ),
                                )
                              ],
                            );
                          },
                        );

                      case ConnectionState.done:
                      default:
                        if (snapshot.hasData) {
                          final data = snapshot.data!;
                          return Consumer<ProductProvider>(
                              builder: (context, provider, child) {
                            return ListView.separated(
                              itemCount: data.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  width: 30,
                                );
                              },
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    provider.updateCategory(data[index]);
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data[index],
                                        style: TextStyle(
                                          color:
                                              data[index] == provider.category
                                                  ? Colors.black54
                                                  : Colors.grey.shade400,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 5), //top padding 5
                                        height: 2,
                                        width: 30,
                                        color: data[index] == provider.category
                                            ? Colors.black
                                            : Colors.transparent,
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          });
                        } else {
                          return const Center(
                            child: Text('error'),
                          );
                        }
                    }
                  }),
            ),
            Expanded(
              child: Consumer<ProductProvider>(
                builder: (context, provider, child) {
                  return provider.category == null
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(93, 139, 180, 1),
                          ),
                        )
                      : FutureBuilder(
                          future: provider.getProducts(),
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Color.fromRGBO(93, 139, 180, 1),
                                  ),
                                );
                              case ConnectionState.done:
                              default:
                                if (snapshot.hasData) {
                                  final data = snapshot.data!;
                                  return GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 0.7),
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailsScreen(
                                                product: data[index],
                                              ),
                                            ),
                                          );
                                        },
                                        child: ProductCard(
                                          name: data[index].title!,
                                          price: data[index].price!.toString(),
                                          image: data[index].image!,
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return const Center(
                                    child: Text('error'),
                                  );
                                }
                            }
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
