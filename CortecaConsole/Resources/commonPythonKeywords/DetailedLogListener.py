import os
import re
from robot.api import logger
from robot.libraries.BuiltIn import BuiltIn

class DetailedLogListener:
    ROBOT_LISTENER_API_VERSION = 2

    def __init__(self, output_dir='EachTestCaseResult'):
        """Initialize the listener and create the output directory if it doesn't exist."""
        self.output_dir = output_dir
        os.makedirs(self.output_dir, exist_ok=True)
        self.test_logs = {}
        logger.info(f"Output directory created: {self.output_dir}")

    def start_test(self, name, attrs):
        """Called when a test case starts."""
        self.current_test = name
        self.test_logs[name] = {
            'name': name,
            'status': 'Running',
            'message': '',
            'log': '',
            'stdout': '',
            'stderr': ''
        }
        logger.info(f"Starting test: {name}")

    def end_test(self, name, attrs):
        """Called when a test case ends."""
        if name in self.test_logs:
            # Capture the result status and message
            self.test_logs[name]['status'] = attrs.get('status', 'Unknown')
            self.test_logs[name]['message'] = attrs.get('message', 'No message provided')

            # Retrieve and store logs
            self.test_logs[name]['log'] = self.get_test_log(name)
            self.test_logs[name]['stdout'] = self.get_test_stdout(name)
            self.test_logs[name]['stderr'] = self.get_test_stderr(name)

            self.write_log_report(self.test_logs[name])

            # Print pass/fail content
            self.print_test_result(self.test_logs[name])

            logger.info(f"Ending test: {name} - Status: {self.test_logs[name]['status']}")

    def get_test_log(self, test_name):
        """Retrieve the full log content for the given test case."""
        log_file = os.path.join(BuiltIn().get_variable_value('${OUTPUT_DIR}'), 'log.html')
        return self.extract_log_content(log_file, test_name)

    def get_test_stdout(self, test_name):
        """Retrieve the standard output content for the given test case."""
        return self.get_test_log(test_name)  # Using log content for demonstration

    def get_test_stderr(self, test_name):
        """Retrieve the standard error content for the given test case."""
        return ""  # Placeholder: Implement if stderr needs to be captured separately

    def extract_log_content(self, log_file, test_name):
        """Extract log content for the specific test case from the log file."""
        log_content = ''
        if os.path.exists(log_file):
            with open(log_file, 'r') as file:
                content = file.read()
                # Extract content related to the test case from the HTML log
                # Adjust pattern to correctly match your log structure
                pattern = re.compile(rf'<h2>{re.escape(test_name)}</h2>.*?<pre>(.*?)</pre>', re.DOTALL)
                match = pattern.search(content)
                if match:
                    log_content = match.group(1)
        return log_content

    def format_log(self, log):
        """Format the log content."""
        formatted_log = re.sub(r'(\r?\n)+', '<br>', log)
        return formatted_log

    def write_log_report(self, test_info):
        """Write the detailed log report to an HTML file."""
        filename = os.path.join(self.output_dir, f"{test_info['name'].replace(' ', '_')}.html")
        try:
            with open(filename, 'w') as file:
                file.write("<html><head><title>Test Case Log</title></head><body>")
                file.write(self.generate_log_details(test_info))
                file.write("</body></html>")
            logger.info(f"Log report generated: {filename}")
        except Exception as e:
            logger.error(f"Failed to write log report: {e}")

    def generate_log_details(self, test_info):
        """Generate detailed log information for the test case."""
        return f"""
        <h2>Test Case: {test_info['name']}</h2>
        <p>Status: {test_info['status']}</p>
        <p>Message: {test_info['message']}</p>
        <hr>
        <p>Detailed Log:</p>
        <pre>{self.format_log(test_info['log'])}</pre>
        <hr>
        <p>Standard Output:</p>
        <pre>{self.format_log(test_info['stdout'])}</pre>
        <hr>
        <p>Standard Error:</p>
        <pre>{self.format_log(test_info['stderr'])}</pre>
        """

    def print_test_result(self, test_info):
        """Print the pass/fail result of the test case."""
        result = "PASS" if test_info['status'] == 'PASS' else "FAIL"
        logger.info(f"Test Case '{test_info['name']}' Result: {result}")
