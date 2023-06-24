// Entry point for the build script in your package.json
import '@hotwired/turbo-rails';
import './controllers';
import * as Turbo from '@hotwired/turbo';
window.Turbo = Turbo;

import * as bootstrap from 'bootstrap';
window.bootstrap = bootstrap;

import 'vanilla-nested';

import './controllers';
console.log('application js here');

import * as ActiveStorage from '@rails/activestorage';
ActiveStorage.start();

import 'trix';
import '@rails/actiontext';
