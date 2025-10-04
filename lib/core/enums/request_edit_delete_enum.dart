enum RequestEditDeleteEnum {
  edit,
  delete;

  String toJson() {
    switch (this) {
      case RequestEditDeleteEnum.edit:
        return "edit";
      case RequestEditDeleteEnum.delete:
        return "delete";
    }
  }
}
