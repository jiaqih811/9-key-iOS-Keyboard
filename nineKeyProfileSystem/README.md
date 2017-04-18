# 9 Key Keyboard Profile System

## Installation

(Note that this installation process assumes a little bit of knowledge of the terminal)

You'll need to install Node JS and `npm` for this to work. For Debian users, I found that the default versions given with `apt` were insufficient, so you'll want to go and download the newest stable versions of both.

After installing both, in the directory with the `package.json` file, run `npm install`. This will install all the Node dependencies we use. After that, run `node index.js`, and the app should deploy on your machine. Go ahead to `localhost:3000` in your browser and you should see the app running.

**NOTE:** Since we use some private credentials to query Firebase, not all of the backend functionality will work on your computer. For actual testing and not just running, you'll want to go to the deployed version above.

## Back End

The back end is written in Node JS, and relies on Google Firebase to store/ retrieve data. It is being developed using RESTful API principles, and offers a few operations that are detailed in the code.