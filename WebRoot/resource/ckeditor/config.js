/*
Copyright (c) 2003-2012, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
    // Define changes to default configuration here. For example:
    // config.language = 'fr';
    // config.uiColor = '#AADC6E';
    config.language = 'zh-cn'; 
    config.skin = 'office2003';
   
    config.toolbar = 'Cms';
    config.toolbar='Full';
    config.toolbar = 'MyToolbar';
    config.toolbar_MyToolbar=
    [
    ['Preview']
    ];
    config.toolbar_Cms = [
        
        { name: 'document', items : ['Source','Maximize','Preview','Templates']},
        { name: 'clipboard', items : ['PasteText','PasteFromWord','-','Undo','Redo']},
        { name: 'editing', items : [ 'Find','Replace','SelectAll']},
        { name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat']},
        { name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent', 
                                       '-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock',] },
        { name: 'links', items : [ 'Link','Unlink','Anchor' ] },
        { name: 'insert', items : [ 'Image','Flash','Table','SpecialChar'] },
        { name: 'styles', items : [ 'Styles','Format','Font','FontSize' ] },
        { name: 'colors', items : [ 'TextColor','BGColor' ] },
        { name: 'tools', items : [ 'Page' ] }
    ];
    config.toolbar_Full = [
        { name: 'document', items : [ 'Source','-','NewPage','DocProps','Preview','Print','-','Templates' ] },
        { name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
        { name: 'editing', items : [ 'Find','Replace','-','SelectAll','-','SpellChecker', 'Scayt' ] },
        { name: 'forms', items : [ 'Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 
            'HiddenField' ] },
        '/',
        { name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
        { name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','CreateDiv',
        '-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] },
        { name: 'links', items : [ 'Link','Unlink','Anchor' ] },
        { name: 'insert', items : [ 'Image','Flash','flv','Table','HorizontalRule','Smiley','SpecialChar','PageBreak','Iframe' ] },
        '/',
        { name: 'styles', items : [ 'Styles','Format','Font','FontSize' ] },
        { name: 'colors', items : [ 'TextColor','BGColor' ] },
        { name: 'tools', items : [ 'Maximize', 'ShowBlocks','-','About' ] }
    ];  
    config.toolbar_Basic = [
        ['Bold', 'Italic', '-', 'NumberedList', 'BulletedList', '-', 'Link', 'Unlink','-','About']
    ];
    config.extraPlugins = 'page';
	config.extraPlugins='flv';
    config.filebrowserBrowseUrl = '../../../resource/ckfinder/ckfinder.html',
    config.filebrowserImageBrowseUrl = '../../../resource/ckfinder/ckfinder.html?type=Images',
    config.filebrowserFlashBrowseUrl = '../../../resource/ckfinder/ckfinder.html?type=Flash',
    config.filebrowserUploadUrl = '../../../resource/ckfinder/core/connector/java/connector.java?command=QuickUpload&type=Files',
    config.filebrowserImageUploadUrl = '../../../resource/ckfinder/core/connector/java/connector.java?command=QuickUpload&type=Images',
    config.filebrowserFlashUploadUrl = '../../../resource/ckfinder/core/connector/java/connector.java?command=QuickUpload&type=Flash',
    config.filebrowserWindowWidth = '1000',
    config.filebrowserWindowHeight = '700'
  //  config.language =  "zh-cn" ;    
    config.toolbarCanCollapse = true;
};
//config.font_names = '宋体/宋体;黑体/黑体;仿宋/仿宋_GB2312;楷体/楷体_GB2312;隶书/隶书;幼圆/幼圆;微软雅黑/微软雅黑;' + config.font_names;
CKEDITOR.on('instanceReady', function(ev){
    ev.editor.dataProcessor.writer.setRules('p', {
        indent : true,
        breakBeforeOpen : true,
        breakAfterOpen : false,
        breakBeforeClose : false,
        breakAfterClose : true
    });
    ev.editor.dataProcessor.writer.setRules('div', {
        indent : true,
        breakBeforeOpen : true,
        breakAfterOpen : false,
        breakBeforeClose : false,
        breakAfterClose : true
    });
});