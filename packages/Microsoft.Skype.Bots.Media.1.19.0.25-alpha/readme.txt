Microsoft Real-Time Media Platform for Bots API preview

Microsoft.Skype.Bots.Media API reference documentation is available at:
https://microsoftgraph.github.io/microsoft-graph-comms-samples/docs/bot_media/index.html.

For an overview of the Real-Time Media Platform for Bots, please see:
https://docs.microsoft.com/en-us/microsoftteams/platform/bots/calls-and-meetings/real-time-media-concepts

See https://github.com/microsoftgraph/microsoft-graph-comms-samples
for sample code and to report issues or ask questions.

Recent Changes and New Features in the Microsoft.Skype.Bots.Media API
=====================================================================

1.19:

* Bug fixes:
  - fixed: A bug introduced in 1.18 where a null reference exception was 
  being thrown when the bot is run either attached to a debugger, 
  or in the Azure Cloud Service emulator.

  Thank you to our partners for reporting bugs and issues to us!

1.18:

* AudioSocket.ToneReceived event args expose a new property, SequenceId.
  The AudioSocket should raise tones in order, but the sequence ID can be 
  used to detect missing tones or if the bot's tone processing is asynchronous.

* Bug fixes:

  - fixed: an undocumented limit of 50 simultaneous VideoSockets could
  be configured to receive video in the "raw"/decoded NV12 color format.
  If the bot tried to create more than 50 concurrent VideoSockets to
  receive NV12-format video, many VideoSocket.Subscribe API operations
  would fail silently and the VideoSocket would not receive any video
  frames. The fix increases the limit to 1000 simultaneous VideoSockets.

  - fixed: a small memory leak per bot call.

  Thank you to our partners for reporting bugs and issues to us!

1.17:

* AudioSocket/VideoSocket.GetQualityOfExperienceData() methods expose 
  additional quality metrics.

* Bug fixes:

  - fixed: A media platform memory leak could occur due to a race condition
  during resolution changes in the video encoded (H264) send path. The leak 
  could also have led to crashes under certain conditions.

  - fixed: The first video frame received in the video receive path would
  have 0 as the MediaSourceId instead of the ID of the source.

  Thank you to our partners for reporting bugs and issues to us!

1.16:

* IMPORTANT! The media libraries now require the Visual C++ 2019
  Runtime for x64. You can obtain the VC++ x64 runtime redistributable
  (VC_redist.x64.exe) from:

  https://support.microsoft.com/en-us/help/2977003/the-latest-supported-visual-c-downloads

  As part of the startup of the real-time media bot's VM, the
  VC_redist.x64.exe must be executed in order to ensure the runtime is
  installed. The following is a sample script to do this:

  @echo off
  set logfile=C:\InstallCppRuntime-%MONITORING_ROLE%.log
  Startup\VC_redist.x64.exe /quiet
  echo %date% %time% ErrorLevel=%errorlevel% >> %logfile%
  exit /b %errorlevel%

* Bug fixes:

  - fixed: A media platform crash could occur when a bot participates
  in a large meeting and sends video in a "raw" format, such as NV12.

  - fixed: the VideoSendStatusChangedArgs.MediaType property would
  always indicate MediaType.Audio instead of the VideoSocket's actual
  MediaType value. The VideoMediaStreamQualityChangedEventArgs class
  was also missing a MediaType property.

  Thank you to our partners for reporting bugs and issues to us!

1.15:

* AudioSocket/VideoSocket.GetQualityOfExperienceData() methods
  provide media quality metrics such as packet loss and jitter.
  The bot may query these QoE metrics periodically to monitor the
  health of its media streams.

1.14:

* AudioSocketSettings.ReceiveUnmixedMeetingAudio option allows the bot
  to receive separate, unmixed audio of the active speakers in a meeting.
  The AudioMediaBuffer.UnmixedAudioBuffers property provides the unmixed
  audio frames of the active speakers.

  Note: unmixed audio is optimized for machine cognition (e.g., speech
  recognition/transcription) rather than for human listening. Certain
  error concealment treatments (e.g, to mitigate packet losss) are not
  applied to received audio in unmixed mode.

* AudioSocket.SendDtmfTone/SendDtmfTones() methods allow the bot to
  send DTMF tones. These APIs might be useful in testing an IVR-like
  system.
