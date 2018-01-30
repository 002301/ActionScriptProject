
package com.man.PicControl
{
	import com.greensock.easing.Strong;
	import com.greensock.TweenMax;
	import com.greensock.plugins.*;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.nettop.webUtils.Global;;
	/**
	 * ...
	 * @author maning
	 * 初始化后图片集中在右侧，点击左右后只有当前的图片移动，其他不动。
	 *
	   import com.man.PicControl.LeftRight;
	   var lrCtor = new LeftRight(lists,l,r,863);
	 *
	 */
	public class LRCenter extends PicControl
	{
		private var showAry = new Array();//显示控制数组
		private var picAry = new Array(); //图片
		private var len:int;
		private var currentPage = 0;
		private var canT = false;
		private var _contMc:Object ;
		private var _endF:Function = null;
		private var _parentMc:Object
		/**
		 * LeftRight 参数说明
		 * @cont  需要切换的图片剪辑
		 * @l     左侧按钮
		 * @r     右侧按钮
		 * 
		 * **/
		public function LRCenter(Cont:Sprite,pl:Array, l:Object, r:Object):void
		{
			//trace("lr_Init")
			TweenPlugin.activate([TintPlugin, ColorTransformPlugin]);
			// 说明 x轴 ,y轴, x缩放，y缩放，透明度，颜色，图层位置
			showAry[0] = [-600,0,0.5,0.5,0.7,"0x000000",4];
			showAry[1] = [-440,0,0.6,0.6,1,"0x000000",3];
			showAry[2] = [-260,0,0.8,0.8,1,"0x000000",2];
			showAry[3] = [0,0,1,1,1,"0x000000",1];
			showAry[4] = [260,0,0.8,0.8,1,"0x000000",2];
			showAry[5] = [440,0,0.6,0.6,1,"0x000000",3];
			showAry[6] = [600,0,0.5,0.5,0.7,"0x000000",4];
			showAry[7] = [0,0,0.6,0.6,0,"noChange",5];
			_parentMc = Cont;
			picAry = pl;
			super();
			super.init(Cont, l, r);
			
			
		}
		
		override public function movie(num:Number):void {
		   for (var i=0; i< _total; i++)
		   {
			   var targetMc = picAry[i];
			    _currentNum = num;
				var cha = i - num;
				var sl = 3 + cha;
				trace("slNUm:"+sl)
				if ( sl>-1 && sl < 7) {
					TweenMax.to(targetMc, 0.5, { x:showAry[sl][0], y:showAry[sl][1], scaleX:showAry[sl][2], scaleY:showAry[sl][3], alpha:showAry[sl][4]});
					if (sl == 3) {
						_contMc = targetMc;
						TweenMax.to(targetMc, 0.3, { colorTransform: { tint:showAry[sl][5], tintAmount:0 }} );
					}else {
						TweenMax.to(targetMc, 0.3, {colorTransform:{tint:showAry[sl][5], tintAmount:0.5}});
					}
					if (_parentMc.numChildren < showAry[sl][6])
					{
						_parentMc.setChildIndex(targetMc,_parentMc.numChildren);
					}
					else
					{
						_parentMc.setChildIndex(targetMc,_parentMc.numChildren-showAry[sl][6]);
					}
					
				}else {
					sl = 7;
					TweenMax.to(targetMc, 0.5, {x:showAry[sl][0], y:showAry[sl][1],scaleX:showAry[sl][2],scaleY:showAry[sl][3],alpha:showAry[sl][4]});
					
				}
		   }
		   dispatchEvent(new Event("change"));
		   AutoHide();
		   onENDFunction()
		 }
		 
		public function  onENDFunction():void {
			 if (endF != null) {
				 endF();
			 }
		}
		

		
		
		public function get endF():Function 
		{
			return _endF;
		}
		
		public function set endF(value:Function):void 
		{
			_endF = value;
		}
		
		public function get contMc():Object 
		{
			return _contMc;
		}
	}

}