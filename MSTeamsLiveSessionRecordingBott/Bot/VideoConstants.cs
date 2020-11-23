using Microsoft.Skype.Bots.Media;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MSTeamsLiveSessionRecordingBott.Bot
{
    public class VideoConstants
    {
        public const uint NumberOfMultiviewSockets = 3;

        public static readonly List<VideoFormat> SupportedSendVideoFormats = new List<VideoFormat>
        {
            VideoFormat.H264_1280x720_30Fps,
            VideoFormat.H264_640x360_30Fps,
            VideoFormat.H264_320x180_15Fps,
        };
    }
}