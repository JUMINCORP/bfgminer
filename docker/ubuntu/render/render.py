import yaml
from jinja2 import Environment, FileSystemLoader, Template

with open('config.yaml') as config_file:
    config = yaml.load(config_file)
    env = Environment(loader=FileSystemLoader('./')) 
    template = env.get_template("template.j2")
    print(template.render(config))
