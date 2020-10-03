<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.4" tiledversion="1.4.2" name="World" tilewidth="16" tileheight="16" tilecount="4" columns="0">
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0">
  <image width="16" height="16" source="../Dirt.png"/>
  <objectgroup draworder="index" id="4">
   <object id="3" name="Collision" x="0" y="0">
    <polygon points="0,0 16,0 16,16 0,16"/>
   </object>
  </objectgroup>
 </tile>
 <tile id="1">
  <image width="16" height="16" source="../GrassyDirt.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Collision" x="0" y="0">
    <polygon points="0,0 16,0 16,16 0,16"/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2">
  <image width="16" height="16" source="../GrassyDirtDiagonal.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Collision" x="0" y="16">
    <polygon points="0,0 16,-16 16,0"/>
   </object>
  </objectgroup>
 </tile>
 <tile id="3">
  <image width="16" height="16" source="../GrassyDirtParralel.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Collision" x="0" y="0">
    <polygon points="0,0 16,0 16,16 0,16"/>
   </object>
  </objectgroup>
 </tile>
</tileset>
