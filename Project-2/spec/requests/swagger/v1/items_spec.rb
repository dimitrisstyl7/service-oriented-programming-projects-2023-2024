require 'swagger_helper'

RSpec.describe 'v1/items', type: :request do
  path '/todos/{todo_id}/items' do
    parameter name: 'todo_id', in: :path, type: :string, description: 'todo_id'

    get 'Get all todo items' do
      tags 'Todo Items'
      security [Bearer: []]

      response 200, 'Successfully retrieved all todo items' do
        let(:todo_id) { '123' }
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

    post 'Create a new todo item' do
      tags 'Todo Items'
      security [Bearer: []]
      consumes 'application/json'
      parameter name: :todo, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          done: { type: :boolean, default: false }
        },
        required: %w[title done]
      }

      response 201, 'Todo item created successfully' do
        let(:todo_id) { '123' }
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

  path '/todos/{todo_id}/items/{id}' do
    parameter name: 'todo_id', in: :path, type: :string, description: 'todo_id'
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get 'Get a todo item' do
      tags 'Todo Items'
      security [Bearer: []]

      response 200, 'Successfully retrieved the specified todo item' do
        let(:todo_id) { '123' }
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

      response 404, 'Invalid todo and/or item ID' do
        let(:id) { 'invalid_id' }
        run_test!
      end

      response 422, 'Unprocessable content' do
        let(:'Authorization') { 'invalid_token' }
        run_test!
      end
    end

    put 'Update a todo item' do
      tags 'Todo Items'
      security [Bearer: []]
      consumes 'application/json'
      parameter name: :todo, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          done: { type: :boolean }
        },
        required: %w[title done]
      }

      response 204, 'Successful request with no response content' do
        let(:todo_id) { '123' }
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

      response 404, 'Invalid todo and/or item ID' do
        let(:id) { 'invalid_id' }
        run_test!
      end

      response 422, 'Unprocessable content' do
        let(:'Authorization') { 'invalid_token' }
        run_test!
      end
    end

    delete 'Delete a todo item' do
      tags 'Todo Items'
      security [Bearer: []]

      response 204, 'Successful request with no response content' do
        let(:todo_id) { '123' }
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

      response 404, 'Invalid todo and/or item ID' do
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