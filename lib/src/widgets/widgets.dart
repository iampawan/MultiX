import 'package:flutter/material.dart';
import 'package:multi_x/src/extension.dart';
import 'package:multi_x/src/responsive.dart';

import 'conditional.dart';

/// MxDevice widget can be used for making responsive apps based on if it's mobile or web.
/// In case, if you want more options based on window size, use [MxResponsive].
/// You can specify two widgets depends on the screen size  [mobile] and [web].
/// They must not be null.
class MxDevice extends StatelessWidget {
  ///
  /// For mobile size window
  ///
  final Widget mobile;

  ///
  /// For non - mobile size window
  ///
  final Widget web;

  const MxDevice({super.key, required this.mobile, required this.web});
  @override
  Widget build(BuildContext context) {
    return MxConditionalSwitch.single(
      context: context,
      valueBuilder: (context) => context.mxWindowSize,
      caseBuilders: {MxWindowSize.xsmall: (context) => mobile},
      fallbackBuilder: (context) => web,
    )!;
  }
}

/// MxResponsive widget can be used for making responsive apps based on different window sizes.
/// You can specify multiple widgets depends on the screen size like [xsmall], [small], [medium],[large],
/// and [xlarge]. The [fallback] must not be null. It will be replaced if you don't specity any above widget.
class MxResponsive extends StatelessWidget {
  ///
  /// For window size as extra small
  ///
  final Widget? xsmall;

  ///
  /// For window size as small
  ///
  final Widget? small;

  ///
  /// For window size as medium
  ///
  final Widget? medium;

  ///
  /// For window size as large
  ///
  final Widget? large;

  ///
  /// For window size as extra large
  ///
  final Widget? xlarge;

  ///
  /// if none of the above props are specified then [fallback] is used
  ///
  final Widget? fallback;

  const MxResponsive(
      {super.key,
      this.xsmall,
      this.small,
      this.medium,
      this.large,
      this.xlarge,
      this.fallback});
  @override
  Widget build(BuildContext context) {
    return MxConditionalSwitch.single(
      context: context,
      valueBuilder: (context) => context.mxWindowSize,
      caseBuilders: {
        MxWindowSize.xsmall: (context) =>
            xsmall ?? fallback ?? small ?? medium ?? large ?? xlarge,
        MxWindowSize.small: (context) =>
            small ?? xsmall ?? fallback ?? medium ?? large ?? xlarge,
        MxWindowSize.medium: (context) =>
            medium ?? small ?? xsmall ?? fallback ?? large ?? xlarge,
        MxWindowSize.large: (context) =>
            large ?? medium ?? small ?? xsmall ?? fallback ?? xlarge,
        MxWindowSize.xlarge: (context) =>
            xlarge ?? large ?? medium ?? small ?? xsmall ?? fallback,
      },
      fallbackBuilder: (context) => fallback,
    )!;
  }
}

/// [MxLayout] is a type of [LayoutBuilder] with some additional power
///
class MxLayout extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    MxWindowSize window,
    BoxConstraints constraints,
  ) builder;

  final MxSizeConfig? sizeConfig;

  const MxLayout({
    super.key,
    required this.builder,
    this.sizeConfig,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, boxConstraints) {
      MxWindowSize windowSize = MxWindowSize.small;
      if (boxConstraints.maxWidth < (sizeConfig?.xsmall ?? 600)) {
        windowSize = MxWindowSize.xsmall;
      } else if (boxConstraints.maxWidth < (sizeConfig?.small ?? 1024)) {
        windowSize = MxWindowSize.small;
      } else if (boxConstraints.maxWidth < (sizeConfig?.medium ?? 1440)) {
        windowSize = MxWindowSize.medium;
      } else if (boxConstraints.maxWidth < (sizeConfig?.large ?? 1920)) {
        windowSize = MxWindowSize.large;
      } else if (boxConstraints.maxWidth < (sizeConfig?.xlarge ?? 4096)) {
        windowSize = MxWindowSize.xlarge;
      } else {
        windowSize = MxWindowSize.xlarge;
      }
      return builder(context, windowSize, boxConstraints);
    });
  }
}

class MxSizeConfig {
  final double? xsmall;
  final double? small;
  final double? medium;
  final double? large;
  final double? xlarge;

