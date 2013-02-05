using Gtk;
using Cairo;

public class Conway.Universe : Gtk.DrawingArea {
	
	private UniverseController controller;
	
	public void setController(UniverseController controller) {
		this.controller = controller;
		this.controller.nextState.connect( (t) => {
			this.queue_draw();
		});
	}
	
	public bool draw_cb (Context cr) {
	
		int width = this.get_allocated_width();
	
		int tile_size = width / 100;
	
		for ( int i = 0; i < 100; ++i ) {
			for ( int j = 0; j < 100; ++j) {
				if ( controller.get_state(i, j) == 0 ) {
					cr.set_source_rgb(1.0, 1.0, 1.0);
				} else {
					cr.set_source_rgb(0.0, 0.0, 0.0);
				}
				cr.rectangle(i * tile_size, j * tile_size, tile_size, tile_size);
				cr.fill();
			}
		}
	
		return true;
	}
	
	public Universe() {
		this.set_size_request(400,400);
		
		this.draw.connect(draw_cb);

	}
	
}
