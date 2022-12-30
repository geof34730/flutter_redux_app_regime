
class StringCommon{
  late dynamic store;

  StringCommon({
    required this.store,
  });

  String WriteStateFormString(){
    String returnString='';
    switch (store.state.loginState.widget) {
          case "register1": case "register2": case "register3": case "register4":
            returnString=store.state.loginState.widget.toString().replaceAll("register", "");
            break;
          case "logged-add-user-1": case "logged-add-user-2":
             returnString=store.state.loginState.widget.toString().replaceAll("logged-add-user-", "");
            break;
         case "logged-edit-user-1": case "logged-edit-user-2":
             returnString=store.state.loginState.widget.toString().replaceAll("logged-edit-user-", "");
            break;
        }
        return returnString;
    }
}




