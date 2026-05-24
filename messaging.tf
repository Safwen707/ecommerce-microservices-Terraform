resource "aws_sns_topic" "events" {
  name = "${var.project_name}-checkout-events"
}

resource "aws_sqs_queue" "payment_queue" {
  name = "${var.project_name}-payment-queue"
}

# Lier le Topic SNS à la file SQS
resource "aws_sns_topic_subscription" "sns_to_sqs" {
  topic_arn = aws_sns_topic.events.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.payment_queue.arn
}
