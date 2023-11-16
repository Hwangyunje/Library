let idx=0;

$("#fileAdd").click(function(){

    let r = '<div class="a mb-3 w-50" id="file "'+idx+'>';

    r = r.concat('<input type="file" class="form-control" id="pic" name="files1" </div>');
   
    r= r.concat('<div class="a df mt-2 mx-2" data-id="file" '+ idx +'>x</div>')
    
    $("#fileList").append(r);
    idx++;
})

$("#fileList").on("click",".df", function(){
    
    $(this).parent().remove();
    
})



$(".delets").each(function(i,e){

    let num = this.getAttribute("data-delete-num");
    
    
    $(e).click(function(){  
        console.log(e);
        console.log(num);

        $.ajax({
            type:'GET',
            url: "./fileDelete",
            data:{
                file_no:num
            },
            success:function(result){
                if(result.trim()=='1'){

                    $("#"+num).remove();
                    $(e).remove();
                    
                }
            },
            error:function(){
                console.log("error");
            }
        })
    })
})

$("#summernote").summernote({
    height: 400,
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
                    $("#summernote").summernote('insertImage', result.trim());
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

