class HttpResult<T> {
  int errorCode;
  String errorMsg;
  T data;

  HttpResult(this.errorCode, this.errorMsg, this.data);
}

class ListPaged<T> {
  int curPage;
  int pageCount;
  int size;
  int total;
  List<T> datas;

  ListPaged(this.curPage, this.pageCount, this.size, this.total, this.datas);
}
