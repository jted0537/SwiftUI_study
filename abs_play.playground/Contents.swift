import UIKit
import Swift

struct Stack {
    var stack = [Int]()
    //mutating이란 구조체 및 열거형 내부에 정의된 값을 바꿀 수 있게 해주는 키워드, 여기서는 stack내부의 값을 변경.
    /* 스택 두개로 하나의 큐 만들기 by swift
     우선적으로 stack을 두개를 만들어준다.
     첫 번쨰 스택을 inBox, 두 번째 스택을 outBox라 하자.
     그렇다면 일단 큐에 아이템을 넣어주는 것은 그저 inBox에 넣어주게 되면 된다.
     큐에서 아이템을 제거해주는것이 문제인데 알고리즘은 다음과 같다.
     1. 일단 outBox가 비어있지 않다면, 그저 outBox의 맨위에서 item을 꺼내주면 된다.
     2. 만약 outBox가 비어있다면, inBox가 빌 때까지 outBox에 넣어준다. 그런 다음에 outBox를 pop해주면 된다
     */
    mutating func push(element: Int)->Void {
        return stack.append(element)
    }

    mutating func pop()-> Int? {
        return stack.popLast()
    }
    
    func isEmpty()->Bool{
        //return stack.isEmpty() 에러. 그냥 isEmpty호출
        return stack.isEmpty
    }
}

var inBox = Stack()
var outBox = Stack()

func inQueue(item: Int = 1)->Void{
    inBox.push(element: item)
}

func deQueue()->Int?{
    if outBox.isEmpty(){
        while !inBox.isEmpty(){
            outBox.push(element: inBox.pop()!)
        }
    }
    if let a: Int =  outBox.stack.last {
        print(a)
    }
    return outBox.pop()
}

/*
deQueue()
inQueue()
inQueue(item : 4)
inQueue(item : 3)
inQueue(item : 2)
inQueue(item : 1)
deQueue()
deQueue()
deQueue()
deQueue()
deQueue()
*/
 /*
   형변환시에 is로 type을 체크할 수 있고,
   as?는 downcast가 가능하지 않다면 nil반환
   as!는 downcast가 가능하지 않다면 런타임 에러
 
   upcast의 경우 무엇을 해도 상관업지만
 as : 오류반환
 as? : nil반환
 as! : 오류반환
 */
var optionalValue: Int! = 20
optionalValue = optionalValue+1
print(optionalValue!)

struct Student{
    var `class`: Int = 3
    var stuName: String = "null"
    static var stuClass: Int = 1
    mutating func printName()->Void{ //앞서 말했듯이 mutating은 구조체 내부변수 변경가능
        self.stuName = "io"
        print("\(stuName)")
    }
    static func printClass()->Void{
        print("\(self.stuClass)")
    }
}

var s1: Student = Student()
var s2: Student = Student()
s1.stuName = "tao"
s2.stuName = "bao"

s1.printName()
Student.printClass()
print(Student.stuClass)

var `class`: Int = 3
print(`class`)


struct Man{
    var age: Int = 0
    var name: String = ""
    var plus: Int{
        get{
            return self.age
        }
        set{
            age = newValue*2+1
        }
    }
    var doller: Int{
        get{
            return age*12
        }
        set{
            age = newValue * 3
        }
    }
}

var firstMan:Man = Man()
firstMan.plus = 3
print("\(firstMan.age)살 입니다")
firstMan.doller = 5
print("\(firstMan.doller)살 입니다")



func a(age: Int?){
    assert(age != nil, "nil임")
    assert((age! >= 0) && (age! <= 130), "나이값잘못됨")
}

var tmp = 70
a(age: tmp)

