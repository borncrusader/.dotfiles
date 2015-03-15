var t4_apps = new Array();
t4_apps[0] = "Finder";
t4_apps[1] = "Google Chrome";
t4_apps[2] = "Preview";

var t4_focus = new Array();
t4_focus[0] = slate.operation("focus", {"app":"Finder"});
t4_focus[1] = slate.operation("focus", {"app":"Google Chrome"});
t4_focus[2] = slate.operation("focus", {"app":"Preview"});

function t4_bind(win) {
	var id = t4_apps.indexOf(win.app().name());

	if (typeof this.last == 'undefined') {
		this.last = 0;
	} else {
		if (id != -1) {
			// cycle among apps in the group if the
			// current focused app isn't in this group
			this.last = (this.last+1) % t4_apps.length;
		}
	}

	// no point focusing an app that doesn't have an active window
	var target_app = -1;
	slate.eapp(function(app) {
		if (app.name() == t4_apps[this.last]) {
			target_app = app;
		}
	});

	win.doOperation(t4_focus[this.last]);
}

slate.bind("4:ctrl", t4_bind);
