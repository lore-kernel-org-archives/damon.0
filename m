Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90EE1A238F;
	Fri, 26 Sep 2025 22:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758927570; cv=none; b=B7vY4ITqFfnTvMIysekgm8vF2VzB6MOxQ1cfgw9u1j2y37XjsXCGBsWY/lxJdfpNLDlgdgaMzWJXDBKFEdz6PmifrBHisNV/2+kSIYtsoTfTvvrH3740Q+83Y4st24jLLFmEPCtsKu4xk8rQBfX+8s4DeVBwQPfirmkSK6VOKpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758927570; c=relaxed/simple;
	bh=rjsCkNwhw++qeGlROs/n9+axW5Ybamo2ufu46Xoo3tk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=raGGcghfh6P0y74cI7cUN0g1hy5huCI+3N4xUsdelBDCPivrDLfY9g0Bvayc8cKtuar//wnF/1cSihRZDx4037e3ZDCoGG1Udnp7Hop8kNmBfKrYZC2QrbXMwx/igaK2awGlfZRIVOGNmqCijJ4D0sa3TBi0icx/gHkL6zm4mPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/pXmYkN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/pXmYkN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F5DC4CEF4;
	Fri, 26 Sep 2025 22:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758927570;
	bh=rjsCkNwhw++qeGlROs/n9+axW5Ybamo2ufu46Xoo3tk=;
	h=From:To:Cc:Subject:Date:From;
	b=h/pXmYkNhdrajnD3SIofJqZXEbNTdA+N9Bw3cEOaqfcHUcpqsPhh5iboRm6jA2WU6
	 6Zv8YsJDYl7Y911cTBV2g7/o5x7saXHu/dtRZN8fvCPrD9RIBVwDQwslun3bZSqaZF
	 8SE31PHvB0WomMbvDYxPUmTcUU5Su4tCxcpwtlyTz2aZsq7Pukfj/QE1e9e99Csk5N
	 eC4k03QQtmSTRfejjedzRFXnEWhkc18vEJ5c+6elMamGEEcZTv8D0HmA5BvrAZF2Zt
	 Dc+iMNE2NiVg7np0U8nB8+G+usBHRNepqV6X+UB3nyB3ErSLnO4AWauFcdGHz5p4ZI
	 f21LZ2EImzVkA==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2025-09-29
Date: Fri, 26 Sep 2025 15:59:27 -0700
Message-Id: <20250926225927.56743-1-sj@kernel.org>
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
for the week of 2025-09-29.

We have two time slots for meetings in the week, as usual.

Next six time slots are as below.

2025-09-29 (Mon) 18:00 PT (not yet reserved)
2025-10-01 (Wed) 09:30 PT (not yet reserved)
2025-10-13 (Mon) 18:00 PT (not yet reserved)
2025-10-15 (Wed) 09:30 PT (not yet reserved)
2025-10-27 (Mon) 18:00 PT (not yet reserved)
2025-10-29 (Wed) 09:30 PT (not yet reserved)

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
