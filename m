Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F5386348;
	Tue, 25 Nov 2025 01:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764035927; cv=none; b=ATc5xDmvrXCb5c6CJcCvMCCqaq2MLEyFH93I0Nuffyf8QcHiweHJXKlO+aS6CqaOATHNP/OLVWUwdN+wfg6CdCU4CNMXkTZB9PdjVowmc9Z2W5UkcdYjTUyVIFdtKVvzu5yP7DbJgRxutOKKm/u6QTmeVvvuSf4L20J8pJa+xxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764035927; c=relaxed/simple;
	bh=KfSY+SI7u9T/97OGhQGRlPqnpjzp2fBwvnyuyEWMjRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j/g9KaNOjthDbEBgUQVQA5Ts/IpejIJ8JZUEUvQ72xBd/6wQO4Ius9lx+lr5M5jwnDkvCis3yUUwql1ELuR/Ce4jZS7J1THJ8TMAByfCWPug7rks5wpZ6uSQY/IMPjc656aZ1V6qur/G+U+cL4gkObGQ8xWauAGW9vg/1vSejME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMo39SHv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMo39SHv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A549C4CEF1;
	Tue, 25 Nov 2025 01:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764035926;
	bh=KfSY+SI7u9T/97OGhQGRlPqnpjzp2fBwvnyuyEWMjRg=;
	h=From:To:Cc:Subject:Date:From;
	b=vMo39SHvEcZ43ixDJuff8ONMSi1dMFAlDsIXAnX1G3xynanoz4op6wQQgj8M0v+k4
	 uNSlZ780uqpyv4m8HlhtH0D+LtbnAEmRsfit4rzOHU0TJpUaXSlN0E9BcqoOb1Sqe3
	 sHuJC/dtdnstG3Ol+fwtjJju4EKZMKUUZac0BZv+eibei+mg6itoUdE/TlcPFTdqmR
	 XbrXscxnJ3V0jSziw6gI9NEAt3mAVeWMoMx6MR5CzXt21p3gt3MaLV/8M/faL7GxDg
	 RLvV5pSfYegx1DHsTo332nZoQUK+gey5RVVby8VA0oZCHp3YMQfyxx/XRSgYDsdbUQ
	 wmbxuoNYt1hoA==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2025-11-24
Date: Mon, 24 Nov 2025 17:58:41 -0800
Message-ID: <20251125015841.76180-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,


This is yet another reminder of upcoming DAMON Beer/Coffee/Tea chats
(https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing)
for the week of 2025-11-24.

Yes, Today is 2025-11-24.  I should have sent this reminder last Friday, but I
somehow forgot it.  Sorry about that.  But now is the fastest, so sending this
reminder.

We have two time slots for meetings in the week, as usual.  The one for
Wednesday is already reserved.

On the week of 2025-12-08, I will travel Japan for OSSummit Japan and LPC.
Attending video calls on the time slots during the week will be challenging for
me.  So let's do the chats for the week without the pre-booked time slots, but
as an unlimited and possibly in-person version.  That is, let's make it can
happen at any time and any place (not only Google Meet but also somewhere in
Tokyo, Japan) as long as we can.

If you have any DAMON topic that you want to discuss with me during the week,
send an email to sj@kernel.org saying you have a topic to discuss, with
when/where you want to meet.  Then we can further adjust our schedule.  If you
also attend OSSummit Japan or LPC in person, you are also very welcome to just
reach out to me in person at any time/place without making appointment.  Then,
we can have an instant in-person DAMON Beer/Coffee/Tea chat.

So next time slots including six virtual-only ones are as below.

2025-11-24 (Mon) 18:00 PT (not yet reserved)
2025-11-26 (Wed) 09:30 PT (reserved)
(week of 2025-12-08 is all reserved for virtual and/or in-person chats in
Tokyo, Japan)
2025-12-22 (Mon) 18:00 PT (not yet reserved)
2025-12-24 (Wed) 09:30 PT (not yet reserved)
2026-01-05 (Mon) 18:00 PT (not yet reserved)
2026-01-07 (Wed) 09:30 PT (not yet reserved)

Please reach out to me (sj@kernel.org or whatever) to reserve the
not-yet-reserved time slots for your topics.  The reservation is made in a
First-Come First-Served way, and I will send a Google Meet link to
reservation-confirmed attendees.

Please note that other time slots are also available on demands.

Shared Calendar
---------------

You can get the schedule via this shared Google Calendar:
https://calendar.google.com/calendar/u/0?cid=ZDIwOTA4YTMxNjc2MDQ3NTIyMmUzYTM5ZmQyM2U4NDA0ZGIwZjBiYmJlZGQxNDM0MmY4ZTRjOTE0NjdhZDRiY0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29t

You can also get the past and upcoming schedules via
https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing


Thanks,
SJ
