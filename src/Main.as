package {
	import away3d.cameras.HoverCamera3D;
	import away3d.containers.View3D;
	import away3d.materials.BitmapMaterial;
	import away3d.materials.ColorMaterial;
	import away3d.materials.Material;
	import away3d.primitives.Cylinder;
	import away3d.primitives.Plane;
	import away3d.primitives.Trident;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Transform;
	import flash.ui.Mouse;

	/**
	 * ...
	 * @author Mario G. Pozzo
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite {

		// embebo la imagen
		[Embed(source = '../lib/panorama.jpg')]
		private var textura:Class;
		private var camara:HoverCamera3D;
		private var vista:View3D;
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			setupCamara();
			setupObjetos();
			setupEventos();
		}
		
		private function setupEventos():void {
			addEventListener(Event.ENTER_FRAME, actualizar);
		}
		
		private function actualizar(e:Event):void {
			if (stage.mouseX < 100) {
				camara.panAngle -= 1;
			} else if ( stage.mouseX > stage.stageWidth - 100) {
				camara.panAngle += 1;
			}
			camara.hover();
			vista.render();
		}
		
		private function setupObjetos():void {
			//var ejes:Trident = new Trident();
			//vista.scene.addChild(ejes);
			var plano:Plane = new Plane()
			plano.width = 2500;
			plano.height = 2500;
			plano.segmentsH = 10;
			plano.segmentsW = 10;
			plano.moveDown(550);
			plano.material = new ColorMaterial(0x000000);
			vista.scene.addChild(plano)
			
			var cilindro:Cylinder = new Cylinder();
			cilindro.radius = 1000;
			cilindro.height = 1000;
			cilindro.segmentsW = 20;
			cilindro.invertFaces();
			var bmp:Bitmap = new textura() as Bitmap;
			var matriz:Matrix = new Matrix();
			matriz.scale( -1, 1)
			matriz.translate(bmp.width, 0);
			var bmpd_invertida:BitmapData = new BitmapData(bmp.width, bmp.height);
			bmpd_invertida.draw(bmp, matriz);
			
			var material:BitmapMaterial = new BitmapMaterial(bmpd_invertida)
			material.smooth = true;
			cilindro.material = material;
			cilindro.openEnded = true;
			vista.scene.addChild(cilindro);
		}
		
		private function setupCamara():void {
			camara = new HoverCamera3D();
			camara.panAngle = 20;
			camara.tiltAngle = 0;
			camara.hover(true);
			camara.zoom = 8;
			camara.maxPanAngle = 210;
			camara.minPanAngle = -30;
			
			vista = new View3D();
			vista.camera = camara;
			vista.x = stage.stageWidth / 2;
			vista.y = stage.stageHeight / 2;
			addChild(vista);
			
		}

	}

}
