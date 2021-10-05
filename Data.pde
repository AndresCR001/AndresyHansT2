class Data{

  Table table = loadTable("PSPlist.csv");  
  
  int rowNumber;
  TableRow row;
  
  void setRowNumber(int nSong){
    rowNumber=nSong;
  }
  
  int getnSong(){
    return rowNumber;
  }
  
  int getTotalSongs(){
    return this.table.getRowCount()-1;
  }
  
  String getSongName()
  {
    row = table.getRow(rowNumber);
    return row.getString(0);
  }
  String getSongArtist()
  {
    row = this.table.getRow(rowNumber);
    return row.getString(1);
  }
  String getSongFileName()
  {
    row = this.table.getRow(rowNumber);
    return row.getString(2);
  }
  String getSongImageFileName()
  {
    row = this.table.getRow(rowNumber);
    return row.getString(3);
  }
  
}
