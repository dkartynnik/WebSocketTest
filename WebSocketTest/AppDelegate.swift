
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var webSocket: WebSocket?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let url = URL(string: "wss://demo.websocket.me/v3/channel_1?api_key=oCdCMcMPQpbvNjUIzqtvF1d2X2okWpDQj4AwARJuAgtjhzKxVEjQU6IdCjwm&notify_self")!
        
        webSocket = WebSocket(url)
        
        return true
    }
    
}

