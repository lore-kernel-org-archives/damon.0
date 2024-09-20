Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0B255897;
	Fri, 20 Sep 2024 07:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726816380; cv=none; b=jGXUxucovnGQNEd33xQoqIOr73Re/IWYekJ56xf98h8ZKg2LA4Fu1QEtVJVvyRC/fvbv5RRNXmynFg0jNw398XVKMDff6dpMzjuLF7qjhgjn/HF7Y3iwERK/5fIKEIH7MJUcFkQbYqsfBcxvTDZeGuaSzoCudcyt+IcpZos2OOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726816380; c=relaxed/simple;
	bh=ZJvISPtPq3+qRDOJvQTH0OIRh8JTF7qw15SFZ+NCIXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GSwhokGykiQg/6HrMMVoPLMU8GC8/C4xA+DfOlIwA5NWT10CzpSJwLZ5IJobNbMQagao0KeeSYBZ+AzCGhZe3Qzd+cRGg0S4OwXMSWQ0hjrM+nhjCK6gNDtePZtOGaUx9aP1yYKdWUDJ+X43h34jIhLrc+ShJQqR8A7XcJXVQzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAV1v4og; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAV1v4og"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC8AC4CEC5;
	Fri, 20 Sep 2024 07:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726816379;
	bh=ZJvISPtPq3+qRDOJvQTH0OIRh8JTF7qw15SFZ+NCIXI=;
	h=From:To:Cc:Subject:Date:From;
	b=jAV1v4ogk4aHFALA2x29CQB947xy8Kli8vVlDNeE6aE+mhNC0vQfq1D5tSMSwHHfF
	 y2FKBnPnESqdJiuDZwklcP4rq0XabCIiKmJ1lUI6h3CcmaNH0PWyPx+mETq/d34wO8
	 PJNE0oqtjs0OSlwX9/FZ+Jta5bWGDwG+8Qv0nmScyw7jxwpduqJbSFZpPQEOR65V7F
	 tdsQPCeD6GB1Tu8zhnOfE446nIfMfvv7yCxHJXHgtD6Xhce0J+dg3fX57SIoDQbf/3
	 kacV5DeIlfqt6FVt47fTn4D4EGUtGEHpkxuWrXHGrL4avm//vW2mP4xKvoFPepoVce
	 sFR3Zweq4DbGQ==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder (was: Re: DAMON Beer/Coffee/Tea chat reminder and extending for office hour)
Date: Fri, 20 Sep 2024 00:12:54 -0700
Message-ID: <20240920071255.373268-1-sj@kernel.org>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Sun, 19 May 2024 09:33:29 -0700 SeongJae Park <sj@kernel.org> wrote:
> On Wed, 10 Aug 2022 22:51:02 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
> > Hello,
> > 
> > 
> > In short, I'd like to start an open, regular, and informal virtual bi-weekly
> > meeting series for DAMON community.
> > 
> > Important links and dates
> > -------------------------
> > 
> > Location: https://meet.google.com/ndx-evoc-gbu
> > Agenda: https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing
> 
[...]
> Firstly, I will regularly provide reminder of the series, probably 1-2 days
> before every instance.
> 
> Secondly, I'm extending this series for reservation-based office hour.  That
> is, I will reserve my time for 30 minutes every two weeks, keep the schedule
> public, and encourage people to reserve the time for discussion on a special
> topic for them.  The reservation should be made at least one day before the
> time slot, and will be first-come first-served basis.  In detail, I will
> reserve Monday afternoon or Tuesday morning of the group chat scheduled week.
> Note that this is not necessarily only time slot for such discussion.  You're
> still encouraged to schedule private meetings on your convenience.

So, yet another reminder.

Any-topic discussions
---------------------

Next two chat instance for any topic (no reservation is required) are scheduled
as below:

- 2024-09-23 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)
- 2024-10-08 (Tue) 09:30 PT (https://meet.google.com/ndx-evoc-gbu)
- 2024-10-21 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)

Dedicated-topic discussions
---------------------------

Next three time slots that I reserved in advance for possible future dedicated
topic discussions are as below.

- 2024-09-24 (Tue) 09:30 PT (not yet reserved)
- 2024-10-07 (Mon) 18:00 PT (not yet reserved)
- 2024-10-22 (Tue) 09:30 PT (not yet reserved)

Please reach out to me (sj@kernel.org or whatever) to reserve the
not-yet-reserved time slots for your topics.  The reservation is made in a
First-Come First-Served way, and I will send a Google Meet link to
reservation-confirmed attendees.

Please note that other time slots are also available based on the demands.

Shared Calendar
---------------

You can get the schedule via this shared Google Calendar:
https://calendar.google.com/calendar/u/0?cid=ZDIwOTA4YTMxNjc2MDQ3NTIyMmUzYTM5ZmQyM2U4NDA0ZGIwZjBiYmJlZGQxNDM0MmY4ZTRjOTE0NjdhZDRiY0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29t

You can also get the past and upcoming schedules via
https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing


Thanks,
SJ

[...]
