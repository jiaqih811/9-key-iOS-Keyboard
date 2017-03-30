# 9 Key Keyboard Profile System

For beta, we have two components for this part of the project, the front end, and the back end. We've deployed the beta for now [here](https://safe-sierra-92629.herokuapp.com/), feel free to try clicking around the front end.

## Installation

(Note that this installation process assumes a little bit of knowledge of the terminal)

You'll need to install Node JS and `npm` for this to work. For Debian users, I found that the default versions given with `apt` were insufficient, so you'll want to go and download the newest stable versions of both.

After installing both, in the directory with the `package.json` file, run `npm install`. This will install all the Node dependencies we use. After that, run `node index.js`, and the app should deploy on your machine. Go ahead to `localhost:3000` in your browser and you should see the app running.

**NOTE:** Since we use some private credentials to query Firebase, not all of the backend functionality will work on your computer. For actual testing and not just running, you'll want to go to the deployed version above.

## Back End

The back end is written in Node JS, and relies on Google Firebase to store/ retrieve data. It is being developed using RESTful API principles, and offers a few operations already. For beta, we are only allowing the use of a specific test user. That being said if you poke around in the source code it's not difficult to use other ones... Please don't try to destroy our database too much! :)

Details about the Back End can be found in the code.

### Error Handling

As for now, there is 0 error handling besides the exceptions thrown by the Firebase APIs we use. It is extremely likely that if you put in bad data, it will be successfully put into the database.

## Front End

For beta, the front end is written using standard HTML/ CSS/ JS with jQuery. It allows the user to create profiles, add text to profiles' dictionaries, and view the internal data of the dictionaries. For the most part, the front end is complete and just needs to be cleaned up a tiny bit: the only big feature missing is deleting profiles.
