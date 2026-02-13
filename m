Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A3C1F0994;
	Fri, 13 Feb 2026 23:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771025888; cv=none; b=WmB34JelqWihH5X9u8ilRvkr6IsvGoyWVENj3mOLp3n8e55+0sqrfuXJk9Q7eQI9vuWZKinz9XuYDNIiu2Ak8B3ENNHk1yEXKr1rNa9lDZblhBUxZDGLC2BKkb169I8BWOGcYVyN3f1fkvC7qI/ESbaETgKLkC/UKsyoQ0Uhcmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771025888; c=relaxed/simple;
	bh=CpF3TGy6lubjr9awkXLTeq4aj0LPX2b/2Yx/UJuhsK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hl/sF7IHQgCuw6RWRbGW69ZuaO7M1Sd0auAiX4k31KEt/3vWVuUKP4rxIQffc31YIOv4x4LZ8kxoXgwMR2LGgYCQ/C5g79U8CQbV4gOtNfF3LuutJOtBqvCv6Rp2jZBS7cvp6N3LzFnG+0UkyOtZ67LkoZ0njgYoRdrGpH2lRvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISOikdQ8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISOikdQ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4945C116C6;
	Fri, 13 Feb 2026 23:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771025888;
	bh=CpF3TGy6lubjr9awkXLTeq4aj0LPX2b/2Yx/UJuhsK0=;
	h=From:To:Cc:Subject:Date:From;
	b=ISOikdQ88tJxqrgnLbczK8XQmzR26o/3NJwuu4TYd7el6YEkms5Q37nK7GFa4XwnM
	 pTRiTR0lICJC53jgPf3sbADYS7uhiXze1pvgiuQT53DPA/t9DTVe+VJEteycEyqPNV
	 d0NxMGPZfVdkUzpxlLBudqtdl8Bbj/jtu8Lin6thphs0uai3LTtymEafbbd8HvDdds
	 DFkXg7tw8Zbqaplbrsn63mE5RrBt4JakLcpKzDbysq+M/wP0l9spXd/nQgCkHL3WsC
	 0R5UY/BwSOdE6WK6FI1NgxP5EFcc+av5BM0X2TdhRftaCEdvKRxq3LDQfCuE0dXcSY
	 OUTnI4umL6ZQA==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2026-02-16
Date: Fri, 13 Feb 2026 15:38:03 -0800
Message-ID: <20260213233804.62895-1-sj@kernel.org>
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
for the week of 2026-02-16.

As usual, we have two time slots for meetings in the week.

Next time slots including six virtual-only ones are as below.

2026-02-16 (Mon) 18:00 PT (not yet reserved)
2026-02-18 (Wed) 09:30 PT (not yet reserved)
2026-03-02 (Mon) 18:00 PT (not yet reserved)
2026-03-04 (Wed) 09:30 PT (not yet reserved)
2026-03-16 (Mon) 18:00 PT (not yet reserved)
2026-03-18 (Wed) 09:30 PT (not yet reserved)

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
