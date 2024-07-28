
class Exception extends Error {
  constructor(message, { error = null, status = 500 } = {}) {
    super(message);
    this.status = status;
    this.error = error;
  }
}

export default Exception;

