
# Otobüs Nerede? - Ankara (Where's the bus? - Ankara)

English

With this mobile app, you can find out the location of buses without the need for stop numbers. The app shows the instant location of buses, providing users with real-time information about their arrival time. This way, you can minimize your waiting time and have better control over the timing. With its user-friendly interface and easy-to-use interface, the app is an ideal solution for those who want to track buses and plan for on-time arrivals. You can have a more comfortable and efficient experience on your travels by using this application where you can learn bus locations without the need for stop numbers.

Turkish

Bu mobil uygulama sayesinde, durak numaralarına ihtiyaç duymadan otobüslerin konumunu öğrenebilirsiniz. Uygulama, otobüslerin anlık konumunu göstererek, kullanıcılara varış zamanları hakkında gerçek zamanlı bilgi sağlar. Bu sayede, bekleme sürenizi minimize edebilir ve zamanlama konusunda daha iyi bir kontrol sahibi olabilirsiniz. Kullanıcı dostu arayüzü ve kolay kullanımı ile dikkat çeken uygulama, otobüs takip etmek ve zamanında varışlar için plan yapmak isteyenler için ideal bir çözümdür. Durak numaralarına ihtiyaç duymadan otobüs konumlarını öğrenebileceğiniz bu uygulamayı kullanarak seyahatlerinizde daha rahat ve verimli bir deneyim yaşayabilirsiniz.




## API Using and Web Scraping

#### Bring all items with web scraping

```http
  Web Scrape /http://map.ego.gov.tr:8080/ego/hatListesi.aspx
```


#### Get specific id hat

```http
  GET /http://88.255.141.66/mblSrv1/service.asp?FNC=Otobus&PRM=&VER=3.1.0&LAN=tr&TST=&HAT=${id}
```

| Parametre | Tip     | Açıklama                       |
| :-------- | :------- | :-------------------------------- |
| `id`      | `string` | **Required**. Key value of the item to be called |

#### id

lists the buses on that line on api id request 

  
## Features

- Active bus tracking
- Without the need for a stop number 
- see bus information 

  
## Feedback

If you have any feedback, please contact us at enesceylan.6699@hotmail.com.

  
## Lessons Learned

I had experience in REST API, State management, web scraping etc. I had the chance to apply S.O.L.I.D principles on the project.
## Download 

Download from google play.

```bash 
 https://play.google.com/store/apps/details?id=com.ceylanenes.otobusnerede
```
    
## Ekran Görüntüleri

![Uygulama Ekran Görüntüsü](![Screenshot](screenshot.png)
![Screenshot](screenshot.png)
![Screenshot](screenshot.png)
![Screenshot](screenshot.png)
![Screenshot](screenshot.png)

  
![Logo](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/th5xamgrr6se0x5ro4g6.png)

    
## Used technologies

**Client:** Flutter, Dart, REST API


  