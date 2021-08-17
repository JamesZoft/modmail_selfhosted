#!/bin/bash
cd /modmail/twilight-dispatch && cargo run --release 1&>/dev/null 2&>/dev/null &
sleep 20
cd /modmail/modmail && python3 launcher.py