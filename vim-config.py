import json
import argparse
import os
home_dir = os.environ['HOME']

parser = argparse.ArgumentParser()
parser.add_argument("--config_fortran", type=int, default=1)
parser.add_argument("--config_dockerfile", type=int, default=1)
parser.add_argument("--config_svlangserver", type=int, default=1)

def lsp(f):
    def wrapper(*args, **kwargs):
        return {
            f.__name__.split("_")[-1]:f(*args, **kwargs)
        }
    return wrapper

class LSPConfig(object):
    @lsp
    def config_dockerfile(self):
        return dict(
            command="docker-langserver",
            filetypes=["dockerfile"],
            args=["--stdio"]
        )

    @lsp
    def config_fortran(self):
        return dict(
            command="fortls",
            filetypes=["fortran"],
            rootPatterns=[".fortls", ".git/"]
        )

    @lsp
    def config_svlangserver(self):
        return dict(
            command="svlangserver",
            filetypes=["systemverilog"],
            settings={
                "systemverilog.includeIndexing":["**/*.{sv,svh}"],
                "systemverilog.excludeIndexing":["test/**/*.sv*"],
                "systemverilog.defines":[],
                "systemverilog.launchConfiguration":"/tools/verilator -sv -Wall --lint-only",
                "systemverilog.formatCommand":"/tools/verible-verilog-format"
            }
        )

@lsp
def config_languageserver(args):
    config = LSPConfig()
    
    config_dict = {}
    
    if args.config_fortran:
        config_dict.update(config.config_fortran())

    if args.config_dockerfile:
        config_dict.update(config.config_dockerfile())

    if args.config_svlangserver:
        config_dict.update(config.config_svlangserver())

    return config_dict

args = parser.parse_args()
config = config_languageserver(args)
with open(f"{home_dir}/.config/coc/settings.json", "w") as j:
    json.dump(config, j, indent=4, sort_keys=True, separators=(',', ': '))
