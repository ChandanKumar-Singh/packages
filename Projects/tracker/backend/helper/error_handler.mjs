import SocketUtils from "../src/utils/socketUtils.mjs";
import Exception from "./exception.mjs";

const handleError = (error) => {
    console.error('handleError -> ', error);
    if (error instanceof Exception) {
        console.error(`Exception handling [${error.status}] -> `, error.message);
        SocketUtils.emit(SocketUtils.test, {
            status: error.status,
            error: error.error,
            message: error.message,

        });
    } else {
        SocketUtils.emit(SocketUtils.test, {
            status: 500,
            message: error.message ?? 'Something went wrong',
            error: error
        });
    }
};

export default handleError;