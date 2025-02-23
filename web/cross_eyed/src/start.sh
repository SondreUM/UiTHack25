export ROCKET_PORT=9000
./cross-eyed-local &

export ROCKET_PORT=8000
./cross-eyed &

wait

exit $?
