class ExpenseCost {
  String _costDate;
  String _costType;
  String _cost;
  String _notes;
  String _created;
  String _id;

  String getId() {
    return this._id;
  }

  void setId(String id) {
    this._id = id;
  }

  String get_costDate() {
    return this._costDate;
  }

  void set_costDate(String _costDate) {
    this._costDate = _costDate;
  }

  String getCostType() {
    return this._costType;
  }

  void setCostType(String cost_type) {
    this._costType = cost_type;
  }

  String get_cost() {
    return this._cost;
  }

  void set_cost(String _cost) {
    this._cost = _cost;
  }

  String get_notes() {
    return this._notes;
  }

  void set_notes(String _notes) {
    this._notes = _notes;
  }

  String get_created() {
    return this._created;
  }

  void set_created(String _created) {
    this._created = _created;
  }
}
