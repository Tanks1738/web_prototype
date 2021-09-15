class DocObj {
  var documentName;


  DocObj(DocObj doc) {
    this.documentName = doc.getDocName();
  }

  dynamic getDocName() => documentName;

  DocObj.setDocDetails(Map<dynamic, dynamic> doc)
      : documentName = doc['name'];
}
