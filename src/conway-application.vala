using Gtk;

public class Conway.Application : Gtk.Application {

	public Application () {
		Object(application_id : "de.gunibert.conway", 
			   flags          : ApplicationFlags.FLAGS_NONE);
	}
	
	public override void activate () {
		Gtk.ApplicationWindow window = new Gtk.ApplicationWindow(this);
		
		Gtk.Box box = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
		
		window.set_title("Conway - Game of Life");
		UniverseController controller = new UniverseController();
		Universe uni = new Universe();
		uni.setController(controller);
		
		Gtk.Button startbtn = new Gtk.Button.with_label("Start Universe");
		startbtn.clicked.connect( (a) => {
			if (controller.isRunning == false) {
				startbtn.set_label("Stop Universe");
			} else {
				startbtn.set_label("Start Universe");
			}
			controller.startstop();
		});
		
		box.pack_start(uni);
		box.pack_start(startbtn);
		
		window.add(box);
		
		window.show_all();
	}

	public static void main (string []args) {
		Conway.Application app = new Conway.Application();
		app.run();
	}

}
