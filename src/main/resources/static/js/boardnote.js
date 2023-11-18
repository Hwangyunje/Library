

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

        $("#board_content").summernote({
            height: 500,
            callbacks: {
                onImageUpload: function(files){
                    alert('이미지 업로드');
                    //이미지를 server로 전송하고
                    //응답으로 이미지경로와 파일명을 받아서
                    //img 태그를 만들어서 src속성에 이미지 경로를 넣는것
                    let formData = new FormData(); // <form></form>
                    formData.append("files",files[0]); // <input type="file" name="files"> 를 폼안에 추가
        
                    $.ajax({
                        type:"post",
                        url:'./setContentsImg',
                        data:formData,
                        enctype: 'multipart/form-data',
                        cache: false,
                        processData: false,
                        contentType: false,
                        success:function(result){
                            console.log(result)
                            $("#board_content").summernote('insertImage', result.trim());
                        },
                        error:function(){
                            console.log('error');
                        }	
                    });
        
                },
                onMediaDelete:function(files){
                    let path = $(files[0]).attr("src");
                    console.log("del");
                    $.ajax({
                        type:'post',
                        url:'./setContentsImgDelete',
                        data:{
                            path:path
                        },
                        success:function(result){
                            console.log(result);
                        },
                        error:function(){
                            console.log('error');
                        }
                    })
                }
        
            }
        })
    

    
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
    
    
        $(document).on('click', function (event) {
            if (!$(event.target).closest('#memberList, #tags').length) {
                $('#memberList').empty().hide();
            }
        });
        function displayMemberList(members, query) {
            var memberList = $('#memberList');
            memberList.empty();
            for (var i = 0; i < members.length; i++) {
                var memberName = members[i].empName;
                if (memberName.toLowerCase().includes(query.substring(1).toLowerCase())) {
                    var listItem = $('<li>').text(memberName);
                    memberList.append(listItem);
                }
            }
            if (memberList.children().length > 0) {
                memberList.show();
            } else {
                memberList.hide();
            }
        }
    });
    

