
/** Original equations from Robert Penner */
package fr.minuit4.motion.easing 
{
	public class Circ 
	{
		
		/**
		* @param t		Specifies the current time, between 0 and duration inclusive. 
		* @param b		Specifies the initial value of the animation property. 
		* @param c		Specifies the total change in the animation property. 
		* @param d		Specifies the duration of the motion. 
		* @return		The value of the interpolated property at the specified time.
		*/
		public static function easeIn (t:Number, b:Number, c:Number, d:Number):Number 
		{
			return -c * (Math.sqrt(1 - (t/=d)*t) - 1) + b;
		}
		
		/**
		* @param t		Specifies the current time, between 0 and duration inclusive. 
		* @param b		Specifies the initial value of the animation property. 
		* @param c		Specifies the total change in the animation property. 
		* @param d		Specifies the duration of the motion. 
		* @return		The value of the interpolated property at the specified time.
		*/
		public static function easeOut (t:Number, b:Number, c:Number, d:Number):Number 
		{
			return c * Math.sqrt(1 - (t=t/d-1)*t) + b;
		}
		
		/**
		* @param t		Specifies the current time, between 0 and duration inclusive. 
		* @param b		Specifies the initial value of the animation property. 
		* @param c		Specifies the total change in the animation property. 
		* @param d		Specifies the duration of the motion. 
		* @return		The value of the interpolated property at the specified time.
		*/
		public static function easeInOut (t:Number, b:Number, c:Number, d:Number):Number
		{
			if ((t/=d/2) < 1) return -c/2 * (Math.sqrt(1 - t*t) - 1) + b;
			return c/2 * (Math.sqrt(1 - (t-=2)*t) + 1) + b;
		}
		
	}
	
}