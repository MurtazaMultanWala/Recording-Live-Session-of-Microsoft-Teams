using Microsoft.Skype.Bots.Media;
using System;
using System.Collections.Generic;

namespace MSTeamsLiveSessionRecordingBott.Bot
{
    public interface IConfiguration
    {
        string ServiceDnsName { get; }

        IEnumerable<Uri> CallControlListeningUrls { get; }

        Uri CallControlBaseUrl { get; }

        Uri PlaceCallEndpointUrl { get; }

        string AadAppId { get; }

        string AadAppSecret { get; }

        MediaPlatformSettings MediaPlatformSettings { get; }
    }
}