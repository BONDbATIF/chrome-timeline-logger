# test suite tools
assert = require('assert')
joe = require('joe')
{expect} = require('chai')
balUtil = require('bal-util')
fsUtil = require('fs')
_ = require('lodash')

# app test dependencies
#================
{TimelineLogger, TimelineBuilder, TimelineRecordTypes} = require("../../out/TimelineLogger")

testOutPath = "./test/out-actual"
testOutExpectedPath = "./test/out-expected"

testConfig =
	removeWhitespace: false
	contentRemoveRegex: null

generateMethods = []


# remove the out-actual folder if present
if fsUtil.existsSync(testOutPath) 
	files = fsUtil.readdirSync(testOutPath)

	for file in files
		fsUtil.unlinkSync(testOutPath + "/" + file)

	fsUtil.rmdirSync(testOutPath)

# ensure the out-actual folder exists.
fsUtil.mkdirSync(testOutPath)

#================
# Following was taken from docpads file testing. written by http://github.com/balupton
joe.suite "Timeline Events", (suite, test) ->
		test 'generate', (done) ->
			# generate the out-actual files

			ProgramRecordTest()
			
			for index in [0...generateMethods.length]
				generateMethods[index]()

			expect(1).to.eql(1)
			# Forward
			done()

		suite 'results', (suite,test,done) ->
			# Get actual results
			balUtil.scanlist testOutPath, (err,outResults) ->
				return done(err)  if err

				# Get expected results
				balUtil.scanlist testOutExpectedPath, (err,outExpectedResults) ->
					return done(err)  if err

					# Prepare
					outResultsKeys = Object.keys(outResults)
					outExpectedResultsKeys = Object.keys(outExpectedResults)

					# Check we have the same files
					test 'same files', ->
						outDifferenceKeys = _.difference(outResultsKeys, outExpectedResultsKeys)
						expect(outDifferenceKeys).to.be.empty
						expect(generateMethods.length+1).to.eql(outResultsKeys.length)
					# Check the contents of those files match
					outResultsKeys.forEach (key) ->
						test "same file content for: #{key}", ->
							# Fetch file value
							actual = outResults[key]
							expected = outExpectedResults[key]

							# Remove empty lines
							if testConfig.removeWhitespace is true
								replaceLinesRegex = /\s+/g
								actual = actual.replace(replaceLinesRegex, '')
								expected = expected.replace(replaceLinesRegex, '')

							# Content regex
							if testConfig.contentRemoveRegex
								actual = actual.replace(testConfig.contentRemoveRegex, '')
								expected = expected.replace(testConfig.contentRemoveRegex, '')

							# Compare
							try
								expect(actual).to.eql(expected)
							catch err
								console.log '\nactual:'
								console.log actual
								console.log '\nexpected:'
								console.log expected
								console.log ''
								throw err

					# Forward
					done()

			# Chain
			@

debugger
startTime = 0
#================
ProgramRecordTest = (childCallback) ->
	# setup
	builder = new TimelineBuilder()
	programEvent = builder.startEvent("Program")

	# call the callbck if passed
	if childCallback
		opts = {}
		filename = childCallback(builder)
	else
		filename = "ProgramRecordTest"

	#
	builder.endEvent()

	# override the time as it's always different
	programEvent.startTime = 1
	programEvent.endTime = 50001

	# test
	logger = new TimelineLogger()
	logger.version = "tests"
	logger.save "#{testOutPath}/#{filename}.json", programEvent

	return

#================
generateMethods.push (childCallback) ->
	ProgramRecordTest (builder) ->
		eventDispatchEvent = builder.startEvent(TimelineRecordTypes.EventDispatch, {type: "TestEvent"})

		# end the timeline event
		builder.endEvent()

		# override the time as it's always different
		eventDispatchEvent.startTime = 1
		eventDispatchEvent.endTime = 10

		return "EventDispatchRecordTest"

#================
generateMethods.push (childCallback) ->

	ProgramRecordTest (builder) ->
		beginFrameEvent = builder.startEvent(TimelineRecordTypes.BeginFrame)

		# end the timeline event
		builder.endEvent()

		# override the time as it's always different
		beginFrameEvent.startTime = 1
		beginFrameEvent.endTime = 10

		return "BeginFrameRecordTest"

#================
generateMethods.push (childCallback) ->

	ProgramRecordTest (builder) ->
		recalculateStylesEvent = builder.startEvent(TimelineRecordTypes.RecalculateStyles, {data: elementCount: 25})

		# end the timeline event
		builder.endEvent()

		# override the time as it's always different
		recalculateStylesEvent.startTime = 1
		recalculateStylesEvent.endTime = 10

		return "RecalculateStylesRecordTest"

