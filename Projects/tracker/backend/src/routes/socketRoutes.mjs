import ChatController from "../controllers/chatController.mjs";
import LocationController from "../controllers/locationController.mjs";
import SocketController from "../controllers/socketController.mjs";
import SocketUtils from "../utils/socketUtils.mjs";

class SocketRoutes {
    static instance = null;
    constructor() {
        if (!SocketRoutes.instance) {
            SocketRoutes.instance = this;
        }
        return SocketRoutes.instance;
    }

    registerSockets(socket) {
        if (!socket) {
            throw new Error('Socket instance not initialized. Call initialize(app) first.');
        }
        socket.on(SocketUtils.connection, SocketController.connection);
        socket.on(SocketUtils.test, SocketController.test);
        socket.on(SocketUtils.hellow, SocketController.hellow);
        socket.on(SocketUtils.currentTime, SocketController.currentTime);
        socket.on(SocketUtils.userJoin, SocketController.userJoin);
        socket.on(SocketUtils.chat, ChatController.chat);
        /// location
        socket.on(SocketUtils.addLocation, LocationController.addLocation);
        socket.on(SocketUtils.listenLocation, LocationController.listenLocation);
    }
}

export default new SocketRoutes();