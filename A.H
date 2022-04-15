///////////////////////////////////////
//
// a.h
//
// Attribute Structure
//
///////////////////////////////////////

//////////////////////////
//
// attribute define values
//

#define BLACK   0
#define BLUE    1
#define GREEN   2
#define CYAN    3
#define RED     4
#define MAGENTA 5
#define BROWN   6
#define WHITE   7
#define NORMAL  7
#define REVERSE 112

#define ON_INTENSITY  8
#define OFF_INTENSITY 0
#define ON_BLINK      128
#define OFF_BLINK     0

///////////////////////////
// attribute structure

typedef struct {
   unsigned char fore_ground;  // foreground color
   unsigned char back_ground;  // background color
   unsigned char blink;        // blink on/off
   unsigned char intensity;    // intensity on/ff
   unsigned char Original;     // original attribute
   unsigned char Inverse;      // inverse attibute
   unsigned char Intense;      // intense attribute
   unsigned char Blink;        // original & blink
   unsigned char InverseBlink; // inverse & blink
   unsigned char IntenseBlink; // intense & blink
   } Attribute;


