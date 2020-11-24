using Microsoft.Graph.Communications.Common.Telemetry;
using System;

namespace MSTeamsLiveSessionRecordingBott.Bot
{
    public class Service
    {
        public static readonly Service Instance = new Service();

        private readonly object syncLock = new object();

        private IDisposable callHttpServer;
       
        private bool started;

        private IGraphLogger logger;
        
        public IConfiguration Configuration { get; private set; }

        /*public void Initialize(IConfiguration config, IGraphLogger logger)
        {
            this.Configuration = config;
            this.logger = logger;
        }*/

        
       /* public void Start()
        {
            lock (this.syncLock)
            {
                if (this.started)
                {
                    throw new InvalidOperationException("The service is already started.");
                }

                Bot.Instance.Initialize(this, this.logger);

                // Start HTTP server for calls
                var callStartOptions = new StartOptions();
                foreach (var url in this.Configuration.CallControlListeningUrls)
                {
                    callStartOptions.Urls.Add(url.ToString());
                }

                this.callHttpServer = WebApp.Start(
                    callStartOptions,
                    (appBuilder) =>
                    {
                        var startup = new HttpConfigurationInitializer();
                        startup.ConfigureSettings(appBuilder, this.logger);
                    });

                this.started = true;
            }
        }

        
        public void Stop()
        {
            lock (this.syncLock)
            {
                if (!this.started)
                {
                    throw new InvalidOperationException("The service is already stopped.");
                }

                this.started = false;

                this.callHttpServer.Dispose();
                Bot.Bot.Instance.Dispose();
            }
        }*/
    }
}