# Contributing

## Bug reports

[Post your bug report on the GitHub Issue Tracker for this project](https://github.com/pflannery/timeline-logger/issues)


## Development

### Setup for development

Cakefile defines the following tasks:

```
cake clean                # clean up instance
cake install              # install dependencies
cake compile              # compile our coffee files (runs install)
cake watch                # watches our coffee files for changes (runs install)
cake prepublish           # prepare our package for publishing
cake publish              # publish our package (runs prepublish)
cake scaffold             # gives a list of base apps from which to scaffold from
cake test                 # runs our tests (runs compile)
cake test.install         # npm install app and test dependencies
cake test.setup           # runs test.install and compiles source
cake test.debug           # runs 'npm run-script debug'
cake zip.modules          # zip's the ./node_modules to ./build/node_modules.tar.gz
cake unzip.modules        # unzip's the ./build/node_modules.tar.gz to to ./node_modules folder
```