#================
generateMethods.push (childCallback) ->

	ProgramRecordTest (builder) ->
		layoutEvent = builder.startEvent(TimelineRecordTypes.Layout, {x: 25, y: 52, width: 123, height: 321})

		# end the timeline event
		builder.endEvent()

		# override the time as it's always different
		layoutEvent.startTime = 1
		layoutEvent.endTime = 10

		return "LayoutRecordTest"

#================
generateMethods.push (childCallback) ->

	ProgramRecordTest (builder) ->

		paintSetupEvent = builder.startEvent(TimelineRecordTypes.PaintSetup)

		# end the timeline event
		builder.endEvent()

		# override the time as it's always different
		paintSetupEvent.startTime = 1
		paintSetupEvent.endTime = 10

		return "PaintSetupRecordTest"

#================
generateMethods.push (childCallback) ->

	ProgramRecordTest (builder) ->

		paintEvent = builder.startEvent(TimelineRecordTypes.Paint, {x: 3425, y: 572, width: 444, height: 1251})

		# end the timeline event
		builder.endEvent()

		# override the time as it's always different
		paintEvent.startTime = 1
		paintEvent.endTime = 10

		return "PaintRecordTest"

#================
generateMethods.push (childCallback) ->

	ProgramRecordTest (builder) ->

		rasterizeEvent = builder.startEvent(TimelineRecordTypes.Rasterize)

		# end the timeline event
		builder.endEvent()

		# override the time as it's always different
		rasterizeEvent.startTime = 1
		rasterizeEvent.endTime = 10

		return "RasterizeRecordTest"

#================
generateMethods.push (childCallback) ->

	ProgramRecordTest (builder) ->

		decodeImageEvent = builder.startEvent(TimelineRecordTypes.DecodeImage, {url: "http://github.com/pflannery/chrome-timeline-logger"})

		# end the timeline event
		builder.endEvent()

		# override the time as it's always different
		decodeImageEvent.startTime = 1
		decodeImageEvent.endTime = 10

		return "DecodeImageRecordTest"

#================
generateMethods.push (childCallback) ->

	ProgramRecordTest (builder) ->

		compositeLayersEvent = builder.startEvent(TimelineRecordTypes.CompositeLayers)

		# end the timeline event
		builder.endEvent()

		# override the time as it's always different
		compositeLayersEvent.startTime = 1
		compositeLayersEvent.endTime = 10

		return "CompositeLayersRecordTest"

#================
generateMethods.push (childCallback) ->

	ProgramRecordTest (builder) ->
		parseHTMLEvent = builder.startEvent(TimelineRecordTypes.ParseHTML)
		parseHTMLEvent.stackTrace = [{
					"functionName" : "L",
					"scriptId" : "114",
					"url" : "https://someurl/to.a.script.file",
					"lineNumber" : 73,
					"columnNumber" : 184
				}]

		# end the timeline event
		builder.endEvent()

		# override the time as it's always different
		parseHTMLEvent.startTime = 1
		parseHTMLEvent.endTime = 10

		return "ParseHTMLRecordTest"


#================
generateMethods.push (childCallback) ->


	ProgramRecordTest (builder, opts) ->

		# fake time
		opts = 
			fakeStartTime: 1
			fakeEndTime: (5000 * 10)

		# child timestamp count
		timestampCount = 10

		# fake heap
		usedHeapSize = 100000

		functionCallEvent = builder.startEvent(TimelineRecordTypes.FunctionCall, {scriptName: "file://doesnotexist.js", scriptLine: 2111})
		functionCallEvent.startTime = opts.fakeStartTime
		functionCallEvent.frameId = 120.1

		# create child timestamp message
		for childIndex in [0...timestampCount]
			timeStampEvent = builder.startEvent("TimeStamp", {message: "Test Message #{childIndex}"})
			timeStampEvent.frameId = 120.1
			timeStampEvent.usedHeapSize = usedHeapSize
			timeStampEvent.counters = documents: childIndex
			builder.endEvent()

			# fake the times after for testing
			timeStampEvent.startTime = opts.fakeStartTime
			timeStampEvent.endTime = opts.fakeStartTime + 5000

			# update time position
			opts.fakeStartTime += 5000
			# update heap position
			usedHeapSize += 100000

		# end the timeline event
		builder.endEvent()

		# fake the end time
		functionCallEvent.endTime = functionCallEvent.startTime + opts.fakeEndTime
		functionCallEvent.usedHeapSize = usedHeapSize

		return "MultiRecordTest"
