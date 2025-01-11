from flask import Flask, request, jsonify

app = Flask(__name__)

# Mock data for pipelines
pipelines = {}
pipeline_id_counter = 1

@app.route('/')
def home():
    return jsonify({"message": "Welcome to the CI/CD Pipeline API"}), 200

@app.route('/health', methods=['GET'])
def health_check():
    return jsonify({"status": "ok", "message": "Service is running"}), 200

@app.route('/pipeline/start', methods=['POST'])
def start_pipeline():
    global pipeline_id_counter

    data = request.json
    if not data or not data.get('branch'):
        return jsonify({"error": "Branch name is required"}), 400

    pipeline_id = str(pipeline_id_counter)
    pipelines[pipeline_id] = {"branch": data["branch"], "status": "running", "progress": 0}
    pipeline_id_counter += 1

    return jsonify({"message": "Pipeline started successfully", "id": pipeline_id}), 201

@app.route('/pipeline/status/<pipeline_id>', methods=['GET'])
def pipeline_status(pipeline_id):
    pipeline = pipelines.get(pipeline_id)
    if not pipeline:
        return jsonify({"error": "Pipeline not found"}), 404

    return jsonify({"id": pipeline_id, "branch": pipeline["branch"], "status": pipeline["status"], "progress": pipeline["progress"]}), 200

@app.route('/pipeline/update/<pipeline_id>', methods=['PUT'])
def update_pipeline(pipeline_id):
    pipeline = pipelines.get(pipeline_id)
    if not pipeline:
        return jsonify({"error": "Pipeline not found"}), 404

    data = request.json
    if "status" in data:
        pipeline["status"] = data["status"]
    if "progress" in data:
        pipeline["progress"] = data["progress"]

    return jsonify({"message": "Pipeline updated successfully", "id": pipeline_id}), 200

@app.route('/pipeline/stop/<pipeline_id>', methods=['POST'])
def stop_pipeline(pipeline_id):
    pipeline = pipelines.get(pipeline_id)
    if not pipeline:
        return jsonify({"error": "Pipeline not found"}), 404

    pipeline["status"] = "stopped"
    return jsonify({"message": "Pipeline stopped successfully", "id": pipeline_id}), 200

@app.route('/pipeline/delete/<pipeline_id>', methods=['DELETE'])
def delete_pipeline(pipeline_id):
    if pipeline_id not in pipelines:
        return jsonify({"error": "Pipeline not found"}), 404

    del pipelines[pipeline_id]
    return jsonify({"message": "Pipeline deleted successfully", "id": pipeline_id}), 200

@app.route('/pipelines', methods=['GET'])
def list_pipelines():
    return jsonify({"pipelines": pipelines}), 200

if __name__ == '__main__':
    # Explicitly set the host and port
    app.run(debug=True, host='0.0.0.0', port=5000)
