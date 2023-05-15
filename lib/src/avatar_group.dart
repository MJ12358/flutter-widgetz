part of flutter_widgetz;

/// {@template flutter_widgetz.AvatarGroup}
/// An avatar group is an element that communicates
/// to the user that there is more than 1 person
/// associated to an item.
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
  final IconData icon;

  /// The size of the avatar, expressed as the radius (half the diameter).
  final double radius;

  static const IconData _defaultIcon = Icons.person;
  static const double _defaultRadius = kRadialReactionRadius;

  /// {@macro flutter_widgetz.AvatarGroup}
  ///
  /// Uses an [AssetImage].
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
  /// Uses a [NetworkImage].
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
