
class StringCommon{
  late dynamic store;

  StringCommon({
    required this.store,
  });

  String WriteStateFormString(){
    String returnString='';
    switch (this.store.state.loginState) {
          case "register1": case "register2": case "register3":
            returnString=this.store.state.loginState.replaceAll("register", "");
            break;
          case "logged-add-user-1": case "logged-add-user-2":
             returnString=this.store.state.loginState.replaceAll("logged-add-user-", "");
            break;
         case "logged-edit-user-1": case "logged-edit-user-2":
             returnString=this.store.state.loginState.replaceAll("logged-edit-user-", "");
            break;
        }
        return returnString;

    }
}




