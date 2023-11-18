$(document).ready(function () {

    let likecheck = $('#likediv').data('like');

    console.log("check like : " + likecheck);
    
    if (likecheck == 'Y') {

        $('#likeButton').hide();
        $('#unlikeButton').show();

    } else {

        $('#unlikeButton').hide();
        $('#likeButton').show();

    }


    let view = $('#view').data('view');

    if (view == 'A') {
        $('#logined').show();
    } else {
        $("#logined").css('visibility', 'visible');
        $('#logined').hide();
    }

});
function likeAnnouncement(board_no) {
    $.ajax({
        type: "POST",
        url: "/board/likeAnnouncement/" + board_no,
        success: function (response) {
            if (response === "Liked") {
                // 좋아요 성공 시, 버튼 스타일 변경 및 좋아요 수 업데이트
                $("#likeButton").hide();
                $("#unlikeButton").show();
                var likeCount = parseInt($("#likeCount").text()) + 1;
                $("#likeCount").text(likeCount + " 명이 이 글을 좋아합니다.");
            }
        },
        error: function (xhr, textStatus, errorThrown) {
            if (xhr.status === 400) {
                alert("이미 좋아요를 누르셨습니다.");
            }
        }
    });
}

function unlikeAnnouncement(board_no) {
    
    $.ajax({
        type: "POST",
        url: "/board/unlikeAnnouncement/" + board_no,
        success: function (response) {
            if (response === "Unliked") {
                // 좋아요 취소 시, 버튼 스타일 변경 및 좋아요 수 업데이트
                $("#likeButton").show();
                $("#unlikeButton").hide();
                var likeCount = parseInt($("#likeCount").text()) - 1;
                $("#likeCount").text(likeCount + " 명이 이 글을 좋아합니다.");
            }
        },
        error: function (xhr, textStatus, errorThrown) {
            if (xhr.status === 400) {
                alert("아직 좋아요를 누르지 않으셨습니다.");
            }
        }
    });
}

function updateBoard(board_no) {
    let result = confirm("수정 하시겠습니까?");

    if (result === true) {

        $.ajax({
            type: "GET",
            url: "/board/updateBoard",
            contentType: "application/json",
            data: {
                board_no: board_no
            },
            success: function (result) {
                console.log("success");
                // location.replace("/board/announcement");
            },
            error: function () {
                console.error("AJAX Error");
                console.log('updateBoard error');
            }
        });

    } else if (result === false) {
        console.log("삭제가 취소 되었습니다");
    }
}

$("#modifyBtn").on("click", function () {
    location.replace("./updateBoard?board_no=" + $(this).attr('data-val'));
    return false;
});

function deleteBoard(board_no) {

    let result = confirm("삭제 하시겠습니까?");

    if (result === true) {

        $.ajax({
            type: "POST",
            url: "/board/deleteBoard",
            contentType: "application/json",
            data: JSON.stringify({
                board_no: board_no
            }),
            success: function (result) {
                console.log(result);
                alert("삭제 되었습니다");
                location.href = "/board/announcement";
            },
            error: function () {
                console.log('deleteBoard error');
            }
        });

    } else if (result === false) {
        console.log("삭제가 취소 되었습니다");
    }
}


$('#goList').on('click', function () {
    $(location).attr("href", "./announcement");
});

// $('#modifyBtn').on('click',function(){
//     let result = confirm("삭제하시겠습니까?");

//     if (result === true) {
//         $.ajax({
//             type: "POST",
//             url: "/board/likeAnnouncement/" + board_no,
//         })
//         alert("삭제 되었습니다");
//     }
//     else if (result === false) {

//     }
// });
