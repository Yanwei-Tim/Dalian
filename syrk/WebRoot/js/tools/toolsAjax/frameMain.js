if(typeof FrameTools =="undefined" || !FrameTools){
   var FrameTools = {};
};
FrameTools = function(){
	this.pk =  Math.random();
};
/**
 * @title: FrameTools.Ajax 
 * @description:Ajax封装对象
 * @author: Li_Zhenzhong@founder.com 
 * @param url <String> 发送请求的地址
 * @param callback <Function> 回调函数
 * @date：2012-9-7下午3:39:05
 */
FrameTools.Ajax = function(url,callback){
	/*
	 * (默认: 当前页地址) 发送请求的地址
	 */
	this.url = url!=null?url:"";
	/*
	 * 发送到服务器的数据。将自动转换为请求字符串格式。GET 请求中将附加在 URL 后。查看 processData 选项说明以禁止此自动转换。必须为 Key/Value 格式。
	 * 如果为数组，jQuery 将自动为不同值对应同一个名称。如 {foo:["bar1", "bar2"]} 转换为 '&foo=bar1&foo=bar2'。
	 */
	this.data = null;
	/*
	 * (默认: true) 默认设置下，所有请求均为异步请求。
	 * 如果需要发送同步请求，请将此选项设置为 false。注意，同步请求将锁住浏览器，用户其它操作必须等待请求完成才可以执行。
	 */
	this.async = true;
	/*
	 * 设置请求超时时间（毫秒）。此设置将覆盖全局设置。
	 */
	this.timeout = 3000000;
	/*
	 * (默认: "GET") 请求方式 ("POST" 或 "GET")， 默认为 "GET"。
	 * 注意：其它 HTTP 请求方法，如 PUT 和 DELETE 也可以使用，但仅部分浏览器支持。
	 */
	this.type = "POST";
	/*
	 * (默认: true) jQuery 1.2 新功能，设置为 false 将不会从浏览器缓存中加载请求信息。
	 */
	this.cache = true;
	
	/*
	 * (默认: true) 是否触发全局 AJAX 事件。设置为 false 将不会触发全局 AJAX 事件，如 ajaxStart 或 ajaxStop 。可用于控制不同的Ajax事件
	 */
	this.global = "true";
	/*
	 * (默认: "application/x-www-form-urlencoded") 发送信息至服务器时内容编码类型。默认值适合大多数应用场合。
	 */
	this.contentType = "application/x-www-form-urlencoded";
	/*
	 * 预期服务器返回的数据类型。如果不指定，jQuery 将自动根据 HTTP 包 MIME 信息返回 responseXML 或 responseText，并作为回调函数参数传递，可用值:
	 * "xml": 返回 XML 文档，可用 jQuery 处理。
	 * "html": 返回纯文本 HTML 信息；包含 script 元素。
	 * "script": 返回纯文本 JavaScript 代码。不会自动缓存结果。
	 * "json": 返回 JSON 数据 。
	 * "jsonp": JSONP 格式。使用 JSONP 形式调用函数时，如 "myurl?callback=?" jQuery 将自动替换 ? 为正确的函数名，以执行回调函数。
	 */
	this.dataType = "json";
	/*
	 * (默认: false) 仅在服务器数据改变时获取新数据。使用 HTTP 包 Last-Modified 头信息判断。
	 */
	this.ifModified = false;
	/*
	 * (默认: true) 默认情况下，发送的数据将被转换为对象(技术上讲并非字符串) 以配合默认内容类型 "application/x-www-form-urlencoded"。
	 * 如果要发送 DOM 树信息或其它不希望转换的信息，请设置为 false。
	 */
	this.processData = true;
	/*
	 * 请求成功后回调函数。这个方法有两个参数：服务器返回数据，返回状态
	 */
	this.success = callback!=null?(typeof(callback)=="function"?callback:alert("回调函数类型错误！")):function (data, textStatus) {};
	/*
	 * (默认: 自动判断 (xml 或 html)) 请求失败时将调用此方法。这个方法有三个参数：XMLHttpRequest 对象，错误信息，（可能）捕获的错误对象。
	 */
	this.error = function (XMLHttpRequest, textStatus, errorThrown) {FrameTools.Ajax.handleAjaxErrorRequest(XMLHttpRequest);};
	/*
	 * 发送请求前可修改 XMLHttpRequest 对象的函数，如添加自定义 HTTP 头。XMLHttpRequest 对象是唯一的参数。
	 */
	this.beforeSend = function (XMLHttpRequest) {};
	/*
	 * 请求完成后回调函数 (请求成功或失败时均调用)。参数： XMLHttpRequest 对象，成功信息字符串。
	 */
	this.complete =function (XMLHttpRequest, textStatus) {};
};
/**
 * @title: send 
 * @description:发送请求
 * @author: Li_Zhenzhong@founder.com 
 * @param data 求情参数
 * @date：2012-9-7下午5:00:45
 */
FrameTools.Ajax.prototype.send = function(data){
	$.ajax({
		type : this.type,
		cache : this.cache,
		url : this.url,
		data : data,
		dataType : this.dataType,
		timeout : this.timeout,
		global : this.global,
		async : this.async,
		contentType : this.contentType,
		ifModified : this.ifModified,
		processData : this.processData,
		success : this.success,
		beforeSend :this.beforeSend,
		complete : this.complete,
		error : this.error
	});
};
/**
 * @title: handleAjaxErrorRequest 
 * @description:统一处理Ajax请求错误 (依赖框架：jquery + easyUi)
 * @author: Li_Zhenzhong@founder.com 
 * @param request 
 * @date：2012-9-7下午4:16:42
 */
FrameTools.Ajax.handleAjaxErrorRequest = function(request) {
	if(request){
		if(request.readyState==4){
			if(request.status!=200) console.log('系统处理过程中发生异常');
		}else{
			var msg = "服务器响应失败！<br>";
			if(request.readyState) msg += "<br>请求状态码："+request.readyState;
			if(request.status) msg += "<br>响应状态码："+request.status;
			alert(msg);				
		}
	}else{
		alert('请求错误！<br>请求对象为空，请联系系统管理员。');
	}
	$(document.body).unmask();
};