<!DOCTYPE html>
<html dir="{$language_direction}">
<head>
{literal}
<style media="print">
.main-table {
    background-color: #ffffff !important;
}
.main-table td {
    vertical-align: top;
}
</style>
<style media="screen,print">
body,p,div,td {
    color: #000000;
    font: 12px Arial;
}
body {
    padding: 0;
    margin: 0;
}
a, a:link, a:visited, a:hover, a:active {
    color: #000000;
    text-decoration: underline;
}
a:hover {
    text-decoration: none;
}
</style>
{/literal}
</head>

<body>
{include file="common/scripts.tpl"}

{include file="orders/invoice.tpl"}

</body>
</html>
