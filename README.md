# Podcast Transcribe - a language learning helper

This app helps use podcasts in different languages you like to learn, downloads the episodes,
transcribes the episodes with the help of WhisperCpp and displays the transcript to in combination
with the audio.
So you can listen and reading at the same time ... and learn.

## Installation and running of Podcast Transcribe

How to run this app:

This app is based on ruby on rails. So you need a funtioning Ruby installation (Version 3.4 would be the best).
You also need whispercpp.

Execute the following to init whispercpp

```
  git submodule update --init --depth=1
```

after that go to vendor/whisper.cpp and execute

```
mkdir build
cd build
cmake ../
make
```

After that you should have whispercpp-cli in vendor/whisper.cpp/build/bin/

### Podman / Docker

The easiest way to run this is with the help of Podman or Docker. In this
README the examples use _podman_ but you can exchange it seamlessly with _docker_.
To take advantage of this just run

```
podman compose -f docker-compose.yml up
```

you need to download a model for the whisperserver - so far base.en.bin is enough for testing
Here you can download it: https://huggingface.co/ggerganov/whisper.cpp/tree/main
put it into storage/whisper/models
