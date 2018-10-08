import Foundation
import SwiftWebSocket

func echoTest(){
    var messageNum = 0
    let ws = WebSocket("ws://localhost:3000/websocket")
    let send : ()->() = {
        messageNum += 1
        let msg = "\(messageNum): \(NSDate().description)"
        print("send: \(msg)")
        ws.send(msg)
    }
    ws.event.open = {
        print("opened")
        send()
    }
    ws.event.close = { code, reason, clean in
        print("close")
    }
    ws.event.error = { error in
        print("error \(error)")
    }
    ws.event.message = { message in
        if let text = message as? String {
            print("recv: \(text)")
            if messageNum == 10 {
                ws.close()
            } else {
                send()
            }
        }
    }
}

print("echoTest")
echoTest()
print("waiting")
sleep(10)