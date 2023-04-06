part of flutter_widgetz;

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({
    Key? key,
    this.image,
    this.radius,
  }) : super(key: key);

  final String? image;
  final double? radius;

  bool get hasImage => image != null;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: hasImage ? null : Colors.transparent,
      // TODO: determine what to do here (asset/network), (background/foreground)
      foregroundImage: hasImage ? NetworkImage(image!) : null,
      onForegroundImageError: (_, __) {},
      radius: radius,
      child: hasImage
          ? const SizedBox()
          : const Center(
              child: Icon(Icons.person),
            ),
    );
  }
}
