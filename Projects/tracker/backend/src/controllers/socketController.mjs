import Exception from '../../helper/exception.mjs';
import scheduleMessage from '../../helper/schedule_message.mjs';
import SocketUtils from '../utils/socketUtils.mjs';

class SocketController {

    connection(data) {
        console.log('connection event -> ', data);
        SocketUtils.emit(SocketUtils.connection, `Connection established... at ${new Date().toLocaleTimeString()}`);
    }

    test(data) {
        console.log('test event -> ', data);
        // throw new Exception('Test error', { error: data, status: 400 });
        SocketUtils.emit(SocketUtils.test, new Date().toLocaleTimeString());
    }

    hellow(message) {
        console.log('message -> ', message);
        SocketUtils.emit(SocketUtils.hellow, 'Hello from server...');
    }

    currentTime(message) {
        console.log('message -> ', message);
        let data = {
            received: message.time,
            currentTime: new Date().toLocaleTimeString()
        }
        SocketUtils.emit(SocketUtils.currentTime, data);
        scheduleMessage(SocketUtils.currentTime, 'This is a scheduled message...', 5000);
    }

    userJoin(message) {
        console.log('message -> ', message);
        SocketUtils.emit(SocketUtils.userJoin, 'You have now joined the chat...');
    }

    chat(message) {
        console.log('message -> ', typeof message, message);
        if (Array.isArray(message)) {
            let adminMessage = {
                sender: 'Admin',
                message: `Message received from ${message[0]} at ${new Date().toLocaleTimeString()}`
            }
            message = message.push(adminMessage);
        }
        SocketUtils.emit(SocketUtils.chat, message);
    }


}

export default new SocketController();
