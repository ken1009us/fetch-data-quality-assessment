import json


class JSONProcessor:
    def __init__(self, data_path):
        self.data_path = data_path
        self.json_data_dict = {}


    def preprocess_json_file(self, filename):
        # Read the JSON file
        with open(self.data_path / filename, 'r') as file:
            data = file.read()
        data = data.replace('}\n{', '},\n{')
        data = f"[{data}]"

        return data


    def process_json_file(self, filename):
        # Preprocess the JSON file
        preprocessed_json_file = self.preprocess_json_file(filename)
        self.json_data_dict[filename.split('.')[0]] = preprocessed_json_file


    def print_json_data(self, filename):
        for filename in self.json_data_dict:
            json_data = json.loads(self.json_data_dict[filename])
            print(json_data)


    def get_json_data(self, filename):
        for filename in self.json_data_dict:
            json_data = json.loads(self.json_data_dict[filename])
            return json_data

        return None
