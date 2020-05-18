//产品列表数据模型
class ProductListModel{
  //状态码
  int code;
  //状态信息
  String message;
  //产品列表数据
  List<ProductModel> data;

  //构造方法 初始化时可传入空数组[]即可
  ProductListModel(this.data);

  //通过传入Json数据转换成数据模型
  ProductListModel.fromJson(Map<String,dynamic> json){
    code = json['code'];
    message = json['message'];
    if(json['data'] != null){
      data = List<ProductModel>();
      //循环迭代Json数据并将其每一项数据转换成ProductModel
      json['data'].forEach((v){
        data.add(ProductModel.fromJson(v));
      });
    }
  }

  //将数据模型转换成Json
  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = Map<String,dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if(this.data != null){
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }

}

//产品数据模型
class ProductModel{
  String title;//产品id
  String answerA;//产品描述
  String answerB;//产品类型
  String answerC;//产品名称
  String answerD;//产品图片路径
  String answer;//产品特点

  //构造方法
  ProductModel({this.title,this.answerA,this.answerB,this.answerC,this.answerD,this.answer});

  //通过传入Json数据转换成数据模型
  ProductModel.fromJson(Map<String,dynamic> json){
    title = json['title'];
    answerA = json['answerA'];
    answerB = json['answerB'];
    answerC = json['answerC'];
    answerD = json['answerDD'];
    answer = json['answer'];
  }

  //将数据模型转换成Json
  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['title'] = this.title;
    data['answerA'] = this.answerA;
    data['answerB'] = this.answerB;
    data['answerC'] = this.answerC;
    data['answerD'] = this.answerD;
    data['answer'] = this.answer;
    return data;
  }

}