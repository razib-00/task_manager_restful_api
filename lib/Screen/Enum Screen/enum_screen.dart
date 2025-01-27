// enum_screen.dart


enum ItemStateEnum { New, Cancel,Progress, Completed }

extension ItemStateEnumExtension on ItemStateEnum {
  String get displayName {
    switch (this) {
      case ItemStateEnum.New:
        return "New";
        case ItemStateEnum.Cancel:
        return "Cancel";
      case ItemStateEnum.Progress:
        return "Progress";
      case ItemStateEnum.Completed:
        return "Completed";
    }
  }
}
