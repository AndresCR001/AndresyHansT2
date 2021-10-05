class Button{
  
  PVector Pos = new PVector(0,0);
  float Width= 0;
  float Height= 0;
  color Colour;
  String Text;
  Boolean Pressed = false;
  Boolean Clicked = false;
  
  //Contructor del boton
  Button(int x, int y, int w, int h, String t , int r, int g, int b){
  
    Pos.x=x;
    Pos.y=y;
    Width = w;
    Height = h;
    Colour = color(r,g,b);
    Text = t;
  }
  
  void update(){//deberia usarse en void draw() para funcionar 
    
    if(mousePressed==true && mouseButton==LEFT && Pressed== false){
      
      Pressed = true;
      
      if(mouseX>= Pos.x && mouseX<=Pos.x + Width && mouseY >= Pos.y && mouseY <= Pos.y+Height) {
        Clicked=true;
      }
      
    }else{
      Clicked = false;
    }
    if(mousePressed!=true){Pressed=false;}
  }
  
  void render(){ //deberia usarse en void draw() para renderizar el boton en la pantalla 
    
    fill(Colour);
    rect(Pos.x,Pos.y,Width,Height);
    
    fill(0);
    textAlign(CENTER,CENTER);
    text(Text,Pos.x+(Width/2),Pos.y+(Height/2));
    
  }
  
  boolean isClicked(){ // se usa para saber el estado del botón
    return Clicked;
  }
  
}
