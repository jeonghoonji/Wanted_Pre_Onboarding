//
//  main.swift
//  MyCreditManager
//
//  Created by 지정훈 on 2023/04/25.
//

import Foundation

var personalRating: [String: [String: String]] = [:]


receivingInput()


// MARK: -  프로그램 메뉴
func receivingInput(){
    introduction()
    let input = readLine()
    if let inputs = input{
        switch inputs{
        case "1":   // 학생추가
            addStudent()
            receivingInput()
        case "2":   // 학생삭제
            deleteStudent()
            receivingInput()
        case "3":   // 성적추가
            addStudentGrade()
            receivingInput()
        case "4":   // 성적삭제
            deleteStudentGrade()
            receivingInput()
        case "5":   // 평점보기
            showRating()
            receivingInput()
        case "X", "x":
            print("프로그램을 종료합니다....")
            break
        default:
            print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
            receivingInput()
        }
        
    }
}

// MARK: - 인사말
func introduction(){
    print("원하는 기능을 입력해주세요")
    print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료 \n")
}



// MARK: - 학생추가
func addStudent(){
    print("추가할 학생의 이름을 입력해주세요")
    let input = readLine()
    if let inputs = input{
        if inputs == ""{
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        }else{
            if personalRating.keys.contains(inputs){
                print("\(inputs)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
            }else{
                personalRating[inputs] = [:]
                print("\(inputs) 학생을 추가했습니다.")
            }
           
        }
    }
}

// MARK: - 학생삭제
func deleteStudent(){
    print("삭제할 학생의 이름을 입력해주세요")
    let input = readLine()
    if let inputs = input{
        if inputs == ""{
            print("\(inputs) 학생을 찾지 못했습니다.")
        }else{
            if personalRating.keys.contains(inputs){
                personalRating.removeValue(forKey: inputs)
                print("\(inputs) 학생을 삭제하였습니다.")
            }else{
                print("\(inputs) 학생을 찾지 못했습니다.")
            }
        }
    }
}

// MARK: - 성적추가
func addStudentGrade(){
    
    print("성적을 추가할 학생의 이름, 과목이름, 성적(A+, A, F) 등을 띄어쓰기로 구분하여 차례로 입력해주세요.")
    print("입력예) Mickey Swift A+")
    print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
    let input = readLine()
    if let inputs = input{
        let inputs = inputs.components(separatedBy: " ")
        
        if inputs.count == 3 {
            let studentName = String(inputs[0])
            let subject = String(inputs[1])
            let grade = String(inputs[2])
            
            if studentName == "" || subject == "" || grade == "" {
                print("입력이 잘못되었습니다. 다시 확인해주세요.")
            }else{
                var subjectGrade: [String: String] = [:]
                
                if personalRating.keys.contains(studentName){
                    
                    if var subjectGrade = personalRating[studentName]{
                        subjectGrade.updateValue(grade, forKey: subject)
                        personalRating[studentName] = subjectGrade
                    }else{
                        subjectGrade.updateValue(grade, forKey: subject)
                        personalRating[studentName] = subjectGrade
                    }
                    
                    print("\(studentName) 학생의 \(subject) 과목이 \(grade)로 추가(변경)되었습니다.")
                }else{
                    print("등록된 학생이 없습니다.")
                }
                
                
            }
        }else{
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        }
        
        
    }
}

// MARK: - 성적삭제
func deleteStudentGrade(){
    print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
    print("입력예) Mickey Swift")
    let input = readLine()
    if let inputs = input{
        let inputs = inputs.components(separatedBy: " ")
        
        if inputs.count == 2{
            let studentName = String(inputs[0])
            let subject = String(inputs[1])
            
            if studentName == "" || subject == "" {
                print("입력이 잘못되었습니다. 다시 확인해주세요.")
            }else{
                if personalRating.keys.contains(studentName){
                    personalRating[studentName]?.removeValue(forKey: subject)
                    print("\(studentName) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
                }else{
                    print("\(studentName) 학생을 찾지 못해습니다.")
                }
            }
        }else{
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        }
    }
}

// MARK: - 평점보기
func showRating(){
    var average : Double = 0
    print("평점을 알고싶은 학생의 이름을 입력해주세요")
    let input = readLine()
    if let inputs = input{
        if inputs == ""{
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        }else{
            if personalRating.keys.contains(inputs){
                if let studentRating = personalRating[inputs]{
                    for i in studentRating{
                        print("\(i.key): \(i.value)")
                        
                        switch i.value.uppercased(){
                        case "A+":
                            average += 4.5
                        case "A":
                            average += 4.0
                        case "B+":
                            average += 3.5
                        case "B":
                            average += 3.0
                        case "C+":
                            average += 2.5
                        case "C":
                            average += 2.0
                        case "D+":
                            average += 1.5
                        case "D":
                            average += 1.5
                        default:
                            average += 0
                        }
                    }
                    let resultAverage = String(format: "%.2f", average / Double(studentRating.count))
                    print("평점: \(resultAverage)")
                }
                
            }else{
                print("\(inputs) 학생을 찾지 못헀습니다.")
            }
        }
    }
}
