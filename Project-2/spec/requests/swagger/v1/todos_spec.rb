require 'swagger_helper'

RSpec.describe 'v1/todos', type: :request do
  path '/todos' do

    get 'List all todos and todo items' do
      tags 'Todos'
      security [Bearer: []]

      response 200, 'Successfully retrieved all todos and todo items' do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response 422, 'Unprocessable content' do
        let(:'Authorization') { 'invalid_token' }
        run_test!
      end
    end

    post 'Create a new todo' do
      tags 'Todos'
      consumes 'application/json'
      parameter name: :todo, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string }
        },
        required: ['title']
      }
      security [Bearer: []]

      response 201, 'Todo created successfully' do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response 400, 'Bad request' do
        run_test!
      end

      response 422, 'Unprocessable content' do
        let(:'Authorization') { 'invalid_token' }
        run_test!
      end
    end
  end

  path '/todos/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get 'Get a todo' do
      tags 'Todos'
      security [Bearer: []]

      response 200, 'Successfully retrieved the specified todo' do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response 404, 'Invalid todo ID' do
        let(:id) { 'invalid_id' }
        run_test!
      end

      response 422, 'Unprocessable content' do
        let(:'Authorization') { 'invalid_token' }
        run_test!
      end
    end

    put 'Update a todo' do
      tags 'Todos'
      security [Bearer: []]
      consumes 'application/json'
      parameter name: :todo, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string }
        },
        required: ['title']
      }

      response 204, 'Successful request with no response content' do
        let(:id) { '123' }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response 400, 'Bad request' do
        run_test!
      end

      response 404, 'Invalid todo ID' do
        let(:id) { 'invalid_id' }
        run_test!
      end

      response 422, 'Unprocessable content' do
        let(:'Authorization') { 'invalid_token' }
        run_test!
      end
    end

    delete 'Delete a todo and its items' do
      tags 'Todos'
      security [Bearer: []]

      response 204, 'Successful request with no response content' do
        let(:id) { '123' }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response 404, 'Invalid todo ID' do
        let(:id) { 'invalid_id' }
        run_test!
      end

      response 422, 'Unprocessable content' do
        let(:'Authorization') { 'invalid_token' }
        run_test!
      end
    end
  end
end