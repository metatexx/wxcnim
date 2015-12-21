#include <wx/wx.h>
 
const int ID_RESTART =   100;
const int ID_EASY =      101;
const int ID_MEDIUM =    102;
const int ID_DIFFICULT = 103;
 
class MyFrame: public wxFrame
{
public:
   MyFrame( const wxString &title, const wxPoint& pos, const wxSize& size );
   void OnAbout( wxCommandEvent &event );
   void OnQuit( wxCommandEvent &event );
   void OnLevel( wxCommandEvent &event );
   void OnRestart( wxCommandEvent &event );
   void OnPaint( wxPaintEvent& event );
   void OnLeftDown( wxMouseEvent &event );
   void OnRightDown( wxMouseEvent &event );
 
   wxSize       level;
   int          cx, cy;
   int          normal_cells, bombs;
   wxString     field;
   
   enum {
       HIDDEN = 16,
       BOMB = 32,
       MARK = 64,
       EXPLODED = 128,
       UNIT = 30,
   };
   
   wxChar& Field(int x, int y) { return field[x + y * cx]; }
   void Level( wxSize size )   { level = size; }
   void Status();
 
public:
   void Uncover(int x, int y);
   void Generate();
   void UncoverAll();
};
 
class MyApp: public wxApp
{
public:
   virtual bool OnInit();
};
 
MyFrame::MyFrame( const wxString &title, const wxPoint &position, const wxSize& size ) :
   wxFrame( NULL, -1, title, position, size )
{
   wxMenu *file_menu = new wxMenu;
   file_menu->Append( wxID_ABOUT, wxT("About..."), wxT("Program info") );
   file_menu->AppendSeparator();
   file_menu->Append( wxID_EXIT, wxT("Quit"), wxT("Quit wxBombs") );
   
   wxMenu *game_menu = new wxMenu;
   game_menu->Append( ID_RESTART, wxT("Restart"), wxT("Restart game") );
   game_menu->AppendSeparator();
   game_menu->AppendRadioItem( ID_EASY, wxT("Easy"), wxT("Easy level") );
   game_menu->AppendRadioItem( ID_MEDIUM, wxT("Medium"), wxT("Medium level") );
   game_menu->AppendRadioItem( ID_DIFFICULT, wxT("Difficult"), wxT("Difficult level") );
 
   wxMenuBar *menu_bar = new wxMenuBar();
   menu_bar->Append( file_menu, wxT("File") );
   menu_bar->Append( game_menu, wxT("Game") );
   
   SetMenuBar( menu_bar );
   
   CreateStatusBar(1);
   
   Connect( wxID_ABOUT, wxEVT_COMMAND_MENU_SELECTED, wxCommandEventHandler(MyFrame::OnAbout) );
   Connect( wxID_EXIT, wxEVT_COMMAND_MENU_SELECTED, wxCommandEventHandler(MyFrame::OnQuit) );
   Connect( ID_RESTART, wxEVT_COMMAND_MENU_SELECTED, wxCommandEventHandler(MyFrame::OnRestart) );
   Connect( ID_EASY, wxEVT_COMMAND_MENU_SELECTED, wxCommandEventHandler(MyFrame::OnLevel) );
   Connect( ID_MEDIUM, wxEVT_COMMAND_MENU_SELECTED, wxCommandEventHandler(MyFrame::OnLevel) );
   Connect( ID_DIFFICULT, wxEVT_COMMAND_MENU_SELECTED, wxCommandEventHandler(MyFrame::OnLevel) );
   
   Connect( -1, wxEVT_LEFT_DOWN, wxMouseEventHandler(MyFrame::OnLeftDown) );
   Connect( -1, wxEVT_RIGHT_DOWN, wxMouseEventHandler(MyFrame::OnRightDown) );
   Connect( -1, wxEVT_PAINT, wxPaintEventHandler(MyFrame::OnPaint) );
   
   level = wxSize( 10, 10 );
}
 
 
void MyFrame::OnAbout( wxCommandEvent &event )
{
   wxMessageDialog dialog( this, wxT("Welcome to wxBombs"), wxT("About wxBombs"), wxOK|wxICON_INFORMATION );
   dialog.ShowModal();
}
 
void MyFrame::OnQuit( wxCommandEvent &event )
{
    Close( TRUE );
}
 
void MyFrame::OnLevel( wxCommandEvent &event )
{
   switch (event.GetId())
   {
       case ID_EASY:       Level( wxSize( 10,10 ) ); break;
       case ID_MEDIUM:     Level( wxSize( 15,15 ) ); break;
       case ID_DIFFICULT:  Level( wxSize( 25,25 ) ); break;
   }
}
 
void MyFrame::OnRestart( wxCommandEvent &event )
{
   Generate();
}
 
