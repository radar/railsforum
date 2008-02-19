class CreateStyles < ActiveRecord::Migration
  def self.up
    create_table :styles do |t|
    t.column :name, :string
    t.column :css, :text
    t.column :is_default, :boolean, :default => false
    end
    
    add_column :users, :style_id, :integer, :efault => 1
    Style.create(:name => "blue", :css => "
body, textarea, table {
font-family:\"Trebuchet MS\",sans;
font-size:11pt;
}
a {
color:#48769D;
text-decoration:none;
}
h2, h3 {
margin:0px;
}
img {
border:0px none;
}
.content {
text-align:left;
width:90%;
}
.title-bar {
background:transparent url(/images/blue/bg.jpg) repeat scroll 0%;
border:1px solid #84AFD3;
font-size:20pt;
font-weight:bold;
height:42px;
padding-right:0px;
padding-top:0px;
text-align:right;
}
.flash {
background:#A4D5FF none repeat scroll 0%;
border:2px solid #84AFD3;
font-size:16pt;
font-weight:bold;
margin-top:2px;
padding:5px;
text-align:center;
}
.menu-bar {
float:left;
margin:5px;
}
.time-now {
float:right;
}
.icon {
width:80px;
}
.forums h1 {
font-size:16pt;
margin:0px;
padding:0px;
}
.forums, .forum, .info-box, .list-table {
border:1px solid #84AFD3;
}
.forums td, .forum td, .list-table td {
padding:5px;
}
.forums thead, .forum thead, .info-box thead, .posts thead, .action-box thead, .list-table thead {
background:#E5F3FF url(/images/blue/thead-bg.jpg) repeat-x scroll 0%;
font-weight:bold;
}
.forums tbody td, .list-table tbody td {
background:white;
}
.forum tfoot {
background:#C1E2FE none repeat scroll 0%;
}
.forum tfoot input {
background:#DBEEFD none repeat scroll 0%;
border:1px solid #48769D;
font-size:10pt;
letter-spacing:-1px;
margin:2px;
}
.forum {
margin-top:2px;
}
.posts, .action-box {
border:1px solid #84AFD3;
margin:2px;
}
.posts tbody, .action-box tbody {
background:#E1F1FF none repeat scroll 0%;
}
.posts tfoot, .action-box tfoot {
background:#E1F1FF url(/images/blue/tfoot-bg.jpg) repeat-x scroll 0%;
}
.posts h1 {
margin:0px;
padding:0px;
}
.edit-note {
color:#4F93CF;
font-size:9pt;
}
.quote {
background:#A4D5FF none repeat scroll 0%;
border:1px solid #84AFD3;
padding:5px;
text-align:left;
width:90%;
}
.term {
font-family:monospace, \"Courier New\";
font-weight:bold;
}
.ban-box {
background:#DE0000 none repeat scroll 0%;
border:10px solid red;
color:white;
font-size:48pt;
}
.ban-box h1 {
margin:0px;
padding:0px;
}
.fieldWithErrors input, .fieldWithErrors textarea {
border-left:3px solid #cd0000;
}
.errorExplanation {
font-size:10pt;
}
.info-box td .right {
float:right;
text-align:right;
}
/* inspired by http://css.maxdesign.com.au/listamatic/horizontal02.htm */
ul#admin-navlist {
margin:2px;
margin-left:0px;
padding:0px;
white-space: nowrap;
}

#admin-navlist li {
display: inline;
list-style-type: none;
}

#admin-navlist a { 
padding: 3px 10px; 
}

#admin-navlist a:link, #admin-navlist a:visited {
color:#336699;
background-color: #b8dcfc;
text-decoration: none;
border:1px solid #336699;
border-bottom:0px;
}
#admin-navlist a.selected {
border:2px solid #336699;
border-bottom:0px;
font-weight:bold;
}
#admin-page {
background:#b8dcfc;
padding:5px;
border:1px solid #336699;
}
.list-table td {
text-align:center; 
}", :is_default => true)
  end

  def self.down
    drop_table :styles
  end
end
