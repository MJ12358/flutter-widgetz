part of flutter_widgetz;

/// {@template flutter_widgetz.AvatarGroup}
/// An avatar group is an element that communicates
/// to the user that there is more than 1 person
/// associated to an item.
///
///![AvatarGroup](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/avatar_group.png)
/// {@endtemplate}
class AvatarGroup extends StatelessWidget {
  /// {@macro flutter_widgetz.AvatarGroup}
  AvatarGroup({
    super.key,
    this.icon = _defaultIcon,
    this.radius = _defaultRadius,
  })  : child1 = CustomAvatar(
          icon: icon,
          radius: radius,
        ),
        child2 = CustomAvatar(
          icon: icon,
          radius: _computeRadius(radius),
        );

  /// The widget below this widget in the tree.
  final Widget child1;

  /// The widget below this widget in the tree.
  final Widget child2;

  /// The icon to display when no image is present.
  final Widget icon;

  /// The size of the avatar, expressed as the radius (half the diameter).
  final double radius;

  static const Widget _defaultIcon = Icon(Icons.person);
  static const double _defaultRadius = kRadialReactionRadius;

  /// {@macro flutter_widgetz.AvatarGroup}
  ///
  /// Asset uses [Image.asset].
  AvatarGroup.asset(
    String name, {
    super.key,
    this.icon = _defaultIcon,
    this.radius = _defaultRadius,
  })  : child1 = CustomAvatar.asset(
          name,
          icon: icon,
          radius: radius,
        ),
        child2 = CustomAvatar.asset(
          name,
          icon: icon,
          radius: _computeRadius(radius),
        );

  /// {@macro flutter_widgetz.AvatarGroup}
  ///
  /// Memory uses [Image.memory].
  AvatarGroup.memory(
    Uint8List? bytes, {
    super.key,
    this.icon = _defaultIcon,
    this.radius = _defaultRadius,
  })  : child1 = CustomAvatar.memory(
          bytes,
          icon: icon,
          radius: radius,
        ),
        child2 = CustomAvatar.memory(
          bytes,
          icon: icon,
          radius: _computeRadius(radius),
        );

  /// {@macro flutter_widgetz.AvatarGroup}
  ///
  /// Network uses [Image.network].
  AvatarGroup.network(
    String source, {
    super.key,
    this.icon = _defaultIcon,
    this.radius = _defaultRadius,
  })  : child1 = CustomAvatar.network(
          source,
          icon: icon,
          radius: radius,
        ),
        child2 = CustomAvatar.network(
          source,
          icon: icon,
          radius: _computeRadius(radius),
        );

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Positioned(
          left: radius,
          bottom: radius,
          child: child2,
        ),
        child1,
      ],
    );
  }

  // Helper method to compute the radius for [child2].
  static double _computeRadius(double radius) {
    return math.min(radius, radius * .75);
  }
}
