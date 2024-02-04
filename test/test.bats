@test "can run binary2video" {
    ./binary2video LICENSE LICENSE.mp4
}

@test "can run video2binary" {
    ./video2binary LICENSE.mp4 LICENSE_restored
}

@test "convert and restore file LICENSE" {
    echo "********** convert **********"
    ./binary2video LICENSE LICENSE.mp4
    echo "********** restore **********"
    ./video2binary LICENSE.mp4 LICENSE_restored
    echo "********** compare **********"
    cmp --silent LICENSE LICENSE_restored
}
