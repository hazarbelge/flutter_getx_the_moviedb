import 'dart:convert';

class SessionData {
  SessionData({
    this.success,
    this.guestSessionId,
    this.expiresAt,
  });

  factory SessionData.fromRawJson(String str) => SessionData.fromJson(json.decode(str));

  factory SessionData.fromJson(Map<String, dynamic> json) {
    return SessionData(
      success: json["success"],
      guestSessionId: json["guest_session_id"],
      expiresAt: json["expires_at"],
    );
  }

  final bool? success;
  final String? guestSessionId;
  final String? expiresAt;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "success": success,
      "guest_session_id": guestSessionId,
      "expires_at": expiresAt,
    };
  }
}
