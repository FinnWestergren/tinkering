import { NotFoundError } from './customError';
import mockData from './mockData';
import { PostObj, PostObjPreview } from './types';

const getData = () => mockData;

export const getPostList: () => PostObjPreview[] = () => {
    return Object.keys(getData()).map(key => {
        const {title, date} = getData()[key];
        return {title, date: transformDate(date), id: key}
    });
}

export const getPost: (id: string) => PostObj = (id) => {
    var data = getData();
    if(!data[id]){
        throw new NotFoundError("Could not find a post with that ID")
    }
    return data[id];
}

const transformDate = (dateString: string) => {
    const date = new Date(dateString);
    var options: Intl.DateTimeFormatOptions = { year: 'numeric', month: 'short', day: 'numeric' };
    return date.toLocaleDateString("en-US", options).replace(',','');
}