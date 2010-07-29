package couk.markstar.starrequests.stardribbblelib.requests
{
	import com.adobe.serialization.json.JSON;
	
	import couk.markstar.starrequests.requests.AbstractRequest;
	
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLVariables;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	internal class AbstractDribbbleRequest extends AbstractRequest
	{
		protected var _service:HTTPService;
		protected var _params:URLVariables;
		
		public function AbstractDribbbleRequest()
		{
			super();
			
			_service = new HTTPService( "http://api.dribbble.com/" );
			_service.addEventListener( FaultEvent.FAULT, serviceFaultListener );
			_service.addEventListener( ResultEvent.RESULT, serviceResultListener );
			
			_params = new URLVariables();
		}
		
		override public function send():void
		{
			super.send();
			_service.send( _params );
		}
		
		override protected function cleanup():void
		{
			_service.removeEventListener( FaultEvent.FAULT, serviceFaultListener );
			_service = null;
			_params = null;
			
			super.cleanup();
		}
		
		protected function serviceResultListener( e:ResultEvent ):void
		{
			var result:Object = JSON.decode( e.result.toString() );
			
			/*if( e.result.rsp.stat == "fail" )
			   {
			   failed( e.result.rsp.err.msg );
			   }
			
			   // need to add proper error handling here
			
			   if( e.result.rsp.stat == "ok" )
			 {*/
			_progressSignal.dispatch( 1 );
			parseResponse( result );
			cleanup();
			//}
		}
		
		protected function parseResponse( response:Object ):void
		{
			// leave blank - to be overridden in subclasses
		}
		
		protected function serviceFaultListener( e:FaultEvent ):void
		{
			failed( e.message.toString() );
		}
	}
}