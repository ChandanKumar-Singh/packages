// locationServicesInterface.mjs

/**
 * @typedef {Object} LocationData
 * @property {string} userId - The user ID
 * @property {string} id - The document ID
 * @property {any} [otherData] - Additional data
 */

/**
 * @interface
 */
class ILocationServices {
    /**
     * Add location data.
     * @param {LocationData} data - The location data
     * @returns {Promise<void>}
     */
    async addLocation(data) {}

    /**
     * Get locations data for a specific user.
     * @param {string} userId - The user ID
     * @returns {Promise<Array<Object>>} - Array of location data
     */
    async getLocationsData(userId) {}
}

export default ILocationServices;
