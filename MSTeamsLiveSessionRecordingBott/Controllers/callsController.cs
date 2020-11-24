using Microsoft.Graph.Communications.Client;
using NLog;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;

namespace MSTeamsLiveSessionRecordingBott.Controllers
{
    public class callsController : ApiController
    {
        private ICommunicationsClient Client => Bot.Bot.Instance.Client;

        private static Logger logger = NLog.LogManager.GetLogger("MSTeamsLiveSessionRecorderRule");


        [System.Web.Http.HttpPost]
        public async Task<HttpResponseMessage> IncomingRequestAsync()
        {

            var log = $"Received HTTP {this.Request.Method}, {this.Request.RequestUri}";
            logger.Info(log);

            #region Checking Request Content
            /*var content = await this.Request.Content.ReadAsStringAsync().ConfigureAwait(false);

            logger.Info(content);

            if (this.Request.Headers?.Authorization?.Parameter == null)
            {
                logger.Error("No header found");
                return new RequestValidationResult { IsValid = false };
            }


            else
            {
                //logger.Info(this.Request.Headers);
                return new RequestValidationResult { IsValid = true };
            }*/
            #endregion

            var response = await this.Client.ProcessNotificationAsync(this.Request).ConfigureAwait(false);

           response.Headers.ConnectionClose = true;
            return response;
        }


    }
}