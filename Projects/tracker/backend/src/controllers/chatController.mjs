import scheduleMessage from "../../helper/schedule_message.mjs";
import firebaseService from "../services/firebaseService.mjs";
import SocketUtils from "../utils/socketUtils.mjs";

class ChatController {
    static instance = null;

    constructor() {
        if (!ChatController.instance) {
            ChatController.instance = this;
        }
        return ChatController.instance;
    }




    async chat(message) {
        console.log("message -> ", Array.isArray(message), message);
        let msg = message.message;
        let roomId = message.roomId;
        if (roomId)
            SocketUtils.emit(`${roomId}`, true);
        const reply = {
            sender: "admin",
            message: `Message received at ${new Date().toLocaleTimeString()}`,
            time: Date.now(),
            receiver: msg.sender,
        };
        var data = {
            message,
            reply
        }
        let delay = 3000;
        scheduleMessage(SocketUtils.chat, data, delay);
        if (roomId)
            scheduleMessage(`${roomId}`, false, delay - 100);
    }
}

export default new ChatController();
