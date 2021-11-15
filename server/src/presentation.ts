import mockData from './mockData';
import { PostObj, PostObjPreview } from './types';

const getData = () => mockData;

export const getPostList: () => PostObjPreview[] = () => {
    return Object.keys(getData()).map(key => {
        const {title, date} = getData()[key];
        return {title, date, id: key}
    });
}

export const getPost: (id: string) => PostObj = (id) => {
    var data = getData();
    if(!data[id]){
        throw new Error("500")
    }
    return data[id];
}