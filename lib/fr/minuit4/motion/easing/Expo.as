
/** Original equations from Robert Penner */
package fr.minuit4.motion.easing 
{
	public class Expo
	{
		/**
		* @param t		Specifies the current time, between 0 and duration inclusive. 
		* @param b		Specifies the initial value of the animation property. 
		* @param c		Specifies the total change in the animation property. 
		* @param d		Specifies the duration of the motion. 
		* @return		The value of the interpolated property at the specified time.
		*/
		public static function easeIn(t:Number, b:Number, c:Number, d:Number):Number 
		{
			return (t==0) ? b : c * Math.pow(2, 10 * (t/d - 1)) + b - c * 0.001;
		}
		
		/**
		* @param t		Specifies the current time, between 0 and duration inclusive. 
		* @param b		Specifies the initial value of the animation property. 
		* @param c		Specifies the total change in the animation property. 
		* @param d		Specifies the duration of the motion. 
		* @return		The value of the interpolated property at the specified time.
		*/
		public static function easeOut(t:Number, b:Number, c:Number, d:Number):Number
		{
			return (t==d) ? b+c : c * (-Math.pow(2, -10 * t/d) + 1) + b;
		}
		
		/**
		* @param t		Specifies the current time, between 0 and duration inclusive. 
		* @param b		Specifies the initial value of the animation property. 
		* @param c		Specifies the total change in the animation property. 
		* @param d		Specifies the duration of the motion. 
		* @return		The value of the interpolated property at the specified time.
		*/
		public static function easeInOut(t:Number, b:Number, c:Number, d:Number):Number
		{
			if (t==0) return b;
			if (t==d) return b+c;
			if ((t/=d/2) < 1) return c/2 * Math.pow(2, 10 * (t - 1)) + b;
			return c/2 * (-Math.pow(2, -10 * --t) + 2) + b;
		}
		
	}
	
}