import 'package:croppy/src/src.dart';
import 'package:flutter/material.dart';

class CupertinoToolbar extends StatelessWidget {
  const CupertinoToolbar({
    super.key,
    required this.controller,
    this.gesturePadding = 16.0,
    this.transformationOrder,
  });

  final CroppableImageController controller;
  final double gesturePadding;
  final List<Transformation>? transformationOrder;

  @override
  Widget build(BuildContext context) {
    if (controller is! CupertinoCroppableImageController) {
      return CupertinoImageTransformationToolbar(
        controller: controller,
        gesturePadding: gesturePadding,
        transformationOrder: transformationOrder,
      );
    }

    return ValueListenableBuilder(
      valueListenable:
          (controller as CupertinoCroppableImageController).toolbarNotifier,
      builder: (context, toolbar, child) {
        late final Widget child;

        switch (toolbar) {
          case CupertinoCroppableImageToolbar.transform:
            child = CupertinoImageTransformationToolbar(
              controller: controller,
              gesturePadding: gesturePadding,
              transformationOrder: transformationOrder,
            );
            break;
          case CupertinoCroppableImageToolbar.aspectRatio:
            child = CupertinoImageAspectRatioToolbar(
              controller: controller as AspectRatioMixin,
            );
            break;
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          child: child,
        );
      },
    );
  }
}
