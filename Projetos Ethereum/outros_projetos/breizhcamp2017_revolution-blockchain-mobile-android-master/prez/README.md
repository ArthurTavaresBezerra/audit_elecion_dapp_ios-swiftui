# Slides de la présentation Breizhcamp 2017

    Smartphone et Blockchain, armes de révolution massive

# How to use

```
# Install dependencies
$ npm install
# run tasks and serve
$ gulp
```

With the commands above, you have everything to start.

```
.
├── build
│   ├── css
│   │   └── main.css
│   ├── index.html
│   └── js
│       ├── main.js
│       └── vendor
│           ├── remark-fallback.js
│           ├── remark-language.js
│           └── remark.min.js
├── gulp
│   ├── index.js
│   ├── paths.js
│   └── tasks
│       ├── browser-sync.js
│       ├── default.js
│       ├── deploy-pages.js
│       ├── imagemin.js
│       ├── jade.js
│       ├── js.js
│       ├── stylus.js
│       └── watch.js
├── gulpfile.js
├── package.json
├── README.md
└── src
    ├── js
    │   ├── main.js
    │   └── vendor
    │       ├── remark-fallback.js
    │       ├── remark-language.js
    │       └── remark.min.js
    ├── slides
    │   ├── slide-1.md
    │   ├── slide-2.md
    │   └── slide-3.md
    ├── styl
    │   ├── main.styl
    │   ├── remark-themes
    │   │   └── default.styl
    │   └── vendor
    │       └── remark.styl
    └── templates
        ├── inc
        │   ├── head.jade
        │   └── scripts.jade
        └── index.jade

```

### How to use with git and deploy to Github Pages

The first deploy needs to be manual:

```sh
# creates a gh-pages branch
git checkout -b gh-pages

# push and track the gh-pages branch
git push --set-upstream origin gh-pages
```

To do next deploys, you just have to run with gulp:

```sh
# will create a .publish folder with build content
# and push to gh-pages branch.
gulp deploy-pages
```

### Tasks

- `gulp`: Initialize watch for changes and a server (localhost:3000);
- `gulp js`: Execute js files;
- `gulp stylus`: Compile stylus files;
- `gulp imagemin`: Compress image files;
- `gulp watch`: Call for watch files;
- `gulp jade`: Compile jade files;
- `gulp deploy-pages`: Deploy compiled files at `build` to `github` on branch `gh-pages`.