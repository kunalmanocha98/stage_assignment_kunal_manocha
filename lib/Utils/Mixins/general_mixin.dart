mixin GeneralMixins{
  String? validateField(String? value){
    if (value==null || value.isEmpty) {
      return "This field can't be empty";
    }
    return null;
  }
}