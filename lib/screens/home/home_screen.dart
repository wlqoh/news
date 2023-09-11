import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_project/screens/home/cubit/news_cubit.dart';
import 'package:news_project/screens/home/widgets/category_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            print(state.status);
            if (state.status == NewsStatus.initial) {
              context.read<NewsCubit>().fetch();
            }
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.categories.length,
                      itemBuilder: (context, index) {
                        return CategoryButton(text: state.categories[index]);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 60);
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(child: Builder(builder: (context) {
                    if (state.status == NewsStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            height: 170,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.items[index].title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 15,
                                        ),
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const Spacer(),
                                      if (state.items[index].author != null)
                                        Text(
                                          state.items[index].author!,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      if (state.items[index].publishedAt !=
                                          null)
                                        Text(
                                          '${state.items[index].publishedAt!.substring(0, 10)} '
                                          '${state.items[index].publishedAt!.substring(11, 19)}',
                                          maxLines: 1,
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20),
                                if (state.items[index].imageUrl != null)
                                  LayoutBuilder(
                                      builder: (context, constraints) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        state.items[index].imageUrl!,
                                        errorBuilder: (context, error, stack) {
                                          print(error);
                                          return const Placeholder(
                                              fallbackWidth: 150);
                                        },
                                        width: 150,
                                        height: constraints.maxHeight,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  })
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 10);
                        },
                        itemCount: state.items.length);
                  }))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
