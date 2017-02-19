# 9-Key-iOS-Keyboard
This project is a custom T9 layout English keyboard for iOS device.

## Build instruction ##
Please download the project and open 9-key.xcodeproj to launch the Xcode project.
You can choose to use a simulator or your iOS device to run the project.
### Simulator setting: ###
At top of  Xcode, you can set active scheme and choose device type as shown below.
![setScheme](https://raw.githubusercontent.com/Jiaqi-Huang/9-key-iOS-Keyboard/master/settingImages/setScheme.png)
Please choose 9-key and select your simulator type, we recommend to use devices later then iPhone6.
Then click build button. A simulator window should be automatically launched after 9-key scheme is built sucessfully. 
Now we need to build the keyboard extension. Please switch the scheme to 9-key-keyboard as shown below.
![switchScheme](https://raw.githubusercontent.com/Jiaqi-Huang/9-key-iOS-Keyboard/master/settingImages/switchScheme.png)
Then click build to build 9-key-keyboard.
After everything is built sucessfully, please do the follwing setting in your simulator to launch the keyboard.

  - Press [shift + command + H] button which acts as the [Home] button on iPhone
  - GO to Settings -> General -> Keyboard -> Keyboards -> Add New Keyboard -> 9-key
  - Press [shift + command + H] and lauch 9-key app
  - Press the text field and press 🌐 button to switch to the 9-key keyboard (the first time you switch to 9-key keyboard may take some time to load the dictionary)
  - Finish! Enjoy the 9-key keyboard.
  - If you meet and problem during the setting, please contact me.
  






Markdown is a lightweight markup language based on the formatting conventions that people naturally use in email.  As [John Gruber] writes on the [Markdown site][df1]

> The overriding design goal for Markdown's
> formatting syntax is to make it as readable
> as possible. The idea is that a
> Markdown-formatted document should be
> publishable as-is, as plain text, without
> looking like it's been marked up with tags
> or formatting instructions.

This text you see here is *actually* written in Markdown! To get a feel for Markdown's syntax, type some text into the left window and watch the results in the right.

### Tech

Dillinger uses a number of open source projects to work properly:

* [AngularJS] - HTML enhanced for web apps!
* [Ace Editor] - awesome web-based text editor
* [markdown-it] - Markdown parser done right. Fast and easy to extend.
* [Twitter Bootstrap] - great UI boilerplate for modern web apps
* [node.js] - evented I/O for the backend
* [Express] - fast node.js network app framework [@tjholowaychuk]
* [Gulp] - the streaming build system
* [Breakdance](http://breakdance.io) - HTML to Markdown converter
* [jQuery] - duh

And of course Dillinger itself is open source with a [public repository][dill]
 on GitHub.

### Installation

Dillinger requires [Node.js](https://nodejs.org/) v4+ to run.

Install the dependencies and devDependencies and start the server.

```sh
$ cd dillinger
$ npm install -d
$ node app
```

For production environments...

```sh
$ npm install --production
$ npm run predeploy
$ NODE_ENV=production node app
```

### Plugins

Dillinger is currently extended with the following plugins. Instructions on how to use them in your own application are linked below.

| Plugin | README |
| ------ | ------ |
| Dropbox | [plugins/dropbox/README.md] [PlDb] |
| Github | [plugins/github/README.md] [PlGh] |
| Google Drive | [plugins/googledrive/README.md] [PlGd] |
| OneDrive | [plugins/onedrive/README.md] [PlOd] |
| Medium | [plugins/medium/README.md] [PlMe] |
| Google Analytics | [plugins/googleanalytics/README.md] [PlGa] |


### Development

Want to contribute? Great!

Dillinger uses Gulp + Webpack for fast developing.
Make a change in your file and instantanously see your updates!

Open your favorite Terminal and run these commands.

First Tab:
```sh
$ node app
```

Second Tab:
```sh
$ gulp watch
```

(optional) Third:
```sh
$ karma test
```
#### Building for source
For production release:
```sh
$ gulp build --prod
```
Generating pre-built zip archives for distribution:
```sh
$ gulp build dist --prod
```
### Docker
Dillinger is very easy to install and deploy in a Docker container.

By default, the Docker will expose port 80, so change this within the Dockerfile if necessary. When ready, simply use the Dockerfile to build the image.

```sh
cd dillinger
docker build -t joemccann/dillinger:${package.json.version}
```
This will create the dillinger image and pull in the necessary dependencies. Be sure to swap out `${package.json.version}` with the actual version of Dillinger.

Once done, run the Docker image and map the port to whatever you wish on your host. In this example, we simply map port 8000 of the host to port 80 of the Docker (or whatever port was exposed in the Dockerfile):

```sh
docker run -d -p 8000:8080 --restart="always" <youruser>/dillinger:${package.json.version}
```

Verify the deployment by navigating to your server address in your preferred browser.

```sh
127.0.0.1:8000
```

#### Kubernetes + Google Cloud

See [KUBERNETES.md](https://github.com/joemccann/dillinger/blob/master/KUBERNETES.md)


### Todos

 - Write MOAR Tests
 - Add Night Mode

License
----

MIT


**Free Software, Hell Yeah!**

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)


   [dill]: <https://github.com/joemccann/dillinger>
   [git-repo-url]: <https://github.com/joemccann/dillinger.git>
   [john gruber]: <http://daringfireball.net>
   [df1]: <http://daringfireball.net/projects/markdown/>
   [markdown-it]: <https://github.com/markdown-it/markdown-it>
   [Ace Editor]: <http://ace.ajax.org>
   [node.js]: <http://nodejs.org>
   [Twitter Bootstrap]: <http://twitter.github.com/bootstrap/>
   [jQuery]: <http://jquery.com>
   [@tjholowaychuk]: <http://twitter.com/tjholowaychuk>
   [express]: <http://expressjs.com>
   [AngularJS]: <http://angularjs.org>
   [Gulp]: <http://gulpjs.com>

   [PlDb]: <https://github.com/joemccann/dillinger/tree/master/plugins/dropbox/README.md>
   [PlGh]: <https://github.com/joemccann/dillinger/tree/master/plugins/github/README.md>
   [PlGd]: <https://github.com/joemccann/dillinger/tree/master/plugins/googledrive/README.md>
   [PlOd]: <https://github.com/joemccann/dillinger/tree/master/plugins/onedrive/README.md>
   [PlMe]: <https://github.com/joemccann/dillinger/tree/master/plugins/medium/README.md>
   [PlGa]: <https://github.com/RahulHP/dillinger/blob/master/plugins/googleanalytics/README.md>

==========================================

DictionaryQuery implements a trie to look up words that match a given sequence of letters or numbers.
It allows users to give a custom mapping of letters to characters which is used for hte 9-key keyboard.
Words in DictionaryQuery are based off of a text file given by the user.

Usage of DictionaryQuery:

Initialization:

    init(customMap:Array<Int>) / init(customMap:Array<Character>): 
    Makes a trie that will have follow the mapping specified.
    customMap should be an array where index 0 corresponds to that 'a' should have in the trie.
    
    Ex.         a  b  c  d  e  f  g  h
    customMap: [2, 2, 2, 3, 3, 4, 4, 4, ... ]

    A dictionary file may also be specified in the second parameter to load the dictionary at initialization

Loading a dictionary:

    loadDictionary(fileName:String):
    Attempts to load the file specified as a dictionary.
    File must be located in the documents folder (for now)
    File should contain one word or dictionary entry per line



Adding/removing words to dictionary:

    addWord(word:String): Adds word to the dictionary trie
    removeWord(word:String): Removes word from the dictionary trie

Retriving possible words:

    getWord(sequence:String, numResults:Int? = 0):
    Returns an array of strings that match the sequence given.
    numResults is optional. If specified, it will limit the number of results returned.

Dictionary sources:

    http://www-01.sil.org/linguistics/wordlists/english/
    https://github.com/dwyl/english-words
