import { PostObj } from "./types";

const mockData: {[id: string]: PostObj} = {
    "id_001": {
        title: "title_001",
        date: "01/01/2001",
        body: "When Teddy was a little kid, he had a blue bicycle. One day he was riding it around a corner when some dudes just picked him up, threw him in a bush, and took it. \n" +
        "His mom kinda freaked out."
    },
    "id_002": {
        title: "title_002",
        date: "02/02/2002",
        body: "When Misha was a little kid, he lived in a yuppy little town in southern Connecticut. He hated school there."
    },
    "id_003": {
        title: "title_003 ",
        date: "03/03/2003",
        body: "When Caroline was a little kid, she really liked rocks. Rocks are cool."
    },
    "id_004": {
        title: "title_004 ",
        date: "04/04/2004",
        body: "Pee pee wee wee doo doo."
    }
}

export default mockData;