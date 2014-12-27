﻿<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<object>" %>
<%@ Import Namespace="Lynicon.Models" %>
<%@ Import Namespace="Lynicon.Utility" %>
<span class="text-display">@(Model == null || Model.ToString() == "" ? "---" : Model)</span>
<%= Html.TextBox("", ViewData.Model, new { @class = "text-box single-line password-with-encryption" + ViewData["classes"]})  %>
<div class="field-process-button encrypt-button">ENCRYPT</div>
<%=
Html.RegisterScript("passwordEncrypter", @"javascript:
$(document).ready(function () {
    $('.encrypt-button').click(function () {
        var $pw = $(this).parent().find('.password-with-encryption');
        $.post('/lynicon/ajax/encryptpassword', { pw: $pw.val() }, function (d) {
            $pw.val(d.encrypted);
        });
    });
});
", new List<string> { "jquery" })
%>



