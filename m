Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E440B66F;
	Fri, 23 Aug 2024 00:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724372468; cv=none; b=fRofdG64q1lnDfH6MXOR5v6+ZUQeOTpl7XrX2vdw7CTx+4aH0rysIKkdyu7qQJ3gu71MpK0eMCU1vvNRAEIaBTI5RxOB1IEKTzR0XbujuT6ctR2TLy3cBHFCbf1IfjpJF5bgo7u6/lQTXm6XAsK8638q1Q8eyztt8DeaM3G9ENg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724372468; c=relaxed/simple;
	bh=ztMGBRwSXyZVCArMNbSo7WIxlHtGw+CbddsI7Azg6hI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WRm8Iyj8OlXXKwF3m0HiL0o+jWLbA+5/wndrD87Kbj6Bl+69jc7f3seQJkeSE7ip9JYcbeSEZRRw76Uu2eu/LzYyIgI5tUmJHrw2hE5nEgD1iB6rzjnlCJXidFt+bSR/CTWhEzBv4WwYQhxATLte1qsYa+JQyK0k2CUSb119+4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1PjvAtt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1PjvAtt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE12C32782;
	Fri, 23 Aug 2024 00:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724372468;
	bh=ztMGBRwSXyZVCArMNbSo7WIxlHtGw+CbddsI7Azg6hI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q1PjvAtt2Eyezud2yRCDBzOTyyL+OoqeHZH01mpzrAAKKT/M8+va6AHf+2NaD727m
	 c6+3/3+YX2TaeyPrNBNeaZnoAhd4MCdLORgr3Rx25320u+nlbop4U1NZwAFJeZ+T+y
	 h4BVQAULwbiBKr0GLE64/3sGwfY9A8S/9z/hGQzWh/CPwEs37NEsVi4J3KIaW6uoPm
	 wVpPjeGvT1UCEmnNB5S8q7X9WGwhAHun3gMweRqqanRueX9ux2fj/RG/DivCqp9oJe
	 zIRQEL/ZoIRy6gCEf4Y3xICuzXVOnZvEbFpUgx1+yPeNsUjCLyWpoia8T7lY9HUUNW
	 0XGWEIwf2DlTg==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder (was: Re: DAMON Beer/Coffee/Tea chat reminder and extending for office hour)
Date: Thu, 22 Aug 2024 17:21:05 -0700
Message-Id: <20240823002105.112390-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240519163329.150340-1-sj@kernel.org>
References: 
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

Due to some conflicts, there are some changes to the schedule as following.
The meetings that originally scheduled for the last week of August have
rescheduled to first week of September.  The meetings originally scheduled for
the second week of September has cancelled.

Dedicated-topic discussions
---------------------------

Next three time slots that I reserved in advance for possible future dedicated
topic discussions are as below.

- 2024-09-02 (Mon) 18:00 PT (reserved)
- 2024-09-24 (Tue) 09:30 PT (not yet reserved)

Please reach out to me (sj@kernel.org or whatever) to reserve the
not-yet-reserved time slots for your topics.  The reservation is made in a
First-Come First-Served way, and I will send a Google Meet link to
reservation-confirmed attendees.  Sorry for any inconvenience.

Please note that other time slots are also available based on the discussion.

Any-topic discussions
---------------------

Next two chat instance for any topic (no reservation is required) are scheduled
as below:

- 2024-09-03 (Tue) 09:30 PT (https://meet.google.com/ndx-evoc-gbu)
- 2024-09-23 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)

Shared Calendar
---------------

You can get the schedule via this shared Google Calendar:
https://calendar.google.com/calendar/u/0?cid=ZDIwOTA4YTMxNjc2MDQ3NTIyMmUzYTM5ZmQyM2U4NDA0ZGIwZjBiYmJlZGQxNDM0MmY4ZTRjOTE0NjdhZDRiY0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29t

You can also get the past and upcoming schedules via
https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing


Thanks,
SJ

[...]
