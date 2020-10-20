import 'dart:async';

Stream<int> numb() async* {
  for(int i=1; i<5; i++){
    yield i;
  }
  
}

Stream<String> frStream (Iterable iterable)async*{
for (var fr in iterable){
  yield fr;
}
}

void main(List<String> arguments) async{
  
  var stream = numb();
  
  //Properties of class Stream
//Future<T> first
//The first element of this stream.
//int x = await stream.first;// we should use 'await' because 'first' returns Future
//print(x);//1

//bool isBroadcast
//Whether this stream is a broadcast stream.
//bool b = stream.isBroadcast;
//print(b);//false
  
// Future<bool> isEmpty
// Whether this stream contains any elements.  
// bool emp = await stream.isEmpty;
// print(emp);//false

// Future<T> last
// The last element of this stream.
// int l = await stream.last;
// print(l);//4
  
// Future<int> length
// The number of elements in this stream.
// Waits for all elements of this stream. When this stream ends, the returned future is completed with the number of elements.
// int leng = await stream.length;
// print(leng);//4

// Future<T> single
// The single element of this stream.
//var leng = await stream.single;//Unhandled exception.
//If stream is empty or has more than one element, the returned future completes with an error.




  //Let's examine METHODs of class Stream

  // Future<bool> any (bool test(T element))
  //Notation means: function "any" returns an Instance of Future (boolian type), 
  //it takes function "test" and returns boolian value or expression. 
  //function "test" takes an object of type T (an element of Steam).
  
  //Checks whether test accepts any element provided by this stream.
  
  /*
  //print(await stream.any((element) => element>0));//true
  */
  
  
  //Stream<S> expand <S>(Iterable<S> convert(T element))
  //Notation means: function "expand" returns an Instance of Stream (generic type S), 
  //it takes function "convert" and returns Iterable. 
  //function "convert" takes an object of type T (an element of Steam).

  /* var str2 = stream.expand((element) => [element.toString(), element.isEven]);// no sense, just experiment
  //The code shows that we should use Iterable and we can duplicate stream's elements, as well as process them
  await for(var el in str2){
    print(el);
  } */

//method expand with Stream<String>
  /* var fruits = ['mangoes','bananas','mangoes','peaches','plums','apples'];
  var fruitStream = frStream(fruits).expand((element) => [element, fruits.last,'price']);
  await for(var el in fruitStream){
    print(el);
  } */

// method listen
// StreamSubscription<T> listen (void onData(T event), {Function? onError, void onDone(), bool? cancelOnError} )
// method listen returns an instance of class StreamSubscription
// if we have data events we can use them by onData, 
//we write anonymous function which take an element of stream and we use it (for example, print) 
//in case of error we can use named parameter on Error

/* var fruits = ['mangoes','bananas','mangoes','peaches','plums','apples'];
  var fruitStream = frStream(fruits);
  fruitStream.listen(
    (data) => print(data),
    onError: (err)=> print(err),
    onDone: () => print('fruits run out'),
    cancelOnError: true
    ); */

// Stream<S> map <S>(S convert(T event))
// Transforms each element of this stream into a new stream event.

//stream.map((element) => element*2).listen((event)=> print(event));
//we transformed each number in original stream by multiplying on 2,
// and as a result we get new stream with doubled elements: 2 4 6 8 (instead of 1 2 3 4)

// Stream<S> transform <S>( StreamTransformer<T, S> streamTransformer)
// Applies streamTransformer to this stream.

var fruits = ['mangoes','bananas','mangoes','peaches','plums','apples'];
  var fruitStream = frStream(fruits);//we made a stream from list. Actualy there is special constuctor Stream.fromIterable in Dart 

// First we need to creat an instance of class StreamTransformer, our transformer
// we use constructor StreamTransformer.fromHandlers()

var transformer = StreamTransformer<String,String>.fromHandlers(
  handleData: (data, sink) {
if (data.toString().contains('ana')){
  sink.add(data);
  }else {
    sink.addError('No banana and ananas');
  }
  },
);

fruitStream.transform(transformer).listen((event) => print(event),onError: (err)=>print(err));



}
