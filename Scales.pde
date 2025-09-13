int scaleWidth = 50;
int scaleHeight = 40;

color scaleColor1 = color(90, 0, 0);
color scaleColor2 = color(90, 0, 90);

PShape scale1;
PShape scale2;

int scaleGradientResolution = 20; //Amount of rectangles that will make up half the gradient on the scales
color scaleGradientMaxDarkness = color(15, 15, 15);

void setup(){
  background(0, 0, 0);
  size(1000, 800);  
  
  scale1 = createScale(scaleWidth, scaleHeight, scaleColor1, scaleGradientResolution, scaleGradientMaxDarkness);
  scale2 = createScale(scaleWidth, scaleHeight, scaleColor2, scaleGradientResolution, scaleGradientMaxDarkness);
  
  drawBackground();
}

//Scale shape
PShape createScale(int scaleWidth, int scaleHeight, color scaleColor, int scaleGradientResolution, color scaleGradientMaxDarkness){
  PShape scale = createShape(GROUP);
  
  color gradientColorBrighter; //Color transitions from black to the color
  color gradientColorDarker; //Color transitions from the color to black
  
  //Create a gradient with black on the edges and the color in the middle
  for (int i = 0; i <= scaleGradientResolution; i++){
    gradientColorBrighter = lerpColor(scaleGradientMaxDarkness, scaleColor, (float)i/(scaleGradientResolution - 1));
    gradientColorDarker = lerpColor(scaleColor, scaleGradientMaxDarkness, (float)i/(scaleGradientResolution - 1));
    
    PShape gradientRectLeft = createShape(RECT, (i*scaleWidth)/(2*scaleGradientResolution), 0, scaleWidth/(2*scaleGradientResolution) + 1, scaleHeight);
    gradientRectLeft.setFill(gradientColorBrighter);
    gradientRectLeft.setStroke(false);
    scale.addChild(gradientRectLeft);
    
    PShape gradientRectRight = createShape(RECT, (i*scaleWidth)/(2*scaleGradientResolution) + scaleWidth/2, 0, scaleWidth/(2*scaleGradientResolution) + 1, scaleHeight);
    gradientRectRight.setFill(gradientColorDarker);
    gradientRectRight.setStroke(false);
    scale.addChild(gradientRectRight);
  }
  
  //Outline the top portion
  PShape outline1 = createShape(LINE, 0, 0, 0, 0 + scaleHeight);
  scale.addChild(outline1);
  
  PShape outline2 = createShape(LINE, 0 + scaleWidth, 0, 0 + scaleWidth, 0 + scaleHeight);
  scale.addChild(outline2);
  
  //Bottom portion
  PShape bottomEllipse = createShape(ELLIPSE, 0 + scaleWidth/2, 0 + scaleHeight, scaleWidth, scaleHeight/2);
  bottomEllipse.setFill(scaleColor);
  scale.addChild(bottomEllipse);
  
  return scale;
}

void drawBackground(){
  int scaleColorState = 0;
  
  //y values are iterated from bottom to top, allowing for scales higher up to be drawn on top of lower scales
  for (int y = height - scaleHeight; y >= 0; y -= scaleHeight){
    
    //Increment the scale's x coordinate. Draws scales left to right
    for (int x = 0; x <= width; x += scaleWidth){
      //Alternate colors
      //(scaleWidth/2)*((y/scaleHeight)%2) offsets the x value by 1/2 the width of the scale on every odd row
      if (scaleColorState == 0){
        shape(scale1, x - (scaleWidth/2)*((y/scaleHeight)%2), y);
      } else{
        shape(scale2, x - (scaleWidth/2)*((y/scaleHeight)%2), y);
      }
      
      scaleColorState ++;
      scaleColorState = scaleColorState%2;
    }
    
    scaleColorState = (scaleColorState + 1)%2; //Offset the color state on the new row to prevent vertical lines of alternating colors
  }
}
