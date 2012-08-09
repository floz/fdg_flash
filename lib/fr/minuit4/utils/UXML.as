
/**
 * @author Arno
 */
package fr.minuit4.utils 
{
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	import flash.xml.XMLNodeType;
	
	public class UXML 
	{
		static public function parse(pXML:String):Object
		{
			var x:XMLDocument = new XMLDocument();
			x.ignoreWhite = true;
			x.parseXML(pXML);
			return parseNodeRecursively(x.firstChild, {});
		}
		
		static private function parseNodeRecursively(pNode:XMLNode, pR:Object):Object
		{
			var o:Object = { };
			for (var node:XMLNode = pNode.firstChild; node != null; node = node.nextSibling)
			{
				if(!pR[node.nodeName])
					pR[node.nodeName] = [];
					
				o = { };
				
				for (var i:String in node.attributes)
					o[i] = node.attributes[i];
					
				if (node.firstChild)
				{
					if( node.firstChild.nodeType == XMLNodeType.TEXT_NODE )
						o["nodeValue"] = node.firstChild.nodeValue;
					if(node.hasChildNodes())
						o = (parseNodeRecursively(node, o));
				}
				pR[node.nodeName].push(o);
			}
			return pR;
		}
	}
	
}