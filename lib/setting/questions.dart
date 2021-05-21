class Question {
  String question;
  String answer;

  Question({this.answer, this.question});

  static List<Question> fetchAll() {
    return [
      Question(
          question: '請問點數會直接同步到學生資訊系統嗎?',
          answer: 'No, 由於學校資訊中心並不開放權限，所以這款APP的目的著重於幫助同學蒐集點數為主要目標'),
      Question(
          question: '請問我有參加活動，但為什麼我還沒拿到全人學習點數?',
          answer:
              'APP本身並無跟學校有合作，所以點數的問題得去詢問學務處呦.\n\nPS:可以使用APP的拍照功能紀錄當時有參加活動的證明去學務處尋求幫助'),
      Question(question: '為甚麼我的畫面字體跑版 如: 點數清單點數字體跑出框框?', answer: '解決辦法可以透過手機的字體大小設定來解決'),
      Question(question: '尚未新增', answer: '...'),
      Question(question: '尚未新增', answer: '...'),
      Question(question: '尚未新增', answer: '...'),
      Question(question: '尚未新增', answer: '...'),
      Question(question: '尚未新增', answer: '...'),
      Question(question: '尚未新增', answer: '...'),
      Question(question: '尚未新增', answer: '...'),
      Question(question: '尚未新增', answer: '...'),
      Question(question: '尚未新增', answer: '...'),

      Question(question: '尚未新增', answer: '...'),
      Question(question: '尚未新增', answer: '...')

    ];
  }
}
