import os
import sys
import replace


def get_file_content():
    with open("{}/{}".format(g_controllers_path, g_file)) as f:
        line = f.readlines()
        g_file_content.extend(line)


def get_temp_content():
    if not "from openapi_server import ex_package\n" == g_file_content[0]:
        g_temp_content.append("from openapi_server import ex_package\n")
        g_temp_content.extend(g_file_content)
        for key in replace.dictionary.keys():
            found = 0
            for line_num in range(0, len(g_temp_content)):
                if "def {}(".format(key) in g_temp_content[line_num]:
                    found = 1
                    continue
                if "return " in g_temp_content[line_num] and 1 == found:
                    g_temp_content[line_num] = replace.dictionary[key] 
                    found = 0


def save():
    if not 0 == len(g_temp_content):
        with open("{}/{}".format(g_controllers_path, g_file), "w") as f:
            for line in g_temp_content:
                f.write(line)


if __name__ == '__main__':
     
    g_path = sys.argv[1:][0]
    g_files = os.listdir(g_path)
    g_controllers_path = "{}/controllers".format(g_path)
    
    if not "ex_package" in g_files:
        print("could not find ex_package in {}".format(g_path))
        exit(1)
    
    g_files = os.listdir(g_controllers_path)
    for g_file in g_files:
        if g_file.endswith("_controller.py"):
            g_file_content = []
            g_temp_content = []
            get_file_content()
            get_temp_content()
            save()
            print("{} modified.".format(g_file))
