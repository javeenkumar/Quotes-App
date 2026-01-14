/// quote : "All life is an experiment. The more experiments you make the better."
/// author : "Ralph Waldo Emerson"
/// category : "life"

class QuotesModel {
  QuotesModel({
      String? quote, 
      String? author, 
      String? category,}){
    _quote = quote;
    _author = author;
    _category = category;
}

  QuotesModel.fromJson(dynamic json) {
    _quote = json['quote'];
    _author = json['author'];
    _category = json['category'];
  }
  String? _quote;
  String? _author;
  String? _category;
QuotesModel copyWith({  String? quote,
  String? author,
  String? category,
}) => QuotesModel(  quote: quote ?? _quote,
  author: author ?? _author,
  category: category ?? _category,
);
  String? get quote => _quote;
  String? get author => _author;
  String? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['quote'] = _quote;
    map['author'] = _author;
    map['category'] = _category;
    return map;
  }

}