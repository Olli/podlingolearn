- go to vendor whispercpp and "make"
- then "models/download-ggml-model.sh <desired model>"
- put that model name into "config/audio2text.yml"

- go to vendor/audio2text
    make that
    python -m venv .env
    source .env/bin/activate
    pip install -U pip
    pip install -r requirements.txt
