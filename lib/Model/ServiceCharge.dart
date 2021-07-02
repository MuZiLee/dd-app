

class ServiceCharge {
    String commission_fee = "0.00";
    int id;
    String service_charge_for_withdrawal = "0.00";

    ServiceCharge({this.commission_fee, this.id, this.service_charge_for_withdrawal});

    factory ServiceCharge.fromJson(Map<String, dynamic> json) {
        return ServiceCharge(
            commission_fee: json['commission_fee'], 
            id: json['id'],
          service_charge_for_withdrawal: json['service_charge_for_withdrawal'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['commission_fee'] = this.commission_fee;
        data['id'] = this.id;
        data['service_charge_for_withdrawal'] = this.service_charge_for_withdrawal;
        return data;
    }
}