function CameraPlugin() {}

CameraPlugin.prototype.takepic = function(successCallback, errorCallback,options)
{
PhoneGap.exec(successCallback, errorCallback, "CameraPlugin", "takepic", []);
}

PhoneGap.addConstructor(function () {
  if (typeof window.plugins == 'undefined') window.plugins = {};
  if( typeof window.plugins.CameraPlugin == 'undefined' ) window.plugins.CameraPlugin = new CameraPlugin();
});