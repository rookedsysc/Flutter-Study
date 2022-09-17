void main() {
    // Set - 중복값을 넣을 수 없음
    final Set<String> names = {
        'black pink' ,
        'ive', 
        'ITZY',
        'black pink'
    };

    print(names); 

    // 삭제 / 추가
    names.add('소녀시대');
    print(names);
    names.remove('black pink');
    print(names);

    // black pink가 있는지 확인 해줌
    print(names.contains('black  pink')); // false 출력
}