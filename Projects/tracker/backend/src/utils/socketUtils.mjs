import { Socket } from "socket.io";
import SocketManager from "./socketManager.mjs";

class SocketUtils {

    constructor() {
        return this;
    }

    static connection = 'connection';
    static test = 'test';
    static hellow = 'hellow';
    static currentTime = 'current_time';
    static userJoin = 'user_join';
    static userLeave = 'user_leave';
    static error = 'error';
    static chat = 'chat';

    /// location
    static addLocation = 'addLocation';
    static listenLocation = 'listenLocation';

    static emit(event, message) {
        console.log('emit event -> ', event);
        SocketManager.io.emit(event, message);
    }

    static on(event, callback) {
        console.log('on event -> ', event + event);
        SocketManager.io.on(event, callback);
    }

    static listeners = (event) => {
        let listeners = SocketManager.io.listeners(event);
        console.log(`Number of listeners for event ${event} -> ${listeners.length}`);
        return listeners;
    }
}

export default SocketUtils;