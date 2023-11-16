


$(document).ready(function () {

    $('#board_content').summernote({
        height: 500,
        lang: "ko-KR",
        // data: json,
        callbacks: {
            onImageUpload: function (files1) {
                uploadImages(files1);
            },
            onMediaDelete: function (target) {
                handleImageDelete(target[0].src);
            }
        }
    });

    $(".attachment").click(function () {

        let fileNo = $(this).attr("id").replace("file_","");
        //.replace("file_", "");
        console.log("id : "+fileNo);
        let confirmation = confirm("파일을 삭제하시겠습니까?");

        if (confirmation) {
            //fileId 전송
            $.ajax({
                type: "POST",
                url: "/board/deleteFile",
                data: { fileNo: fileNo },
                success: function (response) {
                    console.log("ajax data : "+fileNo);
                    console.log(response);

                    $("#file_" + fileNo).remove();
                },
                error: function (error) {
                    console.log("ajax data : "+fileNo);
                    console.error("Error:", error);
                }
            });
        }
    });

    function uploadImages(files1) {
        let formData = new FormData();
        for (let i = 0; i < files1.length; i++) {
            formData.append("files1", files1[i]);
        }

        $.ajax({
            url: "/board/uploadImages",
            type: "POST",
            data: formData,
            contentType: false,
            processData: false,
            success: function (data) {
                let imageUrls = data;
                for (let i = 0; i < imageUrls.length; i++) {
                    $('#board_content').summernote('insertImage', imageUrls[i]);
                }
            },
            error: function () {
                console.log('upload image fail ... error...');
            }
        });
    }

    //   function deleteFile(fileNo) {
    //     let confirmation = confirm("파일을 삭제하시겠습니까?");
    //     if (confirmation) {
    //         $.ajax({
    //             type: "POST",
    //             url: "/board/deleteFile",
    //             data: { fileNo: fileNo },
    //             success: function (response) {
    //                 console.log(response);
    //                 $("#file_" + fileNo).remove();
    //             },
    //             error: function (error) {
    //                 console.error("Error:", error);
    //             }
    //         });
    //     }
    // }

    
});

