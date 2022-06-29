<h1 align=center>Breaking News 🗞 📰 </h1> 

I model the data I got from a haber site and transferred it to the application with Alamofire. I created a detail page for the news and showed the pictures by downloading them with Kingfisher. I made the auto layout of the application programmatically with Snapkit. Buna ek olarak sayfa geçişlerini Hero ile yaptım. I hope you like.

## Technologies
+ MVVM Architecture ✅ 
+ Programmatically ✅
+ Hero ✅ 
+ Lottie ✅ 
+ Kingfisher ✅ 
+ Alamofire ✅
+ Snapkit ✅
+ SparkUI ✅

## Demo


https://user-images.githubusercontent.com/97698649/176423470-36cbffa8-a087-4c76-ba5e-8843f1487963.mov




## API

Ex: https://newsapi.org

```` swift
{
final class ServiceManager {
    public static let shared: ServiceManager = ServiceManager()
}

extension ServiceManager {
    func fetch<T>(path: String, onSuccess: @escaping (T) -> (), onError: (AFError) ->()) where T: Codable {
        
        AF.request(path, encoding: JSONEncoding.default).validate().responseDecodable(of: T.self) { response in
            
            guard let model = response.value else { print( response.error as Any ); return }
            onSuccess(model)
            }
        }
    }
}
````
