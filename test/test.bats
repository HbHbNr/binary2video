teardown() {
    rm -f test/LICENSE.{mp4,webm,avi} test/LICENSE_restored
    rm -f test/9.{mp4,webm,avi} test/9.txt_restored
    rm -f test/42.{mp4,webm,avi} test/42.txt_restored
    rm -f test/16777216.{mp4,webm,avi} test/16777216.txt_restored
    rm -f test/'filename with spaces'.{mp4,webm,avi} test/'filename with spaces'.txt_restored
    rm -f test/'filename with (brackets)'.{mp4,webm,avi} test/'filename with (brackets)'.txt_restored
}

@test "can run binary2video" {
    run ./binary2video
    [ "$status" -eq 1 ]
    [[ "${lines[0]}" == "Usage:"* ]]
}

@test "can run binary2video --help" {
    run ./binary2video --help
    [ "$status" -eq 0 ]
    [[ "${lines[0]}" == "Usage:"* ]]
}

@test "can run video2binary" {
    run ./video2binary
    [ "$status" -eq 1 ]
    [[ "${lines[0]}" == "Usage:"* ]]
}

@test "can run video2binary --help" {
    run ./video2binary --help
    [ "$status" -eq 0 ]
    [[ "${lines[0]}" == "Usage:"* ]]
}

@test "convert to MP4 and restore file LICENSE" {
    echo "********** convert **********"
    ./binary2video LICENSE test/LICENSE.mp4
    echo "********** restore **********"
    ./video2binary test/LICENSE.mp4 test/LICENSE_restored
    echo "********** compare **********"
    cmp --silent LICENSE test/LICENSE_restored
}

@test "convert To WebM and restore file test/9.txt" {
    echo "********** convert **********"
    ./binary2video test/9.txt test/9.webm
    echo "********** restore **********"
    ./video2binary test/9.webm test/9.txt_restored
    echo "********** compare **********"
    cmp --silent test/9.txt test/9.txt_restored
}

@test "convert to AVI and restore file test/42.txt" {
    echo "********** convert **********"
    ./binary2video test/42.txt test/42.avi
    echo "********** restore **********"
    ./video2binary test/42.avi test/42.txt_restored
    echo "********** compare **********"
    cmp --silent test/42.txt test/42.txt_restored
}

@test "convert to MP4 and restore file test/16777216.txt" {
    echo "********** convert **********"
    ./binary2video test/16777216.txt test/16777216.mp4
    echo "********** restore **********"
    ./video2binary test/16777216.mp4 test/16777216.txt_restored
    echo "********** compare **********"
    cmp --silent test/16777216.txt test/16777216.txt_restored
}

@test "convert to MP4 and restore file 'test/filename with spaces.txt'" {
    echo "********** convert **********"
    ./binary2video 'test/filename with spaces.txt' 'test/filename with spaces.mp4'
    echo "********** restore **********"
    ./video2binary 'test/filename with spaces.mp4' 'test/filename with spaces.txt_restored'
    echo "********** compare **********"
    cmp --silent 'test/filename with spaces.txt' 'test/filename with spaces.txt_restored'
}

@test "convert to MP4 and restore file 'test/filename with (brackets).txt'" {
    echo "********** convert **********"
    ./binary2video 'test/filename with (brackets).txt' 'test/filename with (brackets).mp4'
    echo "********** restore **********"
    ./video2binary 'test/filename with (brackets).mp4' 'test/filename with (brackets).txt_restored'
    echo "********** compare **********"
    cmp --silent 'test/filename with (brackets).txt' 'test/filename with (brackets).txt_restored'
}
