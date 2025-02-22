Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20D1250EC;
	Sat, 22 Feb 2025 02:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740189864; cv=none; b=QScCGqTk78bEHtdWtuP7wq9jQNQ+lRxOvIG2U4oE6OUbhxoQq4NY8DHZzsE7Qaev+/thUqlyJGajM+elYDVnv0uI14UIeiLeFZsGPj3V6sdw9VzPvMnKbix784bPhwWJXCeaS789RHieX3nFxSqyCRDd9eqQ+S+4+Wo4OWy5AWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740189864; c=relaxed/simple;
	bh=jo0VRODJgwxyyHe3xRet+qax7sBY/v9n15Rkhe5i3uI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aplEfzhzieXN6X9iB1pKi+u8E9vBw9sYv+HNmdiD1/jU9xe5ybOmk4szOfHKTm9oNCa648qVY3QQYlCUoR7j64ntTVQDNESa7ItzkqLszqe7QGKkI4iNZ1N4gyqA10UndhYEiy9qs1USdX9/C463PBbWvyExS1K63toVpcDrse4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqbadvT3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqbadvT3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69CF2C4CED6;
	Sat, 22 Feb 2025 02:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740189864;
	bh=jo0VRODJgwxyyHe3xRet+qax7sBY/v9n15Rkhe5i3uI=;
	h=From:To:Cc:Subject:Date:From;
	b=kqbadvT3ShYFCyy1ys35WiTOWyJB/Fwa4/x4oKxhjGNrxRzTNXIacLKkwdBwHZjI0
	 hLiHpSWLp7FPgLQwrgFprrqu+SE+ejdKO+P2j9aX+R9NRH6+dOLr0DL2pbliEsiSuc
	 y+ZgJ+aXZwEZ2hzx8oX7OUkTIbApNciPn9Y1aL7dnw8cjbk1eqaBgA69EerGse9gLQ
	 LO9t/W4e+0UzSYWGKHjbjdSPhbg1spPwI76LDiwck6j4K6Z+bPLUAMLsa6Moo0Tmy5
	 W0QmvEuYRSYkymRWckeB1iHb5B5nUvgXEH+M3p+IYeAhLQk3KISwutg93Ey+CNNonk
	 k3r/1ep8k3+0A==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2025-02-24
Date: Fri, 21 Feb 2025 18:04:21 -0800
Message-Id: <20250222020421.2211-1-sj@kernel.org>
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
for the week of 2025-02-24.

We will have the two meetings in the week as usual.  According to our schedule,
we would have meetings on the week of 2025-03-24.  Since it conflicts with
LSFMM, I'm moving the meetings and later ones one week.

Any-topic discussions
---------------------

Next three time slots for any topic (no reservation is required) are scheduled
as below:

- 2025-02-26 (Wed) 09:30 PT (https://meet.google.com/ndx-evoc-gbu)
- 2025-03-10 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)
- 2025-04-02 (Wed) 09:30 PT (https://meet.google.com/ndx-evoc-gbu)

Dedicated-topic discussions
---------------------------

Next three time slots that I reserved in advance for possible future dedicated
topic discussions are as below.

- 2025-02-24 (Mon) 18:00 PT (not yet reserved)
- 2025-03-12 (Wed) 09:30 PT (not yet reserved)
- 2025-03-31 (Mon) 18:00 PT (not yet reserved)

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
