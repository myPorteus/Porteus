#!/usr/bin/env python
#youtube-dl frontend
import sys, os.path, gobject
from subprocess import *
from tempfile import gettempdir

try:
    os.chdir('/'.join(sys.argv[0].split('/')[0:-1]))
except:
    pass

try:  
    import gtk  
except:  
    print("GTK Not Availible")
    sys.exit(1)

     
class youtubedl_gui:

    def __init__( self ):
        
        
        self.builder = gtk.Builder()
        builder = self.builder
        builder.add_from_file("youtube.xml")
        
        dic = { 
            "btnAdd_clicked"    : self.add_url,
            "btnCancel_clicked" : self.cancel_download,
            "btnDownload_clicked" : self.download,
            "btnSave_clicked"   : self.save_preference,
            "btnDelete_clicked" : self.delete,
            "btnReload_clicked" : self.reload,
            "btnPause_clicked"  : self.pause,
            "btnClear_clicked"  : self.clear,
            "btnUp_clicked"     : self.promote,
            "btnDown_clicked"   : self.demote,
            "btnDrop_clicked"   : self.btnDrop_clicked,
            "quit"              : self.quit
        }
        
        builder.connect_signals(dic)
        
        # TODO: initialise the interface
        self.winmain = self.builder.get_object("windowMain")
        self.context_id = self.builder.get_object("statusbar").get_context_id('download status')
        self.builder.get_object("statusbar").push(self.context_id,'Please regularly update youtube-dl engine by running "youtube-dl --update" in terminal')
        self.mini = False
        self.winmain.connect('event',self.wsevt)
        
        # initialise format combo box
        vf_list = { "Default" : "",
                    "Mobile"  : "--format=17",
                    "Hi-def"  : "--format=35",
                    "flv 240p": "--format=5",
                    "flv 360p": "--format=34",
                    "flv 480p": "--format=35",
                    "mp4 360p": "--format=18",
                    "mp4 720p": "--format=22",
                  }
                    
        self.create_cbo_list(builder.get_object("cboFormat"),vf_list)
        
        # create and connect status icon  to click event      
        self.statusicon = gtk.status_icon_new_from_file('ytdicon.png')
        self.statusicon.connect('activate', self.status_clicked)
        self.statusicon.set_tooltip("Youtube Downloader")
        
        ###initialize drop window and connect to accept dropped urls###
        self.w = gtk.Window()
        self.w.set_skip_taskbar_hint(True)
        self.box = gtk.EventBox ()
        self.w.add (self.box)
        drop_image = gtk.Image()
        drop_image.set_from_file('ytdicon.png')
        self.box.add(drop_image)
        self.w.set_size_request(40, 40)
        self.w.set_decorated(False)
        self.w.set_keep_above(True)
        self.w.stick()
        self.w.drag_dest_set(gtk.DEST_DEFAULT_ALL, 
            [('text/plain', 0, 0),('TEXT', 0, 1)],
            gtk.gdk.ACTION_DEFAULT|gtk.gdk.ACTION_COPY)
        self.w.connect('drag_data_received', self.got_data_cb)
        self.w.connect('delete_event',self.close_drop)
        self.box.connect('button_press_event',self.drag_window)
        
        # initialise download directory to home
        builder.get_object("folderDownload").set_current_folder(os.path.expanduser('~'))
        
        # initialise listUrl and enable multiple select
        builder.get_object("listUrl").get_selection().set_mode(gtk.SELECTION_MULTIPLE)
        
        # set local appdir to save pref and url list
        self.local_appdir = os.path.expanduser('~') + "/.ytd-gtk/"
        # if local appdir does not exist create it
        if not os.path.exists(self.local_appdir):
            os.makedirs(self.local_appdir)

        # TODO: load the url list from file and create a new download file for youtube-dl
        self.url_file = self.local_appdir + "urllist"
        if os.path.isfile(self.url_file):
            urlfile = open(self.url_file,"r")
            for urls in urlfile:
                try:
                    status, url, msg = urls.strip('\n').split(',')
                    self.builder.get_object("listUrl").get_model().append([status,url,msg])
                except:
                    pass
            urlfile.close()
        
        # Read preferences from text file
        self.pref_file = self.local_appdir + "prefs"
        if os.path.isfile(self.pref_file):
            preffile = open(self.pref_file, 'r')
            prefs = preffile.readline().strip().split('|')
            self.builder.get_object("folderDownload").set_current_folder(prefs[0])
            self.builder.get_object("cboFormat").set_active(int(prefs[1]))
            self.builder.get_object("txtProxy").set_text(prefs[2])
            self.builder.get_object("txtProxyUser").set_text(prefs[3])
            self.builder.get_object("txtProxyPass").set_text(prefs[4])
            preffile.close()
            
        # Set proxy environment
        prox_addr = self.builder.get_object("txtProxy").get_text().strip()
        prox_user = self.builder.get_object("txtProxyUser").get_text().strip()
        prox_pass = self.builder.get_object("txtProxyPass").get_text().strip()
        
        if prox_addr!="" :
            if prox_user!="":
                os.putenv('http_proxy','http://%s:%s@%s'%(prox_user,prox_pass,prox_addr))
            else:
                os.putenv('http_proxy','http://%s'%(prox_addr))
        
        # end of init module
        

    def saveurllist(self):
        urlfile = open(self.url_file,"w")
        urls = self.builder.get_object("listUrl").get_model()
        for row in urls:
            urlfile.write("%s,%s,%s\n"%(row[0],row[1],row[2]))
        urlfile.close()
        
    def quit(self,widget):
        sys.exit()        
    
    def add_url(self, widget):
        # TODO: add code to add url to list
        url = self.builder.get_object("txtUrl").get_text()
        if url.strip()!="":
            self.builder.get_object("listUrl").get_model().append(["Queued",self.builder.get_object("txtUrl").get_text(),''])
            self.builder.get_object("txtUrl").set_text("")
        self.saveurllist()
    
    def download(self, widget):
        
        # Disable the download button to prevent the start of a parallel thread
        self.builder.get_object("btnDownload").set_sensitive(False)
        self.builder.get_object("btnClear").set_sensitive(False)
        # TODO: add code to start download 
        # use pipe to call youtube-dl and parse output to show to gui
        utube_cmd = ["youtube-dl", "-t", "-c"]
        
        #get preferences
        location = self.builder.get_object("folderDownload").get_current_folder()
        vformat = self.get_cbo_option(self.builder.get_object("cboFormat"))
        if vformat!="":
            utube_cmd.append(vformat)
        
        uname = self.builder.get_object("txtUname").get_text().strip()
        passwd = self.builder.get_object("txtPass").get_text().strip()
        
        # if username/pwd not empty 
        if (uname!='' and passwd!=''):
            utube_cmd.append('-u') ; utube_cmd.append(uname)
            utube_cmd.append('-p') ; utube_cmd.append(passwd)
        
		# get url
        self.current_url = self.get_next_queued() # get current_url[status,url] field
        self.current_filename = '' #init current file name to ''
        
        # start download
        if self.current_url :
            utube_cmd.append((self.current_url[1].split('&'))[0]) # get url from current_url
            self.file_stdout = open(gettempdir()+'/utube.txt', 'w')
            self.proc = Popen(utube_cmd,  stdout=self.file_stdout, stderr=STDOUT, cwd=location)
            self.file_stdin = open(gettempdir()+'/utube.txt', 'r')
            self.current_url[0] = "Processing" ; self.current_url[2] = "In progress"
            self.timer = gobject.timeout_add(1000, self.download_status)
        else:
            # if url is empty skip download and activate download button
            self.builder.get_object("btnDownload").set_sensitive(True)
            self.builder.get_object("btnClear").set_sensitive(True)
            
    
    def download_status(self):
        # extracts the messages from the youtube-dl execution and shows on the status bar
        msg = self.file_stdin.readline().strip()

        if msg != "":
            #check if msg contains "ERROR"
            if msg.count("ERROR"):
                self.reset_ui("ERROR", msg)
                self.download(None)
                
            elif msg.count("[download]"):
                # extract %complete, size, speed and estimated_time
                msg = msg.split('[download]')
                msg = msg[len(msg)-1]
                dl_status = msg.split()
                if len(dl_status)==7 and dl_status[-2]=='ETA' :
                    dl_percent_complete = float(dl_status[0][0:-1])
                    dl_size = dl_status[2]
                    dl_speed = dl_status[4]
                    dl_time = dl_status[6]
                    self.update_progressbar(dl_percent_complete)
                    self.builder.get_object("lblProgress").set_text("Speed: "+dl_speed+" ETA: "+dl_time)
                    if dl_percent_complete >= 100.0 and self.proc.poll()!=None:
                        self.reset_ui("Done","Download complete "+self.current_filename)
                        self.download(None)
                elif dl_status[-1]=="downloaded" and self.proc.poll()!=None:
                    self.reset_ui("Done","Download complete "+self.current_filename)
                    self.download(None)
                elif self.current_filename=='' and dl_status[-2]=="Destination:":
                    self.current_filename = dl_status[-1]
                else:
                    self.builder.get_object("statusbar").push(self.context_id,msg)
            else:
                # all other messages display on status bar after removing the [xxx] entry
                msg = msg.split('] ')
                msg = msg[len(msg)-1]
                self.builder.get_object("statusbar").push(self.context_id,msg)

        elif self.proc.poll() != None:
            self.reset_ui("Queued", 'Unexpected Termination')
            self.download(None)
            
        return True # return is true to continue polling for output of youtube-dl
    
    def cancel_download(self, widget):
        # TODO: add code to stop downloading
        self.reset_ui("Queued","User Abort")
        
    def reload(self,widget):
        url_model, url_selected = self.builder.get_object("listUrl").get_selection().get_selected_rows()
        for url in url_selected:
            if url_model[url][0]!="Processing":
                url_model[url][0] = "Queued"
        self.saveurllist()
        
    def pause(self,widget):
        url_model, url_selected = self.builder.get_object("listUrl").get_selection().get_selected_rows()
        for url in url_selected:
            if url_model[url][0]=="Queued":
                url_model[url][0] = "Paused"
        self.saveurllist()
        
    def delete(self,widget):
        # Delete selected items from listurl
        url_model, url_selected = self.builder.get_object("listUrl").get_selection().get_selected_rows()
        iters = [url_model.get_iter(url) for url in url_selected]
        for iter in iters:
            if url_model[iter][0]!="Processing":
                url_model.remove(iter)
        self.saveurllist()
        
    def clear(self,widget):
        # Clear listUrl
        self.builder.get_object("listUrl").get_model().clear()
        self.saveurllist()
    
    def promote(self,widget):
        #promote queued download
        url_model, url_selected = self.builder.get_object("listUrl").get_selection().get_selected_rows()

        for url in url_selected:
            if url[0]<=0 : break
            iter = url_model.get_iter(url)
            iter_prev = url_model.get_iter(url[0]-1)
            url_model.move_before(iter,iter_prev)
        
        self.saveurllist()
    
    def demote(self,widget):
        #demote queued download
        url_model, url_selected = self.builder.get_object("listUrl").get_selection().get_selected_rows()

        for url in url_selected[::-1]:
            iter = url_model.get_iter(url)
            iter_next = url_model.iter_next(iter)
            if iter_next == None: break
            url_model.move_after(iter,iter_next)
        
        self.saveurllist()
    
    def reset_ui(self,url_status,status_msg):
        try:
            if self.proc.poll()==None:
                self.proc.terminate()
            gobject.source_remove(self.timer)
            if self.current_url:
                self.current_url[0] = url_status
                self.current_url[2] = status_msg
                self.saveurllist()
            self.builder.get_object("btnDownload").set_sensitive(True)
            self.builder.get_object("btnClear").set_sensitive(True)
            self.builder.get_object("statusbar").push(self.context_id,status_msg)
            self.builder.get_object("lblProgress").set_text("Speed: --  ETA: --")
            self.builder.get_object("progressbar").set_fraction(0)
        except:
            pass
        
    
    def save_preference(self, widget):
        # TODO: add code to save options in the preference tab

        line = self.builder.get_object("folderDownload").get_current_folder()+"|"+ str(self.builder.get_object("cboFormat").get_active())+"|"+ \
                self.builder.get_object("txtProxy").get_text().strip()+"|"+self.builder.get_object("txtProxyUser").get_text().strip()+"|" + \
                self.builder.get_object("txtProxyPass").get_text().strip()
        preffile = open(self.pref_file, 'w')
        preffile.write(line)
        preffile.close()
    
        
    def update_progressbar(self,percent_complete = 0):
        # TODO: add code to update progress bar as per the % complete parameter
        self.builder.get_object("progressbar").set_fraction(percent_complete/100)
        return 

    def create_cbo_list(self,cbo_object,cbo_dic):
        # Create options for combo box from a dictionary
        store = gtk.ListStore(str,str)
        cbo_dic_keys = cbo_dic.keys() 
        cbo_dic_keys.sort()
        for item in cbo_dic_keys:
            store.append([item,cbo_dic[item]])        
        cbo_object.set_model(store)
        cbo_object.set_active(1)
        cell = gtk.CellRendererText() 
        cbo_object.pack_start(cell) 
        cbo_object.add_attribute(cell, 'text', 0)
    
    def get_cbo_option(self,cbo_object):
        cbo_active = cbo_object.get_active()
        cbo_value = cbo_object.get_model()[cbo_active][1]
        return cbo_value
        
    def get_next_queued(self):
        url_model = self.builder.get_object("listUrl").get_model()
        for row in url_model:
            if row[0] == 'Queued':
                return row
                break
        return None
    
    def status_clicked(self,status):
        # on clicking the status icon show window and set default tab to downloads
        if self.mini:
            self.winmain.show_all()
            self.builder.get_object("notebook").set_current_page(0)
            self.mini = False
        else:
            self.winmain.hide_all()
            self.mini=True
    
    def wsevt(self,widget,event):
        if event.type == gtk.gdk.DELETE:
            self.winmain.hide_all()
            self.mini=True
            return True
    
    def got_data_cb(self,widget, context, x, y, data, info, time):
        # Got data.
        url = data.get_text().strip()
        if url!= "":
            self.builder.get_object("listUrl").get_model().append(["Queued",url,''])
        self.saveurllist()
        context.finish(True, False, time)
        return True
        
    def btnDrop_clicked(self,widget):
        if self.w.get_property('visible'):
            self.pos = self.w.get_position()
            self.w.hide_all()
        else:
            try: self.w.move(self.pos[0],self.pos[1])
            except: pass
            self.w.show_all()
       
    def close_drop(self,widget,event):
        self.btnDrop_clicked(widget)
        return True
    
    def drag_window(self,widget,event):
        self.w.begin_move_drag(event.button, int(event.x_root), int(event.y_root), event.time);
        return True

if __name__ =='__main__':   
    youtubedl_gui()
    gtk.main()
