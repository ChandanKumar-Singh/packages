import ILocationServices from "../../src/services/location/locationServicesInterface.mjs";

class TestLocationServices extends ILocationServices {
    static instance = null;
    static locations = [];
    constructor() {
        super();
        if (!TestLocationServices.instance) {
            TestLocationServices.instance = this;
        }
        return TestLocationServices.instance;
    }


    async addLocation(data) {
        console.log(this, "addLocation data -> ", data.latitude, data.longitude);
        TestLocationServices.locations.push(data);
    }

    async getLocationsData(userId) {
        console.log(this, "getLocationsData userId -> ", userId);
        return TestLocationServices.locations;
    }
}


export default new TestLocationServices();