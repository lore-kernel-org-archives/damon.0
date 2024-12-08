Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662D728691;
	Sun,  8 Dec 2024 22:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733698641; cv=none; b=nSNoLSOxBU6eax6/yEir0TaWFcSdxDkrZNSSEG+V5U363xC+igixylDQgXO+mHD7Jnx8iQQqFhaADNz1yQXGJ91pe5OArr+96AUXzWIWJahyRV78/ZCIiLm+h5f6x2mCc1tFnmG7rWEdbspHleUS+2aeUFwUepZNRJs1ak/kVJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733698641; c=relaxed/simple;
	bh=l4I4Gok+4VIH9ppFZu2jNUclDr+5D3sSBG5ER+a5Xac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HeYXzNAxdI9a6bQTktqLMij2sGb/Z/ODy1lIfYge93XnY3mBtbCWvqgFxhENRYPjmjH51UnsaNmXGYRwEhH+GJRVsZSiMr8zDm3PQmFAX0yCoebFTfNs06DilBDRVt/OxujDsSg96pbRETcmMSpz+PkIDEhxyIOe8dWOEdsh6Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlPNvqbn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlPNvqbn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B3FC4CED2;
	Sun,  8 Dec 2024 22:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733698640;
	bh=l4I4Gok+4VIH9ppFZu2jNUclDr+5D3sSBG5ER+a5Xac=;
	h=From:To:Cc:Subject:Date:From;
	b=tlPNvqbnxfwKz8OYKqDMwSYWtrqe7A15YwID3UOHAWlORlQollScl6cu2PqprdBG0
	 f7riPhM547/ju2E0bpA/Iy8AC/WAirSgMNXztqAv+Pr6Pr/Uy1R39hyXAT/z9c5Y0v
	 b2uV1Z/Q8nmgNrnN7Wj0byiMIayiXI8fPvgw2OyzoMN3J9ZgxrfEKNbbdaRntnUh5x
	 0+JUhHzVziL8gGdQzjdsGZXKkgI1nRUBUnRm7ro2hTp0Aw2+aUMXuZwE+NJ6mV5HQo
	 S1K+0eK91CbQvwJwQ3UBwkJrQKXG/OGbf6yZE8xRzZxDyhfEkh+wT2Yq0+PgIeXrCS
	 MeR6i6yf1O9Ow==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2024-12-09
Date: Sun,  8 Dec 2024 14:57:17 -0800
Message-Id: <20241208225717.1080-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
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
for the week of 2024-12-09.

We will have a registration-based meeting on Monday, and fully open meeting on
Wednesday.  Those were initially scheduled to be held in week of 2024-12-02,
but we moved it due to conflicts.  So we will have the two meetings in week of
2024-12-16, too.

According to the bi-weekly schedule, we will also have the meetings on the week
of 2024-12-30.  Since it is the mid of the holidays, I will just cancel those.
Please feel free to schedule a meeting with me if you have any topic you wanted
to discuss on the week.  Beer/Coffee/Tea chat is just a time slot that I
reserve for convenient schedules, not only place to discuss something about
DAMON.  Of course, mail or whatever is also ok :)

Dedicated-topic discussions
---------------------------

Next three time slots that I reserved in advance for possible future dedicated
topic discussions are as below.

- 2024-12-09 (Mon) 18:00 PT (not yet reserved)
- 2024-12-18 (Wed) 09:30 PT (not yet reserved)
- 2025-01-15 (Wed) 09:30 PT (not yet reserved)

Please reach out to me (sj@kernel.org or whatever) to reserve the
not-yet-reserved time slots for your topics.  The reservation is made in a
First-Come First-Served way, and I will send a Google Meet link to
reservation-confirmed attendees.

Please note that other time slots are also available based on the demands.

Any-topic discussions
---------------------

Next three time slots for any topic (no reservation is required) are scheduled
as below:

- 2024-12-11 (Wed) 09:30 PT (https://meet.google.com/ndx-evoc-gbu)
- 2024-12-16 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)
- 2025-01-13 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)

Shared Calendar
---------------

You can get the schedule via this shared Google Calendar:
https://calendar.google.com/calendar/u/0?cid=ZDIwOTA4YTMxNjc2MDQ3NTIyMmUzYTM5ZmQyM2U4NDA0ZGIwZjBiYmJlZGQxNDM0MmY4ZTRjOTE0NjdhZDRiY0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29t

You can also get the past and upcoming schedules via
https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing


Thanks,
SJ
