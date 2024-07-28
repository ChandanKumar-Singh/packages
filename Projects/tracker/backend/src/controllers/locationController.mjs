import { Timestamp } from "firebase-admin/firestore";
import { createId } from "../../helper/uuid.mjs";
import SocketUtils from "../utils/socketUtils.mjs";
import LocationServices from "../services/location/LocationServices.mjs";


const addLocation = async (data) => {
    data.createAt = Timestamp.now();
    data.updateAt = Timestamp.now();
    data.id = createId();
    console.log("addLocation .................. ");
    // SocketUtils.listeners(SocketUtils.addLocation);
    await LocationServices.addLocation(data);
    const locations = await LocationServices.getLocationsData(data.userId);
    SocketUtils.emit(SocketUtils.listenLocation, locations);
};

const listenLocation = async (data) => {
    try {
        const locations = await LocationServices.getLocationsData(data.userId);
        SocketUtils.emit(SocketUtils.listenLocation, locations);
    } catch (error) {
        console.error("Error setting up location listener:", error);
    }
};


export default {
    addLocation,
    listenLocation
};
