# Chrome Timeline Logger

[![Build Status](https://secure.travis-ci.org/pflannery/timeline-logger.png?branch=master)](http://travis-ci.org/pflannery/timeline-logger "Check this project's build status on TravisCI")
[![NPM version](https://badge.fury.io/js/timeline-logger.png)](https://npmjs.org/package/timeline-logger "View this project on NPM")
[![Dependency Status](https://gemnasium.com/pflannery/timeline-logger.png)](https://gemnasium.com/pflannery/timeline-logger)
[![Gittip donate button](http://img.shields.io/gittip/pflannery.png)](https://www.gittip.com/pflannery/ "Donate weekly to this project using Gittip")
[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/pflannery/timeline-logger/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

This logger helps generates a timeline JSON file that's compatible with the Chrome Dev Tools timeline viewer

## Installation

    npm install chrome-timeline-logger

## Usage

    var timeline = require('chrome-timeline-logger');
    var builder = new timeline.TimelineBuilder();

    // create a Program record
    programEvent = builder.createEvent("Program");

    // create a TimeStamp record
    builder.createEvent("TimeStamp", {message: "hi mum!"});

    //	do some stuff
    for(var index; index<100; index++)
        console.log("Some output");

    // end the TimeStamp record
    builder.end();

    // end the Program record
    builder.end();
    
    var logger = new timeline.TimelineLogger();
    logger.save "some-file-path", programEvent

## API

######TimelineLogger

|name|type|args|description
|----|----|----|-----------
|save|method|string filepath, timelineRecordList[]|saves an array of timeline records to a file specified by the filepath

######TimelineBuilder

|name|type|args|description
|----|----|----|-----------
|startEvent         |method|string type, [object data]|starts a timeline event. Types are defined in [TimelineRecordTypes](./src/TimelineRecordTypes.coffee)
|endEvent           |method|none|ends the currently started timeline event.
<--|reset           |method|none|resets all events back to no events -->

######TimelineRecord
|name|type|args|description
|----|----|----|-----------
|start|method|none|sets startTime to Date.now()
|end|method|none|sets endTime to Date.now()
|startTime|number||
|endTime|number||
|children|TimelineRecord[]||
|data|object||
|frameId|number||
|usedHeapSize|number||
|usedHeapSizeDelta|number||
|counters|object||
|stackTrace|object||

## History
[You can discover the history inside the `History.md` file](https://github.com/pflannery/timeline-logger/blob/master/History.md#files)

## Contributing
[You can discover the contributing instructions inside the `Contributing.md` file](https://github.com/bevry/timeline-logger/blob/master/Contributing.md#files)

## License
Licensed under the incredibly [permissive](http://en.wikipedia.org/wiki/Permissive_free_software_licence) [MIT License](http://creativecommons.org/licenses/MIT/)
<br/>Copyright &copy; 2013+ Stringz Solutions Ltd
<br/>Copyright &copy; 2013+ [Peter Flannery](http://github.com/pflannery)
