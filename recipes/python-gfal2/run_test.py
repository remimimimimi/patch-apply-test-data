
import gfal2

ctx = gfal2.creat_context()
plugins = ctx.get_plugin_names()
print("Found plugins", plugins)
plugins = dict(x.split("-", 1) for x in plugins)
assert "dcap" in plugins
assert "file" in plugins
assert "gridftp" in plugins
assert "http" in plugins
assert "sftp" in plugins
assert "srm" in plugins
assert "xrootd" in plugins
