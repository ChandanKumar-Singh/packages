import express from 'express';
import bodyParser from 'body-parser';
import cors from 'cors';
import dotEnv from 'dotenv';
import SocketManager from './src/utils/socketManager.mjs';
import handleError from './helper/error_handler.mjs';
import SocketUtils from './src/utils/socketUtils.mjs';
import firebaseAdmin from './src/services/firebaseService.mjs';

dotEnv.config();


const PORT = process.env.PORT || 3000;
const app = express();

app.use(cors());
app.use(bodyParser.json());

SocketManager.initialize(app);

const httpServer = SocketManager.getHttpServerInstance();
app.get('/', (req, res) => {
    res.send('Hello World');
});





// Catching uncaught exceptions
process.on('uncaughtException', (error) => {
    handleError(error);
});

// Catching unhandled promise rejections
process.on('unhandledRejection', (reason, promise) => {
    handleError(reason);
});

httpServer.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
