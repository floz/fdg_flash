
/** Original equations from Robert Penner */
package fr.minuit4.motion.easing 
{
	public class Sine 
	{
		private static const _HALF_PI:Number = Math.PI / 2;
		
		/**
		* @param t		Specifies the current time, between 0 and duration inclusive. 
		* @param b		Specifies the initial value of the animation property. 
		* @param c		Specifies the total change in the animation property. 
		* @param d		Specifies the duration of the motion. 
		* @return		The value of the interpolated property at the specified time.
		*/
		public static function easeIn (t:Number, b:Number, c:Number, d:Number):Number
		{
			return -c * Math.cos(t/d * _HALF_PI) + c + b;
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
			return c * Math.sin(t/d * _HALF_PI) + b;
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
			return -c/2 * (Math.cos(Math.PI*t/d) - 1) + b;
		}
		
	}
	
}