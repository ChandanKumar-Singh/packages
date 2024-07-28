import SocketUtils from "../src/utils/socketUtils.mjs";

const scheduleMessage = (event, message, duration = 2000) => {
    console.log('scheduleMessage -> ', message);
    setTimeout(() => {
        SocketUtils.emit(event, message);
    }, duration);
};

export default scheduleMessage;