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
* ��ʼ��xml�����ļ����ӳ�
*/
initDocs : function(count)
{
   if(count == null) 
    count = 3;
  
   for(var i = 0; i < count; i++)
   {
    XMLJS.docObjs[i] = new Object;
    //��������жϻ��ɴ����жϣ����Ұѱ�׼�������ж�ִ�У����Ӻ��ʺ;��м�����
    //����ֱ��ִ�в����ݵĴ���ᱨ�����Բ���try catch���
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
* ��ÿ���xml�ļ�docObj����
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
* ����xml
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
    docObj.doc.loadXML (xmlContent);//�����ַ���������load������loadXML.(load���������ĵ���)
    var doc = docObj.doc;
    docObj.free = true;
    return doc;
   }
},

/**
* ����xml
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
* ��ȡxml�ӽڵ�
* @param{domNode}dom�ڵ�
* @param{subNodeName}�ӽڵ�����
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
* ��ȡxml���ڵ�
* @param{doc}xml����
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
* ��ȡxml�ڵ��ֵ
* @param{doc}xml����
* @param{NodeName}�ڵ�����
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
* �� DOM ���ʵĺ���
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
* ��ȡxml�ڵ��ֵ
* @param{doc}xml����
* @param{NodeName}�ڵ�����
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
* ��ȡ�ڵ�����ֵ�ķ���
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
* @deprecated ���ó�ʼ��xml�ļ����󷽷�,�����ڶ������ܵ���
* 
*/
XMLJS.initDocs();
