void setup(){
  int scaleWidth = 50;
  int scaleHeight = 40;
  
  color scaleColor1 = color(90, 0, 0);
  color scaleColor2 = color(90, 0, 90);
  
  int scaleGradientResolution = 20; //Amount of rectangles that will make up half the gradient on the scales
  color scaleGradientMaxDarkness = color(15, 15, 15);
  
  background(0, 0, 0);
  size(1000, 800);
  
  drawBackground(scaleWidth, scaleHeight, scaleColor1, scaleColor2, scaleGradientResolution, scaleGradientMaxDarkness);
}

//Scale shape
void createScale(int x, int y, int scaleWidth, int scaleHeight, color scaleColor, int scaleGradientResolution, color scaleGradientMaxDarkness){
  
  color gradientColorBrighter; //Color transitions from black to the color
  color gradientColorDarker; //Color transitions from the color to black
  
  //Create a gradient with black on the edges and the color in the middle
  for (int i = 0; i <= scaleGradientResolution; i++){
    gradientColorBrighter = lerpColor(scaleGradientMaxDarkness, scaleColor, (float)i/(scaleGradientResolution - 1)); //Dark to light gradient
    gradientColorDarker = lerpColor(scaleColor, scaleGradientMaxDarkness, (float)i/(scaleGradientResolution - 1)); //Light to dark gradient
    
    noStroke();
    
    fill(gradientColorBrighter);
    rect(x + (i*scaleWidth)/(2*scaleGradientResolution), y, scaleWidth/(2*scaleGradientResolution) + 1, scaleHeight);
    
    fill(gradientColorDarker);
    rect(x + (i*scaleWidth)/(2*scaleGradientResolution) + scaleWidth/2, y, scaleWidth/(2*scaleGradientResolution) + 1, scaleHeight);
  }
  
  //Outline the top portion
  stroke(0);
  fill(scaleColor);
  
  line(x, y, x, y + scaleHeight);
  line(x + scaleWidth, y, x + scaleWidth, y + scaleHeight);
  
  //Bottom portion
  ellipse(x + scaleWidth/2, y + scaleHeight, scaleWidth, scaleHeight/2);
}

void drawBackground(int scaleWidth, int scaleHeight, color scaleColor1, color scaleColor2, int scaleGradientResolution, color scaleGradientMaxDarkness){
  int scaleColorState = 0;
  
  //y values are iterated from bottom to top, allowing for scales higher up to be drawn on top of lower scales
  for (int y = height - scaleHeight; y >= 0; y -= scaleHeight){
    
    //Increment the scale's x coordinate. Draws scales left to right
    for (int x = 0; x <= width; x += scaleWidth){
      //Alternate colors
      //(scaleWidth/2)*((y/scaleHeight)%2) offsets the x value by 1/2 the width of the scale on every odd row
      if (scaleColorState == 0){
        createScale(x - (scaleWidth/2)*((y/scaleHeight)%2), y, scaleWidth, scaleHeight, scaleColor1, scaleGradientResolution, scaleGradientMaxDarkness);
      } else{
        createScale(x - (scaleWidth/2)*((y/scaleHeight)%2), y, scaleWidth, scaleHeight, scaleColor2, scaleGradientResolution, scaleGradientMaxDarkness);
      }
      
      scaleColorState ++;
      scaleColorState = scaleColorState%2;
    }
    
    scaleColorState = (scaleColorState + 1)%2; //Offset the color state on the new row to prevent vertical lines of alternating colors
  }
}
