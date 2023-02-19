![True](https://user-images.githubusercontent.com/449385/218269421-fe1d6c7b-128c-410a-9307-6cf50bfdf7cc.svg)

# True

The microsite for the music video "True", by Brightly.

> 🚨 **Note:** It's been a long time since this project was built, and the underlying technologies have changed. A lot. With the goal of keeping the spirit of this project alive, I've created a modern version, mostly by patching and noodling my way through already minified code. As a result, [True](https://true.wearebrightly.com/) works on modern devices, like mobile, but this repo is no longer reflective of the underlying code. You can find the Frankenstein's monster [that is currently deployed here](https://github.com/superhighfives/true).

---

## Getting started

1. Run `npm install` (You'll need [Node JS](http://nodejs.org) installed)
2. Run `bower install` (If you don't have it, run `npm install bower -g`)
3. Make sure you've got `grunt` (Install with `npm install grunt-cli -g`)
4. If you get a `compass` error, run `gem install compass`

## Fire it up

To serve locally, run `grunt server`.

## Deployment

To deploy to Rackspace, move `example.rackspace.json` to `rackspace.json` and update your credentials.
- Make sure you've got gulp, using `npm install gulp -g`
- Run `gulp deploy` to deploy the site **without** media
- Run `gulp deploy-all` to deploy the site **with** media
