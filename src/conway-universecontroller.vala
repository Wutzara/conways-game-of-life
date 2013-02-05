
public class Conway.UniverseController : GLib.Object {

	private int[,] currentState;
	public bool isRunning = false;
	public signal void nextState();

	public UniverseController() {
		currentState = new int[100,100];
		
		Rand rand = new Rand();
		
		// for debug reasons random fill
		for ( int i = 0; i < 100; ++i ) {
			for (int j = 0; j < 100; ++j) {
				currentState[i,j] = rand.int_range(0,2);
			}
		}
	}
	
	private int getNeighborsLeftEdge(int i, int j) {
		int neighbors = 0;

		for ( int a = j-1; a <= j+1; a++) {
			if ( currentState[99,a] == 1 ) neighbors++;
		}
		for ( int a = i; a <= i+1; a++) {
			for ( int b = j-1; b <= j+1; b++) {
				if (currentState[a,b] == 1) neighbors++;
			}
		}

		return neighbors;
	}
	
	private int getNeighborsRightEdge(int i, int j) {
		int neighbors = 0;

		for ( int a = j-1; a <= j+1; a++) {
			if ( currentState[0,a] == 1 ) neighbors++;
		}
		for ( int a = i-1; a <= i; a++) {
			for ( int b = j-1; b <= j+1; b++) {
				if (currentState[a,b] == 1) neighbors++;
			}
		}

		return neighbors;
	}
	
	private int getNeighborsTopEdge(int i, int j) {
		int neighbors = 0;

		for ( int a = j-1; a <= j+1; a++) {
			if ( currentState[a,99] == 1 ) neighbors++;
		}
		for ( int a = i-1; a <= i+1; a++) {
			for ( int b = j; b <= j+1; b++) {
				if (currentState[a,b] == 1) neighbors++;
			}
		}

		return neighbors;
	}
	
	private int getNeighborsBottomEdge(int i, int j) {
		int neighbors = 0;

		for ( int a = j-1; a <= j+1; a++) {
			if ( currentState[a,0] == 1 ) neighbors++;
		}
		for ( int a = i-1; a <= i+1; a++) {
			for ( int b = j-1; b <= j; b++) {
				if (currentState[a,b] == 1) neighbors++;
			}
		}

		return neighbors;
	}
	
	private int getNeighborsField(int i, int j) {
		int neighbors = 0;
		for ( int a = i-1; a <= i+1; a++) {
			for ( int b = j-1; b <= j+1; b++) {
				if (currentState[a,b] == 1) neighbors++;
			}
		}
		return neighbors;
	}
	
	private int LifeOrDeath(int i, int j) {
		int neighbors = 0;
		
		if ( i == 0 && j > 0 && j < 99) {
			neighbors = getNeighborsLeftEdge(i,j);
		}
		else if ( i == 99 && j > 0 && j < 99) {
			neighbors = getNeighborsRightEdge(i,j);
		}
		else if ( j == 0 && i > 0 && i < 99) {
			neighbors = getNeighborsTopEdge(i,j);
		}
		else if ( j == 99 && i > 0 && i < 99) {
			neighbors = getNeighborsBottomEdge(i,j);
		}
		else if ( i > 0 && j > 0 && i < 99 && j < 99 ) {
			neighbors = getNeighborsField(i,j);
		}
		else return 0;
		// Cell is alive
		if ( currentState[i,j] == 1 ) {
			neighbors--;
			if ( neighbors < 2 ) return 0;
			else if ( neighbors > 3 ) return 0;
			else return 1;
		}
		// Cell is dead
		else {
			if ( neighbors == 3 ) return 1;
			else return 0;
		}
	}
	
	
	public bool calculateNextState() {
		int[,] nextState = new int[100,100];
		
		for ( int i = 0; i < 100; i++ ) {
			for ( int j = 0; j < 100; j++ ) {
				nextState[i,j] = LifeOrDeath(i,j);
			}
		}
		
		currentState = nextState;
		this.nextState();
		return isRunning;
	}
	
	public int get_state(int i, int j) {
		return currentState[i,j];
	}
	
	public void startstop() {
		if ( isRunning == false ) {
			isRunning = true;
			Timeout.add(100, calculateNextState);
		} else {
			isRunning = false;
		}
	}

}
