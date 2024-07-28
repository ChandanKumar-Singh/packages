// locationServices.mjs
import { userLocationCollectionDb } from '../../utils/FirebaseUtils.mjs';
import ILocationServices from './locationServicesInterface.mjs';

class LocationServices extends ILocationServices {

    /**
     * Add location data.
     * @param {LocationData} data - The location data
     * @returns {Promise<void>}
     */
    async addLocation(data) {
        await userLocationCollectionDb(data.userId).doc(data.id).set(data);
    }

    /**
     * Get locations data for a specific user.
     * @param {string} userId - The user ID
     * @returns {Promise<Array<Object>>} - Array of location data
     */
    async getLocationsData(userId) {
        const res = await userLocationCollectionDb(userId).get();
        const locations = [];
        res.docs.forEach((doc) => locations.push(doc.data()));
        console.log("Number of documents in snapshot locations -> ", locations.length);
        return locations;
    }

}

export default new LocationServices();
