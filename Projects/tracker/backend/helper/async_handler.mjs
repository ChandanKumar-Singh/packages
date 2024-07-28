import handleSocketError from "./error_handler.mjs";
import Exception from "./exception.mjs";

const socketAsync = (fn) => (s) => {
    console.log('socketAsync -> ', fn.constructor.name);
    try {
        if (fn.constructor.name === 'Function') {
            return fn(s);
        }
        return async () => {
            await fn(s);
        }
    } catch (error) {
        console.error(error);
        let msg;
        if (error instanceof Exception) {
            msg = error.message;
        } else if (error instanceof Error) {
            msg = error.message;
        } else {
            msg = 'An error occurred while processing your request.';
        }
        handleSocketError(new Exception(msg, { error: error, status: 500 }));
    }
}


export default socketAsync;