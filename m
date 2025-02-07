Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3685642069;
	Fri,  7 Feb 2025 22:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738965734; cv=none; b=N571KOAGHJmvZ60qBIXDfg+U2UCmIGkMEiuTI76Pp8LYCPmdn1x+dQ1kJiLMbtCUe/pQsynLnFrWz/ACQ/FlPJ2qtdvoz4wty2AFajgBcuJIiP2dcNunZjAW0ePTwmVm++CtERAy5YuSOb7Sk3WEUoVgqJJewwTwaG8xQNJ5cJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738965734; c=relaxed/simple;
	bh=n6ZD6l7XI6hRa+Q+z/5+617dISpHOlUMQKHaC43F/CE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hkD4oJfDiXiV6UrdiiGUVBjT8sMQ7zzGPJdIcTy+eYMpsUCVhe6YXXwXmF84CZrgf7gKyQGlEE0HcjqgJgpqElrSe0pOIz4YQdCKAKBEX1ejvLR9O3KSyuiItDZrqE3ff2wTOTCC/JNeo/I2hAqX46mmRvDYEvvVpztVHl1Ci6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kusyv6WJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kusyv6WJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC8FC4CED1;
	Fri,  7 Feb 2025 22:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738965734;
	bh=n6ZD6l7XI6hRa+Q+z/5+617dISpHOlUMQKHaC43F/CE=;
	h=From:To:Cc:Subject:Date:From;
	b=kusyv6WJvA1OqDdMimapUaxoTL/taTGALPPaZGF5T4XM9J5aRcbdgUebBp0Wvd0RX
	 8XGmfqg9Zsq6T3Yhytf92oXhV45ccWM+uidUy6l9JKEjfbladY65Qq9j2TQ+a5SJl6
	 wQqb38/5R4FNzXg63d5DgDYeaU5Zhu5HjlYz8zffsHRzDiWxeFTh4Lc8xxdhsZj64S
	 I+ncK8/gQH6yaddDnY0JL26OA25YhqqgHZN6dFQjxi+4oWLO2tIb4dnNj1IiEu1l9U
	 PF6gVdBGwS0OVM4lvGAZkHsI8kTaht3jyBF+YtTY8zDf3AkugqDXZOYkTgbixOc75Z
	 EZKM5N66z/LDA==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2025-01-27
Date: Fri,  7 Feb 2025 14:02:10 -0800
Message-Id: <20250207220210.45603-1-sj@kernel.org>
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
for the week of 2025-02-10.

We will have the two meetings in the week as usual.

Any-topic discussions
---------------------

Next three time slots for any topic (no reservation is required) are scheduled
as below:

- 2025-02-10 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)
- 2025-02-26 (Wed) 09:30 PT (https://meet.google.com/ndx-evoc-gbu)
- 2025-03-10 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)

Dedicated-topic discussions
---------------------------

Next three time slots that I reserved in advance for possible future dedicated
topic discussions are as below.

- 2025-02-12 (Wed) 09:30 PT (not yet reserved)
- 2025-02-24 (Mon) 18:00 PT (not yet reserved)
- 2025-03-12 (Wed) 09:30 PT (not yet reserved)

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
