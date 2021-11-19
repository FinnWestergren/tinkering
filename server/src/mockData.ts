import { PostObj } from "./types";

const mockData: {[id: string]: PostObj} = {
    "id_001": {
        title: "first real post - speccy boy is stylin on ya",
        date: "11/19/2021",
        body: "I'm going to start documenting my progress with this blog in the mock data. It's at the point where its actually usable so here I go!"
        + "\n Here's the look of the site so far. \n\n![progress...](https://live.staticflickr.com/65535/51692153020_5c45702cbb_n.jpg)"
        + "\n\n jesus flickr has poor resolution. I'll have to find another hosting site."
        + "\n\n Anyway, today I did a lot of styling stuff. The silly billy ass numbers on the left there are images that I made in paint.net. It was pretty cool opening the files and saving the images and reloading and seeing them update on the screen. I'm currently developing this with hotloading on both the client _and_ the server, which is amazing. I'm never going back."
        + "\n\n atm I'm too lazy to go into detail about all the stuff I've done. Maybe soon I'll make a full post about my entire learning experience so far... There's a lot of stuff that went into the development so far that I'm very new to but I'm happy that I've gotten over pretty much every challenge that's presented itself so far."
        + "\n\n For now, I'll just talk about what I just did and what I intend to do next. Lets take a look at the commits today: \n\n![](//live.staticflickr.com/65535/51690492972_248450e382_t.jpg)" 
        + "\n\n And thats pretty much it! I added a picture of my house."
        + "\n\n No but for real, today I"
        + "\n\n 1. learned how to host images on my node server (I could've just used flickr or some other image hosting site, but I have bigger plans...)"
        + "\n\n 2. refactored my client code (Elm) to pass the server address in as a flag to the application instead of hard coding it like every demo everywhere does."
        + "\n\n 3. wrote some logic to render those number pictures, which was actually a fun little challenge in recursion. Everyone said that functional program was all about recursion, and I'm starting to see why."
        + "\n\n 4. had some fun with css grids and scrolled through a number of background colors for about 20 minutes."
        + "\n\n Before you go sayin, \"but Finn, you could just use icons and fonts like a normal person.\" - with respect, this is my blog. If you wanna put squid ink icons on my blog, you'll have to kill me first. I'm so tired of seeing stuff like this: \n\n ![](//live.staticflickr.com/65535/51692225925_4b2a0aacb6_c.jpg)"
        + "\n\n This stuff is all fine and good, but I want to make something crazy."
        + "\n\n Just had an idea - gonna make the house spin around when you hover over it."

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
    },
    "id_005": {
        title: "Testing Markdown",
        date: "11/15/2021",
        body: "# Heading 1 \n ## Heading 2 \n ### Heading 3 \n ![alt text](https://f4.bcbits.com/img/a2332018473_3.jpg)" 
        + "\n\n[more info on markdown](https://package.elm-lang.org/packages/pablohirafuji/elm-markdown/latest/)"
        + "\n\n ```elm\nrenderBody : String -> UnstyledHtml.Html msg\n```"
    },
    "id_006": {
        title: "title_006",
        date: "06/06/2006",
        body: "When Misha was a little kid, he lived in a yuppy little town in southern Connecticut. He hated school there."
    },
    "id_007": {
        title: "title_007",
        date: "07/07/2007",
        body: "When Misha was a little kid, he lived in a yuppy little town in southern Connecticut. He hated school there."
    },
    "id_008": {
        title: "title_008",
        date: "08/08/2008",
        body: "When Misha was a little kid, he lived in a yuppy little town in southern Connecticut. He hated school there."
    },
    "id_009": {
        title: "title_009",
        date: "09/09/2009",
        body: "When Misha was a little kid, he lived in a yuppy little town in southern Connecticut. He hated school there."
    },
    "id_010": {
        title: "title_010",
        date: "10/10/2010",
        body: "When Misha was a little kid, he lived in a yuppy little town in southern Connecticut. He hated school there."
    },
    "id_011": {
        title: "title_011",
        date: "11/11/2011",
        body: "When Misha was a little kid, he lived in a yuppy little town in southern Connecticut. He hated school there."
    },
    "id_012": {
        title: "title_012",
        date: "12/12/2012",
        body: "When Misha was a little kid, he lived in a yuppy little town in southern Connecticut. He hated school there."
    }
}

export default mockData;