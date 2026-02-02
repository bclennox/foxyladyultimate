# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Foxy Lady Ultimate is a Rails 8 application for scheduling and coordinating weekly ultimate frisbee games. It manages game schedules with recurring events, player registration and RSVP, email notifications via Maileroo, and admin game management.

## Development Commands

```bash
# Start development server (runs on port 4000)
bin/dev

# Run all tests
bundle exec rspec

# Run specific test file
bundle exec rspec spec/models/game_spec.rb

# Run tests with specific seed
bundle exec rspec --seed 1234

# Database setup
bin/rails db:setup
```

## Architecture

### Key Patterns

- **Decorators**: Uses Draper gem for presenters (app/decorators/)
- **ViewComponents**: Reusable UI components (app/components/)
- **Services**: Domain logic in app/models/ (Authorizer, GameNotifier, RandomQuip, PlayerRanker)
- **Background Jobs**: Good Job for async processing; dashboard at /good_job

### Authentication & Authorization

- Devise for user authentication
- Players have unique access tokens for public RSVP links (no login required)
- Any signed-in user is considered an admin (Authorizer#admin?)

### Email System

- GameMailer sends reminders, cancellations, and reschedule notifications
- Uses Maileroo service with custom SMTP per user
- Emails include iCalendar attachments for calendar integration

### Data Model

- **Game**: Scheduled events with location, responses, cancellation status
- **Player**: Active players with access tokens; soft-deleted via deleted_at
- **Schedule**: Weekly recurrence rules using IceCube gem (e.g., Monday/Friday at specific time)
- **Response**: Player RSVP (playing: boolean) linking players to games
- **Location**: Game venues with name and URL
- **Quip**: Funny confirmation/rejection messages shown in emails

### Key Routes

- `GET /` - Next upcoming game (public)
- `GET /games/:id/respond?playing=yes|no` - RSVP with access_token
- `GET /games/:id.ics` - iCalendar download
- `POST /games/:id/remind` - Send custom reminder (admin)
- `GET /players/ranked` - Player rankings

## Configuration Notes

- Timezone: Eastern Time (US & Canada)
- Database: PostgreSQL with SQL schema format (db/structure.sql)
- Dev server port: 4000 (not 3000)
- Encrypted fields: User SMTP password uses ActiveRecord encryption
