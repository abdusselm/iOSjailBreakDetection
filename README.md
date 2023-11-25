# iOSJailBreakDetection[TR]

Bir iOS uygulamasında, uygulamanın çalıştığı cihazda Jailbreak yapılıp yapılmadığının nasıl tespit edileceğine yönelik örnek bir uygulama.

İlgili kodların hangi mantıkla çalıştığı ve hangi fonksiyonun neyi kontrol ettiğine ilişkin detaylı açıklama aşağıda ki yazımda yer almaktadır.

Bu konuya ilginiz var ise aşağıda ki yazıya bakabilirsiniz.

[iOS-Uygulamarında-Jailbreak-Detection]()

# iOSJailBreakDetection[EN]

A sample application on how to detect whether an iOS application is jailbroken on the device running the application.

Things that are checked in the jailBreakDetection.swift file;

- suspicious application file paths and suspicious library paths in an iOS operating system 
- whether the sandBox state is valid
- Dynamic library checks that can be harmful
- whether the cydia URL opens
has been checked.
In accordance with these checks, a warning window is displayed to the user accordingly in the AppDelegate.swift file.
