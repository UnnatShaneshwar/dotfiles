#!/bin/bash

VOLUME_MUTE=""
VOLUME_LOW=""
VOLUME_MID=""
VOLUME_HIGH=""
SOUND_LEVEL=$(pactl list sinks | grep '^[[:space:]]Volume:' | \
    head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')
MUTED=$(pactl list sinks | awk '/Mute/ { print $2 }')

ICON=$VOLUME_MUTE

if [ "$MUTED" = "yes" ]
then
    ICON="$VOLUME_MUTE"
    SOUND_LEVEL="X"
else
    if [ "$SOUND_LEVEL" -lt 34 ]
    then
        ICON="$VOLUME_LOW"
    elif [ "$SOUND_LEVEL" -lt 67 ]
    then
        ICON="$VOLUME_MID"
    else
        ICON="$VOLUME_HIGH"
    fi
fi

if [ "$MUTED" = "yes" ]
then
    echo "<fc=#e06c75><fn=1>$ICON</fn> $SOUND_LEVEL</fc>" | tee /tmp/.volume-pipe
else
    echo "<fc=#61afef><fn=1>$ICON</fn> $SOUND_LEVEL%</fc>" | tee /tmp/.volume-pipe
fi