  MxSizeConfig({this.xsmall, this.small, this.medium, this.large, this.xlarge});
}

/// A typedef representing a callback function used to build the UI based on the current screen adaptation settings.
typedef MxAdaptiveChildBuilder = Widget Function(
    BuildContext context, bool scaled);

/// Defines the different scaling options for screen adaptation.
enum MxAdaptiveScaleType {
  none, // No scaling
  auto, // Scale based on the screen's orientation and aspect ratio
  width, // Scale based on the screen width
}

/// A widget that enables screen adaptation and scaling in Flutter applications.
class MxAdaptive extends StatefulWidget {
  /// Creates a `MxAdaptive` widget.
  const MxAdaptive({
    super.key,
    required this.designWidth,
    required this.builder,
    this.scaleType = MxAdaptiveScaleType.auto,
  });

  /// The width (in pixels) used as the reference for screen adaptation.
  final double designWidth;

  /// The callback function used to build the UI based on the current screen adaptation settings.
  final MxAdaptiveChildBuilder builder;

  /// The scaling type to be used for screen adaptation. Defaults to `MxAdaptiveScaleType.auto`.
  final MxAdaptiveScaleType scaleType;

  @override
  State<MxAdaptive> createState() => _MxAdaptiveState();
}

class _MxAdaptiveState extends State<MxAdaptive> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (context.view.physicalSize.isEmpty) {
      // Fallback case when the view's size is not available
      return MxAdaptiveScope._(
        designWidth: widget.designWidth,
        scaleType: widget.scaleType,
        scaleRatio: 1,
        child: const SizedBox(),
      );
    }

    final Size sceneSize =
        context.view.physicalSize / context.view.devicePixelRatio;
    if (widget.scaleType == MxAdaptiveScaleType.none ||
        (widget.scaleType == MxAdaptiveScaleType.auto &&
            sceneSize.width >= sceneSize.height * 1.1)) {
      // No scaling or scaling based on aspect ratio
      return MxAdaptiveScope._(
        designWidth: widget.designWidth,
        scaleType: widget.scaleType,
        scaleRatio: 1,
        child: Builder(
          builder: (BuildContext context) => widget.builder(context, false),
        ),
      );
    }

    final double scale = sceneSize.width / widget.designWidth;

    // Apply scaling to the UI based on the scale factor
    return FractionallySizedBox(
      widthFactor: 1 / scale,
      heightFactor: 1 / scale,
      child: Transform.scale(
        scale: scale,
        child: MxAdaptiveScope._(
          designWidth: widget.designWidth,
          scaleType: widget.scaleType,
          scaleRatio: scale,
          child: widget.builder(context, true),
        ),
      ),
    );
  }
}

class MxAdaptiveScope extends InheritedWidget {
  MxAdaptiveScope._({
    required this.designWidth,
    required this.scaleType,
    required this.scaleRatio,
    required Widget child,
  }) : super(child: _MediaQueryDataProvider(child: child));

  final double designWidth;
  final MxAdaptiveScaleType scaleType;
  final double scaleRatio;

  static MxAdaptiveScope of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MxAdaptiveScope>()!;

  static MxAdaptiveScope? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MxAdaptiveScope>();

  @override
  bool updateShouldNotify(covariant MxAdaptiveScope oldWidget) =>
      oldWidget.designWidth != designWidth ||
      oldWidget.scaleType != scaleType ||
      oldWidget.scaleRatio != scaleRatio;
}

class _MediaQueryDataProvider extends StatelessWidget {
  const _MediaQueryDataProvider({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final MxAdaptiveScope data = MxAdaptiveScope.of(context);
    final MediaQueryData parent = context.mq;
    return MediaQuery(
      data: parent.copyWith(
        size: parent.size / data.scaleRatio,
        devicePixelRatio: parent.devicePixelRatio * data.scaleRatio,
        padding: parent.padding / data.scaleRatio,
        viewPadding: parent.viewPadding / data.scaleRatio,
        viewInsets: parent.viewInsets / data.scaleRatio,
        systemGestureInsets: parent.systemGestureInsets / data.scaleRatio,
      ),
      child: child,
    );
  }
}
