

enum ItemStateEnum {
  newState,
  cancel,
  progress,
  completed;

  @override
  String toString() {
    switch (this) {
      case ItemStateEnum.newState:
        return "New";
      case ItemStateEnum.cancel:
        return "Cancel";
      case ItemStateEnum.progress:
        return "Progress";
      case ItemStateEnum.completed:
        return "Completed";

    }
  }

 /* TextStyle get textStyle {
    switch (this) {
      case ItemStateEnum.newState:
      case ItemStateEnum.cancel:
      case ItemStateEnum.progress:
      case ItemStateEnum.completed:
        return TextStyle(
          fontFamily: 'poppins',
          fontWeight: FontWeight.w400,
          color: colorRed,
        );

    }
  }*/
}