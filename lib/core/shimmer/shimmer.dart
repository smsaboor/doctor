import 'package:flutter/material.dart';
import 'skelton.dart';

class ShimmerCategories extends StatelessWidget {
  const ShimmerCategories({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Skeleton(height: 120, width: 120),
        const SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Skeleton(width: 80),
              const SizedBox(height: 16.0 / 2),
              const Skeleton(),
              const SizedBox(height: 16.0 / 2),
              const Skeleton(),
              const SizedBox(height: 16.0 / 2),
              Row(
                children: const [
                  Expanded(
                    child: Skeleton(),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Skeleton(),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}