import collections from "../../helper/collections.mjs";
import firebaseService from "../services/firebaseService.mjs";

export const
    userLocationCollectionDb = (userId) =>
        firebaseService.fb.collection(collections.userLocationCollection(userId));