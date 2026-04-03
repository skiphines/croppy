import 'package:croppy/croppy.dart';
import 'package:croppy/src/widgets/cupertino/toolbar/cupertino_image_transformation_toolbar.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('normalizeCupertinoTransformationOrder', () {
    test('keeps the default Cupertino order when no override is provided', () {
      final order = normalizeCupertinoTransformationOrder(
        enabledTransformations: [
          Transformation.rotateZ,
          Transformation.rotateX,
          Transformation.rotateY,
          Transformation.stretchX,
          Transformation.stretchY,
          Transformation.homography,
        ],
      );

      expect(order, [
        Transformation.rotateZ,
        Transformation.rotateX,
        Transformation.rotateY,
        Transformation.homography,
        Transformation.stretchX,
        Transformation.stretchY,
      ]);
    });

    test('applies a custom order and appends omitted enabled controls', () {
      final order = normalizeCupertinoTransformationOrder(
        enabledTransformations: [
          Transformation.rotateZ,
          Transformation.rotateX,
          Transformation.rotateY,
          Transformation.stretchX,
          Transformation.homography,
        ],
        transformationOrder: [
          Transformation.homography,
          Transformation.rotateY,
        ],
      );

      expect(order, [
        Transformation.homography,
        Transformation.rotateY,
        Transformation.rotateZ,
        Transformation.rotateX,
        Transformation.stretchX,
      ]);
    });

    test('ignores unsupported and duplicate transformations', () {
      final order = normalizeCupertinoTransformationOrder(
        enabledTransformations: [
          Transformation.rotateZ,
          Transformation.stretchY,
          Transformation.homography,
        ],
        transformationOrder: [
          Transformation.panAndScale,
          Transformation.homography,
          Transformation.homography,
          Transformation.stretchY,
        ],
      );

      expect(order, [
        Transformation.homography,
        Transformation.stretchY,
        Transformation.rotateZ,
      ]);
    });
  });
}
