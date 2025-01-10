// App.test.js
import React from 'react';
import { render, screen, fireEvent } from '@testing-library/react';
import App from './App';

describe('App Component', () => {
  test('renders the heading', () => {
    render(<App />);
    const heading = screen.getByText(/CI\/CD Frontend Testing/i);
    expect(heading).toBeInTheDocument();
  });

  test('renders the counter with initial value of 0', () => {
    render(<App />);
    const counter = screen.getByTestId('counter');
    expect(counter).toHaveTextContent('Count: 0');
  });

  test('increments the counter when the increment button is clicked', () => {
    render(<App />);
    const incrementButton = screen.getByText(/Increment/i);
    const counter = screen.getByTestId('counter');

    fireEvent.click(incrementButton);
    expect(counter).toHaveTextContent('Count: 1');
  });

  test('decrements the counter when the decrement button is clicked', () => {
    render(<App />);
    const decrementButton = screen.getByText(/Decrement/i);
    const counter = screen.getByTestId('counter');

    fireEvent.click(decrementButton);
    expect(counter).toHaveTextContent('Count: -1');
  });
});
