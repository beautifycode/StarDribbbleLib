package couk.markstar.starrequests.stardribbblelib.requests
{
	import couk.markstar.starrequests.stardribbblelib.utils.DribbbleDataParserUtil;
	import couk.markstar.starrequests.stardribbblelib.vo.Players;
	import couk.markstar.starrequests.stardribbblelib.vo.Shots;
	
	import org.osflash.signals.Signal;
	
	internal class AbstractPaginatedPlayersRequest extends AbstractDribbbleRequest
	{
		public function AbstractPaginatedPlayersRequest( page:uint = 1, amountPerPage:uint = 15 )
		{
			super();
			
			_params.per_page = amountPerPage > 30 ? 30 : amountPerPage;
			_params.page = page;
			
			_completedSignal = new Signal( Players );
		}
		
		override protected function parseResponse( response:Object ):void
		{
			_completedSignal.dispatch( new DribbbleDataParserUtil().parsePlayers( response ) );
		}
	}
}