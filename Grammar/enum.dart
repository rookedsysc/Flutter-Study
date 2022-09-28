// enum은 대문자로 표현해줌
enum Status {
  approved, // 승인
  pending, // 대기
  rejected, //거절
}

void main() {
  Status status = Status.pending;

  if (status == Status.approved) {
    print('승인입니다.');
  } else if (status == Status.pending) {
    print('대기입니다.');
  } else {
    print('거절입니다.');
  }
}