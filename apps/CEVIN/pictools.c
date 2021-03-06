/*
 * CEVIN_head - process remote display commands from CEVIN_iod over TCP
 *
 * Copyright	  2011 D. D. Rimron.
 *
 * pictools.c - tools for handling images on the DF3120
 *
 * This code draws from many places:
 *   http://www.linuxhowtos.org/C_C++/socket.htm
 *   http://zarb.org/~gc/html/libpng.html
 *
 */
#include <unistd.h>
#include <stdio.h>

unsigned int mkPixel(int red, int green, int blue) {
   return ((red>>3)<<11)+((green>>2)<<5)+(blue>>3);
}

/* alpha blend routine */
int mkBlend(char bg, char fg, int alpha)
{
   /* If source pixel is transparent, just return the background */
   if (alpha == 0) 
      return bg;

   float floatalpha;
   floatalpha = alpha/255.0;

   /* alpha blending the source and background colors */
   return (fg * floatalpha + (bg * (1 - floatalpha)));
}
