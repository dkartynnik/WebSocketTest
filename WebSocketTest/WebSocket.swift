
import Foundation

final class WebSocket: NSObject, URLSessionWebSocketDelegate {
    
    private var urlSession: URLSession!
    private var webSocketTask: URLSessionWebSocketTask!
    
    init(_ url: URL) {
        super.init()
        urlSession = URLSession.init(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        webSocketTask = urlSession.webSocketTask(with: url)
        webSocketTask.resume()
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("Web Socket did connect")
        ping()
        send()
        receive()
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("Web Socket did disconnect")
    }
    
    func ping() {
        webSocketTask.sendPing { [weak self] error in
            if let error = error {
                print("Error when sending PING \(error)")
            } else {
                print("Web Socket connection is alive")
                DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
                    self?.ping()
                }
            }
        }
    }
    
    func send() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.send()
            self?.webSocketTask.send(.string("Hello")) { error in
              if let error = error {
                print("Error when sending a message \(error)")
              }
            }
        }
    }
    
    func receive() {
        webSocketTask.receive { [weak self] result in
            switch result {
            case .success(let message):
                switch message {
                case .data(let data):
                    print("Data received \(data)")
                case .string(let text):
                    print("Text received \(text)")
                @unknown default:
                    print("Unknown message")
                }
            case .failure(let error):
                print("Error when receiving \(error)")
            }
            
            self?.receive()
        }
    }
    
}
