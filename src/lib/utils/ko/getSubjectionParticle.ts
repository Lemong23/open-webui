/**
 * 주어진 단어에 적절한 한국어 주격 조사("이" 또는 "가")를 붙입니다.
 * 
 * @param word - 주격 조사가 붙을 단어입니다.
 * @returns 적절한 주격 조사가 붙은 단어를 반환합니다. 단어가 비어 있거나 한국어 단어가 아닌 경우, 단어를 변경하지 않고 반환합니다.
 * 
 * @example
 * ```typescript
 * attachSubjectParticle("사람"); // returns "사람이"
 * attachSubjectParticle("나무"); // returns "나무가"
 * attachSubjectParticle(""); // returns ""
 * attachSubjectParticle("apple"); // returns "apple"
 * ```
 */
export function attachSubjectParticle(word:string) {
  if (!word) return word; // 빈 문자열이면 그대로 반환

  const lastChar = word[word.length - 1]; // 마지막 글자 가져오기
  const lastCharCode = lastChar.charCodeAt(0);

  // 한글 유니코드 범위 체크 (가 ~ 힣)
  if (lastCharCode < 0xAC00 || lastCharCode > 0xD7A3) {
      return word; // 한글이 아니면 그대로 반환
  }

  // 한글의 종성 여부 판단 (받침 여부: (유니코드 값 - 0xAC00) % 28)
  const hasJongseong = (lastCharCode - 0xAC00) % 28 !== 0;
  const particle = hasJongseong ? "이" : "가";

  return word + particle;
}
