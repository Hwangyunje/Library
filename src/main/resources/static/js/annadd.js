let idx = 1;

$(document).ready(function() {
    $('#add_btn').on('click', function(e) {
        e.preventDefault(); 
        
        let title = $('#board_title').val();
        let content = $('#board_content').val();

        if (title.trim() === '' || content.trim() === '') {
            alert('빈 공간이 있습니다');
        } else {
            
            $('#announcementForm').submit(); 
        }
    });

    $("#fileList").on("click", ".df", function() {
        $(this).parent().remove();
    });

    $("#fileAdd").on('click', function() {
        if (idx < 6) {
            let r = '<div class="a mb-3 w-50" id="file ' + idx + '">';
            r = r.concat('<input type="file" class="form-control" id="pic" name="files1" </div>');
            r = r.concat('<div class="a df mt-2 mx-2" data-id="file" ' + idx + '>x</div>')
            $("#fileList").append(r);
            idx++;
        } else {
            alert('최대 첨부파일 수는 5개 입니다.');
        }
    });

    $('#add_cancel').on('click', function() {
        history.back();
    });
});
