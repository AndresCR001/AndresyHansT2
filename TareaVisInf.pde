import ddf.minim.*;

Minim minim;
AudioPlayer player;

//parametros para escalas de color
float specLow = 0.1; // 10%
float specMid = 0.5;  // 50%
float specHi = 1.0;   // 100%
//altura de visualizacion
int vizHeight = 440;

Button resetbutton;
Button playbutton;
Button pausebutton;
Button previousbutton;
Button nextbutton;

PImage songImg;

//objeto de BD
Data data;

int nSong = 1;
int totalSongs;

void setup()
{
  //configuracion ventana de render
  size(1024, 700, P3D);
  frameRate(30);
  
  
  minim = new Minim(this);
  
  int buttonXOffset = 250;
  
  resetbutton = new Button((width-buttonXOffset)-200,500,100,50,"Reset",0,200,200);
  playbutton = new Button((width-buttonXOffset)-50,500,100,50,"Play",0,150,0);
  pausebutton = new Button((width-buttonXOffset)+100,500,100,50,"Pause",200,0,0);
  previousbutton = new Button((width-buttonXOffset)-125,570,100,50,"Previous",150,150,150);
  nextbutton = new Button((width-buttonXOffset)+25,570,100,50,"Next",150,150,150);
  
  data = new Data();
  totalSongs = data.getTotalSongs();
  if (nSong == 0){nSong++;}
  data.setRowNumber(nSong);
  
  //carga primera canción
  player = minim.loadFile(data.getSongFileName());
  songImg = loadImage(data.getSongImageFileName());
}

void draw()
{
  
  background(0);
  
  //dibujado tabla de control
  
  //tabla control
  stroke(220);
  fill(220);
  rect(0, vizHeight+10, width, height-vizHeight);
  //pestaña decorativa
  stroke(190);
  fill(190);
  rect(0, vizHeight, width, 10, 10, 10, 0, 0);
  
  //dibujado imagen
  image(songImg, 0, vizHeight+10, height-vizHeight, height-vizHeight);
  
  //dibujado cajas labels
  stroke(190);
  fill(0);
  rect(height-vizHeight + 10, vizHeight+30, 200, 30);
  rect(height-vizHeight + 10, vizHeight+70, 200, 30);
  
  //dibujado texto labels
  textAlign(LEFT,CENTER);
  fill(255);
  text("Canción: "+data.getSongName(), height-vizHeight + 15, vizHeight+30+15);
  text("Artista: "+data.getSongArtist(), height-vizHeight + 15, vizHeight+70+15);
  
  //dibujado visualizacion
  //ciclo dibuja 1024 lineas del buffer de audio
  for(int i = 0; i < player.bufferSize() - 1; i++)
  {
    float x1 = map( i, 0, player.bufferSize(), 0, width );
    float leftVal = player.left.get(i);
    float rightVal = player.right.get(i);
    
    //seleccion de color según valor izquierdo
    if(abs(leftVal) < specLow){
      stroke(230, 230-(abs(leftVal)/specLow * 230), 230-(abs(leftVal)/specLow * 230));
    } else if(abs(leftVal) >= specLow && abs(leftVal) < specMid){
      stroke(230, 230 * (abs(leftVal)-specLow)/specMid-specLow, 0);
    } else if(abs(leftVal) >= specMid && abs(leftVal) < specHi){
      stroke(230 - (230 * (abs(leftVal)-specMid)/specHi-specMid), 230, 0);
    } 
    //dibujado de linea izquierdo
    line( x1, 120, x1, 120 + leftVal*100 +1);
    
    //seleccion de color según valor derecho
    if(abs(rightVal) < specLow){
      stroke(230, 230-(abs(rightVal)/specLow * 230), 230-(abs(rightVal)/specLow * 230));
    } else if(abs(rightVal) >= specLow && abs(rightVal) < specMid){
      stroke(230, 230 * (abs(rightVal)-specLow)/specMid-specLow, 0);
    } else if(abs(rightVal) >= specMid && abs(rightVal) < specHi){
      stroke(230 - (230 * (abs(rightVal)-specMid)/specHi-specMid), 230, 0);
    }
    //dibujado de linea derecha
    line( x1, 340, x1, 340 + rightVal*100 +1);
  }
  
  //dibujado linea de playback
  float posx = map(player.position(), 0, player.length(), 0, width);
  stroke(0,200,0);
  line(posx, 0, posx, vizHeight);
  
  //dibujado icono de playback
  if ( player.isPlaying() )
  {
    fill(0,200,0);
    triangle(posx-8, (vizHeight/2)-8, posx+10, vizHeight/2, posx-8, (vizHeight/2)+10);
  }
  else
  {
    stroke(200,0,0);
    fill(200,0,0);
    rect(posx + 4, (vizHeight/2)-8, 8, 16);
    rect(posx - 12, (vizHeight/2)-8, 8, 16);
  }
  
  noStroke();
  
  //procesamiento de botones
  if(resetbutton.isClicked()){
    print("Reset");
    player.play(0);
  }
  if(playbutton.isClicked()){
    print("Play");
    player.play();
  }
  if(pausebutton.isClicked()){
    print("Pause");
    player.pause();
  }
  if(previousbutton.isClicked()){
    print("Previous song");
    prevSong();
  }
  if(nextbutton.isClicked()){
    print("NextSong");
    nextSong();
  }
  
  //actualizacion y render de botones
  resetbutton.update();
  resetbutton.render();
    
  playbutton.update();
  playbutton.render();
    
  pausebutton.update();
  pausebutton.render();
    
  previousbutton.update();
  previousbutton.render();
    
  nextbutton.update();
  nextbutton.render();
}

//func siguiente cancion
void nextSong(){
  player.close();
  nSong++;
  if(nSong > totalSongs){
    nSong = 1;
  }
  data.setRowNumber(nSong);
  player = minim.loadFile(data.getSongFileName());
  songImg = loadImage(data.getSongImageFileName());
}

//func anterior cancion
void prevSong(){
  player.close();
  nSong--;
  if(nSong < 1){
    nSong = totalSongs;
  }
  data.setRowNumber(nSong);
  player = minim.loadFile(data.getSongFileName());
  songImg = loadImage(data.getSongImageFileName());
}
