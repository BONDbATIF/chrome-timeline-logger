# nodejs dependencies
fsUtil = require('fs')
TimelineRecordTypes = require("./TimelineRecordTypes")

# Main object for creating timeline events

#================
# 
#================
class TimelineLogger

	constructor: (version) ->
		# version field that is used at the top of each log file
		@version = version or "chrome-timeline-logger"

	# instance

	#================
	save: (filename, topLevelEvents, complete) ->

		if Array.isArray(topLevelEvents) == false
			saveRecords = [topLevelEvents]
		else
			saveRecords = topLevelEvents

		saveRecords = saveRecords
		unless saveRecords
			throw new Error("TimelineLogger: There are no timeline records to save")

		now = new Date();
		filename = filename or "timeline-#{now.toISO8601Compact()}.json"

		callback = (stream) ->
			if complete
				stream.on "close", complete
			saver = new TimelineSaver(stream)
			saver.save saveRecords, @version, complete

		_createFileWriter filename, callback.bind(@)

	#================
	saveSync: (filename, topLevelEvents) ->

		if Array.isArray(topLevelEvents) == false
			saveRecords = [topLevelEvents]
		else
			saveRecords = topLevelEvents

		saveRecords = saveRecords
		unless saveRecords
			throw new Error("TimelineLogger: There are no timeline records to save")

		now = new Date();
		filename = filename or "timeline-#{now.toISO8601Compact()}.json"

		callback = (stream) ->
			saver = new TimelineSaver(stream)
			saver.save saveRecords, @version

		_createFileWriterSync filename, callback.bind(@)

	# private

	#================
	_createFileWriter = (filename, callback) ->
		stream = new fsUtil.createWriteStream(filename)
		callback(stream)

	#================
	_createFileWriterSync = (filename, callback) ->
		# fakes a createWriteStreamSync
		stream =
			buffer: ""
			write: (append) ->
				@buffer += append
			close: ->
				fsUtil.writeFileSync(filename, @buffer)

		callback(stream)



#================
# 
#================
class TimelineSaver

	# instance

	#================
	constructor: (@_stream) ->

	#================
	save: (@_records, version) ->
		@_recordIndex = 0
		@_prologue = "[#{JSON.stringify(version)}"
		@_writeNextChunk(@_stream)

	#================
	_writeNextChunk: (stream) ->
		separator = ",\n"
		data = []
		length = 0

		if @_prologue
			data.push @_prologue
			length += @_prologue.length
			@_prologue = null
		else
			if @_recordIndex == @_records.length
				stream.close()
				return
			data.push ""

		while @_recordIndex < @_records.length
			item = JSON.stringify(@_records[@_recordIndex])
			itemLength = item.length + separator.length
			if (length + itemLength) > TimelineLogger.TransferChunkLengthBytes
				break;

			length += itemLength
			data.push item
			@_recordIndex++

		if @_recordIndex == @_records.length
			data.push(data.pop() + "]")

		stream.write(data.join(separator))
		@_writeNextChunk(stream)



#================
# 
#================
class TimelineRecord

	#================
	constructor: ( @type, @data) ->

		# all event data
		unless @data
			@data = {}

		unless @children
			@children = new Array()

		@startTime = 0
		@endTime = 0

		### some but not all record types
			frameId:				{number}
			usedHeapSizeDelta		{number}
			usedHeapSize:			{number}
			counters:				{object}
				documents:			{number}
				nodes:				{number}
				jsEventListeners:	{number}
			stackTrace				{array}
		###

	#================
	start: ->
		@startTime = Date.now()
		return @

	#================
	end: ->
		@endTime = Date.now()
		return @


#================
# 
#================
class TimelineBuilder

	#================
	constructor: ->
		@savedRecords = []
		@history = []
		@currentRecord = null

	#================
	startEvent: (type, data) ->

		# create a new child event
		newEvent = new TimelineRecord(type, data)

		if @currentRecord

			# add the new event to the current children
			@currentRecord.children.push newEvent

		# current becomes history
		@history.push @currentRecord

		# new event becomes current
		@currentRecord = newEvent

		# start the new event
		newEvent.start()

		return newEvent

	#================
	endEvent: ->
		# end the current event
		@currentRecord.end()

		# if we have a parent then make it the current event
		if @history.length == 0
			throw new Error("TimelineLogger: Already on the root event so there are no more timeline events to end.")
		else
			# save the last record
			if @history.length == 1
				@savedRecords.push @currentRecord

			# pop our history tree level stack
			@currentRecord = @history.pop()

		return


module.exports = {TimelineLogger, TimelineBuilder, TimelineRecord, TimelineRecordTypes}
