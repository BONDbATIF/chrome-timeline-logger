# best way to discover event data is to make a recording in the timeline tool and examine it's output ;)

###
event:
	// all events
	startTime:				{number}
	endTime:				{number}
	children:				{array}

	// optional
	data:					{object}
	frameId:				{number}
	usedHeapSizeDelta:		{number}
	usedHeapSize:			{number}
	counters:				{object} (see below for more detail)
	stackTrace: 			{object[]} (see below for more detail)
###


### counters object

	documents: 		{number}
	nodes:			{number}
	jsEventListeners:	{number}
	
###

### stackTrace item object

	"functionName" : "test.com",
	"scriptId" : "1047",
	"url" : "file:///test.txt",
	"lineNumber" : 1,
	"columnNumber" : 1

###



# useful event info

module.exports =
		###
		event:
			data:
				na
		###
		Root: "Root"

		###
		event:
			data:
				na
		###
		Program: "Program"


		###
		event:
			data:
				type: (string)
		###
		EventDispatch: "EventDispatch"

		###
		event:
			data:
				na
		###
		BeginFrame: "BeginFrame"


		###
			Hidden record
		###
		ScheduleStyleRecalculation: "ScheduleStyleRecalculation"

		###
		event:
			data:
				elementCount
		###
		RecalculateStyles: "RecalculateStyles"

		###
			Hidden record
		###
		InvalidateLayout: "InvalidateLayout"


		###
		// used for custom popups
		event:
			data:
				rootNode: {??} _relatedBackendNodeId
				x:			{number}
				y:			{number}
				height:		{number}
				width:		{number}
		###
		Layout: "Layout"

		###
		event:
			data:
				na
		###
		PaintSetup: "PaintSetup"

		###
		// used for clipping
		event:
			data:
				x:			{number}
				y:			{number}
				height:		{number}
				width:		{number}
		###
		Paint: "Paint"


		###
			// unknown
		###
		Rasterize: "Rasterize"
		ScrollLayer: "ScrollLayer"

		###
		event:
			url: {string}
		###
		DecodeImage: "DecodeImage"
		ResizeImage: "ResizeImage"

		###
		event:
			data:
				na
		###
		CompositeLayers: "CompositeLayers"


		###
		###
		ParseHTML: "ParseHTML"


		###
		event:
			data:
				timerId: {number}
		###
		TimerInstall: "TimerInstall"
		TimerRemove: "TimerRemove"
		TimerFire: "TimerFire"


		###
		event:
			url: {string}
		###
		XHRReadyStateChange: "XHRReadyStateChange"
		XHRLoad: "XHRLoad"

		###
		event:
			url: {string}
			data:
				lineNumber: {number}
		###
		EvaluateScript: "EvaluateScript"


		###
		event:
			data:
				isMainFrame: {boolean}
		###
		MarkLoad: "MarkLoad"

		###
			hidden record
		###
		MarkDOMContent: "MarkDOMContent"

		###
		event:
			data:
				message: {string}
		###
		TimeStamp: "TimeStamp"
		Time: "Time"
		TimeEnd: "TimeEnd"


		###
		event:
			url: {string}
		###
		ScheduleResourceRequest: "ScheduleResourceRequest"
		ResourceSendRequest: "ResourceSendRequest"

		###
		event:
			url: {string}
			data:
				requestId: {number}
		###
		ResourceReceiveResponse: "ResourceReceiveResponse"
		ResourceReceivedData: "ResourceReceivedData"
		ResourceFinish: "ResourceFinish"

		###
		event:
			data:
				scriptName: {string}
				scriptLine: {number}
		###
		FunctionCall: "FunctionCall"

		###
		event:
			data:
				usedHeapSizeDelta: {number}
		###
		GCEvent: "GCEvent"


		###
		event:
			data:
				id: {number}
		###
		RequestAnimationFrame: "RequestAnimationFrame"
		CancelAnimationFrame: "CancelAnimationFrame"
		FireAnimationFrame: "FireAnimationFrame"

		###
		event:
			data:
				url:				{string}
				webSocketURL:		{string}
				webSocketProtocol:	{string}
				message:			{string}
				identifier:			{number}
		###
		WebSocketCreate : "WebSocketCreate"
		WebSocketSendHandshakeRequest : "WebSocketSendHandshakeRequest"
		WebSocketReceiveHandshakeResponse : "WebSocketReceiveHandshakeResponse"
		WebSocketDestroy : "WebSocketDestroy"
