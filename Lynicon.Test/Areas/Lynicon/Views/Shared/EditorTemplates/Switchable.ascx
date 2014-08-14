﻿<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Lynicon.Models.Switchable>" %>
<%@ Import Namespace="Lynicon.Models" %>
<%@ Import Namespace="Lynicon.Utility" %>
<%  int useDepth = ViewData.TemplateInfo.TemplateDepth + ((ViewData["addDepth"] as int?) ?? 0) - 1;
    var props = ViewData.ModelMetadata.Properties.Where(pm => pm.PropertyName != "SelectedProperty"); %>
    <div class='object level-<%= useDepth %>'>
    <% foreach (var prop in props) { %>
        <%= Html.RadioButtonFor(m => m.SelectedProperty, prop.PropertyName, new { @class = "lyn-switchable-radio" }) %>
        <span><%= prop.PropertyName %></span>
    <% } %>
    <% foreach (var prop in props) { %>
        <div class="editor-unit level-<%= useDepth %> prop-<%= prop.PropertyName %>" <%= prop.PropertyName == Model.SelectedProperty ? "" : "style='display:none'" %>>
            <div class="editor-field indent-<%= useDepth %>"><%= Html.Editor(prop.PropertyName) %></div>
        </div>
    <% } %>
    </div>
<%= Html.RegisterScript("switchable-script", @"javascript:
$(document).ready(function () {
    $('body').on('change', '.lyn-switchable-radio', function () {
        var $this = $(this);
        $this.siblings('.editor-unit').hide().filter('.prop-' + $this.val()).show();
    });
});", new List<string> { "jquery" }) %>
