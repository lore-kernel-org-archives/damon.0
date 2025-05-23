Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0634A19CC28;
	Fri, 23 May 2025 22:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748040779; cv=none; b=LffRytHk/I7SXh96l1zAUru4vzSztM275OBsphjDtIo7tuUXkOuG0+ZUxagvSAnwOubMn1o4EW625Xag621XQ0DgB9lpotzrwTb8Vc8s3b8nt/FO4P0FvhoGzqVC6VlacTm7qz3+1iVYLR3fWRWJZVDHvIppnzhpv/WgV9KBkXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748040779; c=relaxed/simple;
	bh=TPjZsVlVpdXHEyq5xNoasr7Pc4qYd9yTXNszwtKPqIE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CdbhJJk5CXuhEkFLFtcXI0Ah0MJFapVpzYoMWGRDRaOsUNIXkSwwbyaxafuqE5su+WUydcDnC007NkeUt0bec5zQ8DReCHiBvdio+v8W1LncEHt88pY8nm8rr1kBUXrSd+6zL9mnwfwgeCUYF3EAs8kRj7zreNmAnOM4gZzA//s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrkMZNuM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrkMZNuM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4971AC4CEE9;
	Fri, 23 May 2025 22:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748040778;
	bh=TPjZsVlVpdXHEyq5xNoasr7Pc4qYd9yTXNszwtKPqIE=;
	h=From:To:Cc:Subject:Date:From;
	b=ZrkMZNuMPdV6lk7sreYzF1NvkbgT8NGiRcdKV57ZSvjf5se3gWjbKat+AtuwXhr21
	 hpxEeEo+MSHsNgfobc0ld3NG6nWBCqCK9yX5UKMNy17H3QfRP+Jd4lJpWC6qvXESha
	 II5gtGA9M7FOdjOlsJAqA/IG+BZ6nbhq6iApFV+vvOM46rwsgKtTu2q5TzfwGmYGd3
	 do/odvnk8lKSJCcPFy8PQP8keaZqzNEjmholYhcAVeEFrxP0DCgN3brayqglHM0yj0
	 KnywH4vYgSBCO+a7AGXYooXqVFU3MYOAAC4Yq1IGtpaIos2aWJMyAWdMWPYLnSa9Kh
	 7ar795EpEXanw==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2025-05-12
Date: Fri, 23 May 2025 15:52:55 -0700
Message-Id: <20250523225255.61464-1-sj@kernel.org>
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
for the week of 2025-05-28.

Next Monday is a holiday in US, so I'm moving the meeting of the day to
Tuesday.

Nowadays people usually use only dedicated-topic (registration-required)
discussions.  Any-topic discussion was rather turned out to be difficult to
discuss on given topics.  Hence I'm gonna merge the any-topic discussions into
dedicated-topic discussions, after already scheduled any-topic discussions are
done.  Of course nothing is set in stone.  If you don't like this change or
have a suggestion, please let me know.

Any-topic discussions
---------------------

Next two time slots for any topic (no reservation is required) are scheduled
as below:

- 2025-05-28 (Wed) 09:30 PT (https://meet.google.com/ndx-evoc-gbu)
- 2025-06-09 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)

After 2025-06-09, no more any-topic discussions will be scheduled unless
someone requests.

Dedicated-topic discussions
---------------------------

Next four time slots that I reserved in advance for possible future dedicated
topic discussions are as below.

- 2025-05-27 (Tue) 18:00 PT (not yet reserved)
- 2025-06-11 (Wed) 09:30 PT (not yet reserved)
- 2025-06-23 (Mon) 18:00 PT (not yet reserved)
- 2025-06-25 (Wed) 09:30 PT (not yet reserved)

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
