
/** Original equations from Robert Penner */
package fr.minuit4.motion.easing 
{
	
	public class Quad 
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
			return c*(t/=d)*t + b;
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
			return -c *(t/=d)*(t-2) + b;
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
			if ((t/=d/2) < 1) return c/2*t*t + b;
			return -c/2 * ((--t)*(t-2) - 1) + b;
		}
		
	}
	
}