import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_project/screens/home/cubit/news_cubit.dart';

class CategoryButton extends StatelessWidget {
  final String text;

  const CategoryButton({super.key, required this.text});

  bool isSelected(BuildContext context) =>
      context.read<NewsCubit>().state.selectedCategory == text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        context.read<NewsCubit>().selectedCategory(text);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 2,
        ),
        decoration: BoxDecoration(
          color: isSelected(context) ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.grey.shade900,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
