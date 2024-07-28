const userCollection = 'users';
const locationCollection = 'locations';
const messageCollection = 'messages';
const chatCollection = 'chats';
const notificationCollection = 'notifications';

const userDocument = (userId) => `${userCollection}/${userId}`;
const userLocationCollection = (userId) => `${userDocument(userId)}/${locationCollection}`;


export default {
    userCollection,
    locationCollection,
    messageCollection,
    chatCollection,
    notificationCollection,
    userDocument,
    userLocationCollection
};
