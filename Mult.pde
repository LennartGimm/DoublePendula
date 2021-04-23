float l1;
float l2;
float m1;
float m2;
float g;
int i;
PGraphics canvas;
float r1;
float r2;
float farbe;

int size=150;


float[] x1 = new float[size];
float[] y1 = new float[size];
float[] x2 = new float[size];
float[] y2 = new float[size];
float[] v1 = new float[size];
float[] v2 = new float[size];
float[] a1 = new float[size];
float[] a2 = new float[size];
float[] w1 = new float[size];
float[] w2 = new float[size];
float[] p1 = new float[size];
float[] p2 = new float[size];



void setup(){
  fullScreen();
  //size(1000,500);
  background(200,200,255);
  m1 = 70;
  m2 = 20;
  l1 = 200;
  l2 = 400;

  r1=PI/random(10)+random(3);
  r2=PI/random(10)+random(3);
  
  for(i=0; i<size; i++){
    v1[i] = 0;
    v2[i] = 0;
    a1[i] = 0;
    a2[i] = 0;
    w1[i] = r1+random(-1,1)/10000;
    w2[i] = r2+random(-1,1)/10000;
  }
  
  g = 1;
  
  canvas = createGraphics(width,height);
}



void draw(){
  translate(width/2,height/4);
  background(50);
  fill(0);
  stroke(0);
  strokeWeight(2);
  
  for(i=0; i<size; i++){
    a1[i] = (-g*(2*m1+m2)*sin(w1[i])-m2*g*sin(w1[i]-2*w2[i])-2*sin(w1[i]-w2[i])*m2*(v2[i]*v2[i]*l2+v1[i]*v1[i]*l1*cos(w1[i]-w2[i])))/(l1*(2*m1+m2-m2*cos(2*w1[i]-2*w2[i])));
    a2[i] = (2*sin(w1[i]-w2[i])*(v1[i]*v1[i]*l1*(m1+m2)+g*(m1+m2)*cos(w1[i])+v2[i]*v2[i]*l2*m2*cos(w1[i]-w2[i])))/(l2*(2*m1+m2-m2*cos(2*w1[i]-2*w2[i])));
    
    v1[i]+=a1[i];
    v2[i]+=a2[i];
    
    w1[i]+=v1[i];
    w2[i]+=v2[i];
    
    p1[i]=x2[i];
    p2[i]=y2[i];
    
    x1[i]=l1*sin(w1[i]);
    y1[i]=l1*cos(w1[i]);
    x2[i]=l2*sin(w2[i])+x1[i];
    y2[i]=l2*cos(w2[i])+y1[i];
    
    v1[i]*=1.001;
    v2[i]*=1.001;
    
    
    if(frameCount>1){
      canvas.beginDraw();
      farbe=i*255/size;
      canvas.stroke(farbe);
      canvas.line(x2[i]+width/2,y2[i]+height/4,p1[i]+width/2,p2[i]+height/4);
      canvas.endDraw();
      imageMode(CORNER);
      image(canvas, -width/2 , -height/4 , width, height);
    }
  }
  
  for(i=0; i<size; i++){
    line(0,0,x1[i],y1[i]);
    line(x1[i],y1[i],x2[i],y2[i]);
    ellipse(x1[i],y1[i],m1,m1);
    ellipse(x2[i],y2[i],m2,m2);
  }
  
  saveFrame("150Pendula/frame######.png");
  if(frameCount == 1200){exit();}
} 
  
  
  
  
