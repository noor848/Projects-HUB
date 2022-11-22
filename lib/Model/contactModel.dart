class ContactModel{

   String id="";

  ContactModel.fromJson(Map<String,dynamic>json){

    id=json['id'];
  }

}