(include "assert.scm")

(define (test-failure name expected-message body)
    (test-case name
        (assert-raise (string-append "AssertionError: " expected-message)
            body)))

(test-failure "(fail) throws AssertionError with message"
    "message"
    (lambda () (fail "message")))

(test-case "(check) should not fail on #t condition"
    (lambda () (check "should not fail" #t)))

(test-failure "(check) fails on #f condition"
    "should fail"
    (lambda () (check "should fail" #f)))

(test-case "(assert=) equals number"
    (assert= 1 1))

(test-failure "(assert=) fails"
    "expected:<1> but was:<2>"
    (assert= 1 2))

(test-case "(assert-string=) equals string"
    (assert-string= "abc" "abc"))

(test-failure "(assert-string=) fails"
    "expected:<abc> but was:<123>"
    (assert-string= "abc" "123"))

(test-case "(assert-inexact=) equals number"
    (assert-inexact= 1. 1.1 0.11))

(test-failure "(assert-inexact=) fails"
    "expected: in range <[.99-1.01]> but was:<1.1>"
    (assert-inexact= 1. 1.1 0.01))

(assert-list= = "int" (list 1 2) (list 1 2))
(assert-list= string=? "string" (list "a") (list "a"))

(test-case "(assert-true)"
    (assert-true #t))

(test-failure "(assert-true) fails"
    "expected:<true> but was:<false>"
    (assert-true #f))

(test-case "(assert-false)"
    (assert-false #f))

(test-failure "(assert-false) fails"
    "expected:<false> but was:<true>"
    (assert-false #t))

(test-case "assert-raise"
    (assert-raise
        'a
        (lambda () (raise 'a))))

(ignored-test-case "ignored, else it would fail"
    (assert-true #f))
