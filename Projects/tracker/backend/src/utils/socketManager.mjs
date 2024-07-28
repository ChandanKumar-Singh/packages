import { Server as SocketServer } from 'socket.io';
import { createServer } from 'http';
import dotEnv from 'dotenv';
import SocketUtils from './socketUtils.mjs';
import socketAsync from '../../helper/async_handler.mjs';
import socketRoutes from '../routes/socketRoutes.mjs';

dotEnv.config();

class SocketManager {
    static instance = null;

    constructor() {
        if (!SocketManager.instance) {
            this.io = null;
            this.httpServer = null;
            SocketManager.instance = this;
        }
        return SocketManager.instance;
    }

    initialize(app) {
        if (!this.io && !this.httpServer) {
            this.httpServer = createServer(app);
            this.io = new SocketServer(this.httpServer, {
                cors: {
                    origin: '*',
                    methods: ["GET", "POST"]
                }
            });
            const onConnect = socketAsync((socket) => {
                console.log('Socket Manager ', `A user connected... ${socket.id}`);
                this.socket = socket;
                SocketUtils.emit(SocketUtils.connection, `Hello from server... ${socket.id}`);
                socketRoutes.registerSockets(socket);
                /// on Any event
                socket.onAny((event, args) => {
                    console.log('Socket Manager ', `onAny event -> ${event}`, args);
                    // socket.emit(event, args);
                });
            });

            this.io.on('connection', onConnect);
        }
    }

    getHttpServerInstance() {
        if (!this.httpServer) {
            throw new Error('HTTP server not initialized. Call initialize(app) first.');
        }
        return this.httpServer;
    }
}

export default new SocketManager();
