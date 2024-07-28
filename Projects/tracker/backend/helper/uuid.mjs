import { v4 as uuidv4 } from 'uuid';


export const createId = (prefix = '') => {
    let id = prefix;
    id += uuidv4();
    return id;
}
