Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A62B126C03;
	Fri, 27 Mar 2026 21:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774648107; cv=none; b=r1MkeRcPEhnTJ4WZQ8DRIQLpvEp1YDT9H52u0bc4lLfRwH61d1owUa9KzIbWBQrBzraTtyFk8i2BgCxywmL3FrwNBsl8jBz5gHs5kQkKQViMGohZBoSXFlXSWhwBkdc/6WAE6jdaxDUN3f34jK91wrollHlqFZ1tRcyu3yLkF60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774648107; c=relaxed/simple;
	bh=tl8ay2C3Huakf+fLV5XDI+09dex+dvgCSeY25OXupTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Byngm91rd2HAZicOnBfYaY3EXRaO3y107iGqKRCm4kdjKCf4dno9zOwP0MQh37Un6r7GuLqf3PvEVz4OFgWPs/u6EOBfYB8ZyRLccQ9V09n5/2TsC851GfLR87Otdl3eQil++z5omH/yaX/ANpbGYjzk/IxNEdmpI9vSmaj27HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpGqXMJ9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpGqXMJ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295E2C19423;
	Fri, 27 Mar 2026 21:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774648107;
	bh=tl8ay2C3Huakf+fLV5XDI+09dex+dvgCSeY25OXupTY=;
	h=From:To:Cc:Subject:Date:From;
	b=cpGqXMJ9hVBR/s9gCI/TH2aTuFd27PBHLMKF3xc9XOSKNCBFc614wOgXZLVgwwNiB
	 QdyAOG0WBYW7j8c2O+9Mj/XcJF+jbBGuT/CK6B6hEjTv/mZ3nzntvLun0d3+G70/U+
	 2j3l2BG0jMzziXyDHobDGWJPTl3bWDWea+BpMq60C0C1wekvUUORcIflKQ1t9fFq/R
	 tqjqXr8Qg074b+qNVi4iuLTMQ4q9MMXPmGil6D87Dt0f8Bs6/kkYKIUYcHhgZur+uT
	 sdb8OxMILU0Dhxi9HNt08U8/395wThoeynsJoQCcZxrZjz0VoAD0C1bCln+ZYd0p2u
	 N3u3JnnzeeqTg==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2026-03-30
Date: Fri, 27 Mar 2026 14:48:25 -0700
Message-ID: <20260327214825.8212-1-sj@kernel.org>
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
for the week of 2026-03-30.

As usual, we have two time slots for meetings in the week.

Next time slots including six virtual-only ones are as below.

2026-03-30 (Mon) 18:00 PT (not yet reserved)
2026-04-01 (Wed) 09:30 PT (not yet reserved)
2026-04-13 (Mon) 18:00 PT (not yet reserved)
2026-04-15 (Wed) 09:30 PT (not yet reserved)
2026-04-27 (Mon) 18:00 PT (not yet reserved)
2026-04-29 (Wed) 09:30 PT (not yet reserved)

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