void MyFrame::OnPaint( wxPaintEvent& event )
{
   wxPaintDC w( this );
   
   for(int x = 0; x < cx; x++)
       for(int y = 0; y < cy; y++) {
           wxChar f = Field(x, y);
           w.SetPen( *wxBLACK_PEN );
           w.DrawRectangle(x * UNIT, y * UNIT + UNIT - 1, UNIT, 1 );
           w.DrawRectangle(x * UNIT + UNIT - 1, y * UNIT, 1, UNIT );
           
           w.SetPen( (f & (HIDDEN|MARK)) ? *wxGREY_PEN : f & BOMB ? *wxRED_PEN : *wxWHITE_PEN );
           w.DrawRectangle(x * UNIT, y * UNIT, UNIT - 1, UNIT - 1 );
 
           wxString txt;
           wxColour ink = *wxBLACK;
           wxPen cross;
           if(f & MARK) {
               txt = wxT("M");
               ink = *wxRED;
               if((f & (HIDDEN|BOMB)) == BOMB) {
                   ink = *wxBLUE;
                   cross = *wxBLACK_PEN;
               }
           }
           else
           if(!(f & HIDDEN))
               if(f & BOMB)
                   txt = wxT("B");
               else {
                   f = f & 15;
                   txt = wxString( wxChar( f + wxT('0') ), (unsigned int )1);
                   ink = f == 0 ? *wxGREEN : f == 1 ? *wxBLUE : *wxBLACK;
               }
 
           wxSize tsz = w.GetTextExtent(txt);
           w.DrawText(txt, x * UNIT + (UNIT - tsz.x) / 2, y * UNIT + (UNIT - tsz.y) / 2 );
           if(f & EXPLODED)
               cross = wxPen( *wxBLUE );
           
           if (cross != wxNullPen)
           {
               w.SetPen ( cross );
               w.DrawLine(x * UNIT, y * UNIT, x * UNIT + UNIT - 1, y * UNIT + UNIT - 1 );
               w.DrawLine(x * UNIT, y * UNIT + UNIT - 1, x * UNIT + UNIT - 1, y * UNIT );
           }
       }
}
 
void MyFrame::OnLeftDown( wxMouseEvent &event )
{
   if(!normal_cells)
       return;
   wxPoint p( event.GetX(), event.GetY() );
   p.x /= UNIT;
   p.y /= UNIT;
   Uncover(p.x, p.y);
   Refresh();
   Status();
}
 
void MyFrame::OnRightDown( wxMouseEvent &event )
{
   if(!normal_cells)
       return;
   wxPoint p( event.GetX(), event.GetY() );
   p.x /= UNIT;
   p.y /= UNIT;
   if(Field(p.x, p.y) & HIDDEN) {
       Field(p.x, p.y) ^= MARK;
       Refresh();
   }
}
 
void MyFrame::Status()
{
   wxString text;
   text.Printf( wxT("%d bombs, %d cells remaining"), bombs, normal_cells );
   SetStatusText( text );
}
 
void MyFrame::Generate()
{
   cx = level.x;
   cy = level.y;
   field.Alloc(cx * cy);
   for(int i = cx * cy - 1; i >= 0; i--)
       field[i] = (rand() & 15) < 3 ? HIDDEN|BOMB : HIDDEN;
   normal_cells = 0;
   for(int x = 0; x < cx; x++)
       for(int y = 0; y < cy; y++)
           if((Field(x, y) & BOMB) == 0) {
               normal_cells++;
               for(int xx = -1; xx <= 1; xx++)
                   for(int yy = -1; yy <= 1; yy++)
                    if((xx || yy) && x + xx >= 0 && x + xx < cx && y + yy >= 0 && y + yy < cy &&
                          (Field(x + xx, y + yy) & BOMB))
                           Field(x, y)++;
           }
   bombs = cx * cy - normal_cells;
   SetClientSize( wxSize(UNIT * cx, UNIT * cy));
   Status();
   Refresh();
}
 
void MyFrame::Uncover(int x, int y)
{
   if(x >= 0 && x < cx && y >= 0 && y < cy) {
       wxChar& f = Field(x, y);
       if((f & (HIDDEN|MARK)) == HIDDEN) {
           if(f & BOMB) {
               f |= EXPLODED;
               normal_cells = 0;
               UncoverAll();
               return;
           }
 
           if((f &= ~HIDDEN) == 0)
               for(int xx = -1; xx <= 1; xx++)
                   for(int yy = -1; yy <= 1; yy++)
                       if(xx || yy)
                           Uncover(x + xx, y + yy);
           normal_cells--;
           if(normal_cells == 0) {
               UncoverAll();
               wxMessageDialog dialog( this, wxT("You have found all the bombs!"), wxT("wxBombs"), wxOK|wxICON_INFORMATION );
               dialog.ShowModal();
           }
       }
   }
}
 
void MyFrame::UncoverAll()
{
   for(int i = cx * cy - 1; i >= 0; i--)
       field[i] = field[i] & ~HIDDEN;
   Refresh();
}
 
IMPLEMENT_APP(MyApp)
 
bool MyApp::OnInit()
{
   MyFrame *frame = new MyFrame( wxT("wxBombs"), wxPoint(20,20), wxSize(500,340) );
   frame->Show( TRUE );
   return TRUE;
}
