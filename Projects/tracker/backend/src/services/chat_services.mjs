import firebaseService from "../firebaseService.mjs";
import createId from "../../helper/uuid.mjs";
import ChatController from "../controllers/chatController.mjs";


const roomsCollection = 'rooms';
const roomChatCollection = 'chats';
const rooms = firebaseService.fb.collection(roomsCollection);

const getChatRoomById = async (id) => {
    const room = await rooms.doc(id).get();
    if (!room.exists) return null;
    return room.data();
}

const getChatsByRoomId = async (id) => {
    const chats = await rooms.doc(id).collection(roomChatCollection).get();
    if (!chats.exists) return null;
    return chats.data();
}

const createChatRoom = async (data) => {
    data.createdAt = Date.now();
    data.updatedAt = Date.now();
    data.id = createId('room');
    const room = await rooms.doc(createId('room')).set(data);
    console.log('Room created: ', room);
    return data;
}


const joinChatRoom = async (fromId,toId) => {
    const room = await getChatRoomById(roomId);
    if (!room) return null;
    if (room.users.includes(userId)) return room;
    room.users.push(userId);
    const updatedRoom = await rooms.doc(roomId).update(room);
    return updatedRoom;
}


export default { getChatRoomById, getChatsByRoomId, createChatRoom };