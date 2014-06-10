var XMLJS = function(){};

XMLJS.apply = function(o, c, defaults){
    if(defaults){
        // no "this" reference for friendly out of scope calls
        XMLJS.apply(o, defaults);
    }
    if(o && c && typeof c == 'object'){
        for(var p in c){
            o[p] = c[p];
        }
    }
    return o;
};

XMLJS.apply(XMLJS, {
docObjs : new Array,
/**
* 初始化xml对象文件连接池
*/
initDocs : function(count)
{
   if(count == null) 
    count = 3;
  
   for(var i = 0; i < count; i++)
   {
    XMLJS.docObjs[i] = new Object;
    //把浏览器判断换成代码判断，而且把标准代码先判断执行，更加合适和具有兼容性
    //由于直接执行不兼容的代码会报错，所以采用try catch解决
    try
    {
     XMLJS.docObjs[i].doc = new DOMParser();
     XMLJS.docObjs[i].doc.async = false;
     XMLJS.docObjs[i].free = true;
    }
    catch(e)
    {
     XMLJS.docObjs[i].doc = new ActiveXObject('Microsoft.XMLDOM');
     XMLJS.docObjs[i].doc.async = false;
     XMLJS.docObjs[i].free = true;
    }

   }
},

/**
* 获得空闲xml文件docObj对象
*/
getFreeDocObj : function ()
{
   var docObj = null;
  
   for(var i = 0; i < XMLJS.docObjs.length; i++)
   {
    if(XMLJS.docObjs[i].free)
    {
     XMLJS.docObjs[i].free = false;
     docObj = XMLJS.docObjs[i];
     break;
    }
   }
  
   return docObj;
},

/**
* 解析xml
*/
parseXML : function (xmlContent)
{
   var docObj = XMLJS.getFreeDocObj();
   try
   { 
    var XmlDom = docObj.doc.parseFromString(xmlContent,"text/xml");
    docObj.free = true;
    return XmlDom;
   }
   catch(e)
   {
    docObj.doc.loadXML (xmlContent);//解析字符串不能用load必须用loadXML.(load解析载入文档的)
    var doc = docObj.doc;
    docObj.free = true;
    return doc;
   }
},

/**
* 解析xml
*/
parseXML2 : function (xmlContent)
{
   var xmlDoc;
   try
   { 
    xmlDoc = new DOMParser();
    var XmlDom = xmlDoc.parseFromString(xmlContent,"text/xml");
    return XmlDom;
   }
   catch(e)
   {
    xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
    xmlDoc.async = false;
    xmlDoc.loadXML(xmlContent);
    return xmlDoc;
   }
},

/**
* 获取xml子节点
* @param{domNode}dom节点
* @param{subNodeName}子节点名称
*/
getXMLSubNodes : function (domNode, subNodeName)
{
   var subNodes = [];
  
   var currentNode = domNode;
   var childNodes = null;
  
   var paths = subNodeName.split ("/");
  
   for (var i = 0; paths != null && i < paths.length-1; i++)
   {
    if (paths[i] == "")
     continue;
   
    childNodes = currentNode.childNodes;
  
    for (var j = 0; childNodes != null && j < childNodes.length; j++)
    {
     if (childNodes[j].nodeName.toLowerCase() == paths[i].toLowerCase())
     {
      currentNode = childNodes[j];
      break;
     }
    }
   }
  
   childNodes = currentNode.childNodes;
  
   for (var i = 0; i < childNodes.length; i++)
   {
    if (childNodes[i].nodeName.toLowerCase() == paths[paths.length-1].toLowerCase())
     subNodes.push (childNodes[i]);
   }
  
   return subNodes;
},

/**
* 获取xml根节点
* @param{doc}xml对象
*/
getXMLRootNode : function (doc)
{
   if (doc == null)
    return null;
  
   return doc.documentElement;
},

getXMLChildNodes: function(root)
{
   var itemNodes = [];
   var nodes = root.childNodes;
  
   for(var i=0;i<nodes.length;i++)
   {
    if(nodes[i].nodeType == 1)
    {
     itemNodes.push(nodes[i]);
     //alert(nodes[i].nodeName + nodes[i].nodeType);
    }
   }
  
   return itemNodes;
},

getXMLChildNode: function(doc_el, nodeName)
{
   var element = doc_el.getElementsByTagName (nodeName);
   return element.documentElement;
},

/**
* 获取xml节点的值
* @param{doc}xml对象
* @param{NodeName}节点名称
*/
getXMLNodeValue : function (doc,nodeName)
{
   if (doc == null)
   {
    return null;
   }
   return XMLJS.getXMLSingleNodeValue (doc.documentElement, nodeName);
},

/**
* 简化 DOM 访问的函数
* @param{doc_el} req.responseXML.documentElement
* @param{name} getElementsByTagName("name"), element name
* @param{idx} element index,exp:elements[0].firstChild.data
* @return nodevalue
* 
*/
getXMLSingleNodeValue: function(doc_el, nodeName)
{
   var element = doc_el.getElementsByTagName (nodeName);
   var nodevalue = "";
   if(element[0].firstChild != null)
   {
    nodevalue =element[0].firstChild.nodeValue;
   }
   return nodevalue;
   //return element[0].firstChild.nodeValue;
},

/**
* 获取xml节点的值
* @param{doc}xml对象
* @param{NodeName}节点名称
*/
getAttributeNodeValues : function (doc_el,nodeName,attributeName)
{
   if (doc_el == null)
   {
    return null;
   }
   var values = [];
   var len = doc_el.length;
   var value = "";
   for(var i = 0; i < len; i++)
   {
    if(doc_el[i].nodeName == nodeName)
    {
     value = doc_el[i].getAttribute(attributeName);
     values.push(value);
    }
   }
   return values;
},

/**
* 获取节点属性值的方法
* @param{doc_el} req.responseXML.documentElement
* @param{attributeName} node Attribute name
* @return nodevalue
* 
*/
getAttributeNodeValue: function(doc_el,attributeName)
{
   var nodevalue = "";
   if(doc_el != null)
   {
    nodevalue =doc_el.getAttribute(attributeName);
   }
   return nodevalue;
}

});
/**
* @deprecated 调用初始化xml文件对象方法,必须在定义后才能调用
* 
*/
XMLJS.initDocs();
