import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined
void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);
  // make the manager
  Interactive.make( this );
  buttons = new MSButton[NUM_ROWS][NUM_COLS];
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      buttons[r][c] = new MSButton(r, c);
    }
  }
  setMines();
}
public void setMines()
{
  while(mines.size() < NUM_ROWS) {
    int r = (int)(Math.random() * NUM_ROWS);
    int c = (int)(Math.random() * NUM_COLS);
    if (!mines.contains(buttons)) {
      mines.add(buttons[r][c]);
    }
  }
} 
public void draw ()
{
  background(0);
  if (isWon() == true)
    displayWinningMessage();
}
public boolean isWon()
{
    for(int r = 0; r < NUM_ROWS; r++){
      for(int c = 0; c < NUM_COLS; c++){
         if(buttons[r][c].clicked == false && !mines.contains(buttons[r][c])){
           return false;
         }
      }
    }
  return true;
 }
public void displayLosingMessage()
{
  for(int i = 0; i < mines.size(); i++)
    if(mines.get(i).clicked == false)
      mines.get(i).mousePressed();
    buttons[NUM_ROWS/2 -1][(NUM_COLS/2)-4].setLabel("Y");
    buttons[NUM_ROWS/2 - 1][(NUM_COLS/2)-3].setLabel("O");
    buttons[NUM_ROWS/2 -1][(NUM_COLS/2)-2].setLabel("U");
    buttons[NUM_ROWS/2 - 1][(NUM_COLS/2)-1].setLabel("");
    buttons[NUM_ROWS/2 - 1][(NUM_COLS/2)].setLabel("L");
    buttons[NUM_ROWS/2 - 1][(NUM_COLS/2)+1].setLabel("O");
    buttons[NUM_ROWS/2 - 1][(NUM_COLS/2)+2].setLabel("S");
    buttons[NUM_ROWS/2 - 1][(NUM_COLS/2)+3].setLabel("T");
}
public void displayWinningMessage()
{
    buttons[NUM_ROWS/2 - 1][(NUM_COLS/2)-4].setLabel("");
    buttons[NUM_ROWS/2 - 1][(NUM_COLS/2)-3].setLabel("Y");
    buttons[NUM_ROWS/2 - 1][(NUM_COLS/2)-2].setLabel("O");
    buttons[NUM_ROWS/2 - 1][(NUM_COLS/2)-1].setLabel("U");
    buttons[NUM_ROWS/2 - 1][(NUM_COLS/2)].setLabel("");
    buttons[NUM_ROWS/2 - 1][(NUM_COLS/2)+1].setLabel("W");
    buttons[NUM_ROWS/2 - 1][(NUM_COLS/2)+2].setLabel("I");
    buttons[NUM_ROWS/2 - 1][(NUM_COLS/2)+3].setLabel("N");
}
public boolean isValid(int row, int col)
{
  if(row >= 0 && row < NUM_ROWS && col >= 0 && col < NUM_COLS) {
    return true;
  }
  return false;
}
public int countMines(int row, int col)
{
  int numMines = 0;
  if (isValid(row+1, col) && mines.contains(buttons[row+1][col]))
    numMines++;
  if (isValid(row+1, col - 1)&& mines.contains(buttons[row + 1][col - 1]))
    numMines++;
  if (isValid(row+1, col + 1) && mines.contains(buttons[row + 1][col+1]))
    numMines++;
  if (isValid(row, col-1) && mines.contains(buttons[row][col-1]))
    numMines++;
  if (isValid(row, col+1) && mines.contains(buttons[row][col+1]))
    numMines++;
  if (isValid(row-1, col) && mines.contains(buttons[row-1][col]))
    numMines++;
  if (isValid(row-1, col - 1) && mines.contains(buttons[row -1][col-1]))
    numMines++;
  if (isValid(row-1, col + 1) && mines.contains(buttons[row-1][col+1]))
    numMines++;
  return numMines;
}
public class MSButton
{
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean clicked, flagged;
  private String myLabel;
  public MSButton ( int row, int col )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    myLabel = "";
    flagged = clicked = false;
    Interactive.add( this ); // register it with the manager
  }
  // called by manager
  public void mousePressed () 
  {
    clicked = true;
    if(mouseButton == RIGHT && flagged == true) {
      clicked = flagged = false;
    }
    else if(mouseButton == RIGHT && flagged == false) {
      clicked = flagged = true;
    }
    else if(mines.contains(this)) {
      displayLosingMessage();
    } 
    else if(countMines(myRow, myCol) > 0) {
      setLabel("" + countMines(myRow, myCol));
    } 
    else {  
      if(isValid(myRow+1, myCol) && buttons[myRow+1][myCol].clicked == false)
        buttons[myRow + 1][myCol].mousePressed();
      if(isValid(myRow+1, myCol - 1)&& buttons[myRow + 1][myCol - 1].clicked == false)
        buttons[myRow + 1][myCol -1].mousePressed();
      if(isValid(myRow+1, myCol + 1) && buttons[myRow + 1][myCol+1].clicked == false)
        buttons[myRow+1][myCol + 1].mousePressed();
      if(isValid(myRow, myCol-1) && buttons[myRow][myCol-1].clicked == false)
        buttons[myRow][myCol-1].mousePressed();
      if(isValid(myRow, myCol+1) && buttons[myRow][myCol+1].clicked == false)
        buttons[myRow][myCol+1].mousePressed();
      if(isValid(myRow-1, myCol) && buttons[myRow-1][myCol].clicked == false)
        buttons[myRow-1][myCol].mousePressed();
      if(isValid(myRow-1, myCol - 1) && buttons[myRow -1][myCol-1].clicked == false)
        buttons[myRow-1][myCol-1].mousePressed();
      if(isValid(myRow-1, myCol + 1) && buttons[myRow-1][myCol+1].clicked == false)
        buttons[myRow-1][myCol + 1].mousePressed();
    }    
  }
  public void draw () 
  {    
    if (flagged)
      fill(0);
    else if (clicked && mines.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else 
    fill( 100 );
    rect(x, y, width, height);
    fill(0);
    text(myLabel, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    myLabel = newLabel;
  }
  public void setLabel(int newLabel)
  {
    myLabel = ""+ newLabel;
  }
  public boolean isClicked(){
    return clicked;
  }
  public boolean isFlagged()
  {
    return flagged;
  }
}
