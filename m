Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B033112AD;
	Sat, 11 Apr 2026 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775927364; cv=none; b=ZJ2oKMKWgXP9IQiXfzB+aWRVREhZCr1RRURPuOSWng/aM09mWhJyMtTfN2je5UlY0J3CxnD6VpbUAU1XyWgyOm2mjp66JiqQ3mZREgJun5xw0F5pgiIHK25gTCzVRQKONX9TBSc+WPsEm8qyU+7/3Y/LsNYyLoaOy987PpVkhbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775927364; c=relaxed/simple;
	bh=mLWm1A+kvhVK3/mJ79ySU/3Nw9GXZUDws6e5yDbdgRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ps5S9hb0unG36QFPCrKnQ6tV0lmhwRI/5+k1Luxz4CunVnaeA68+d97ab2ldc/YtchLDK95t3TGxdj9/nQTqRaFMRk+SP8zViHR4xk+dQ9dsO4N8d7o8eVzNRzdREiCOlwApnZVG/Zc10esH2XSMWQVe0EKWPludPfYawz7jiYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beC/cCPW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beC/cCPW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB279C4CEF7;
	Sat, 11 Apr 2026 17:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775927364;
	bh=mLWm1A+kvhVK3/mJ79ySU/3Nw9GXZUDws6e5yDbdgRc=;
	h=From:To:Cc:Subject:Date:From;
	b=beC/cCPWhkNYz93kjx9/TRl/QFtINiIfjh3GBnQY9pWolAOurYaFLGoNIAfCIyEz0
	 zaQwaZTTi6BuQLLy4nZ76zf3JQ8P/xoupNdVmthgsSpZrq7COYAuI4R1ISnEWnRI8Q
	 VaAOhNJ7+mlFnLNErf2/uteH96WwJCwf6wYXJh8oitec3Vbh3NLtVKN0YdPYwNvn2i
	 z/a+5E9St3KJPI21WRbid8ZwYQbWHHBL76AskZ8UCgl0h1Oj4l3ZUwMp/4P7YNue1U
	 qo8pfARl7n+pa+01g4i5bLS7PYPUh/SevjWUo9Hw0fN43kSc0fiijvtVUWdYnNJPgu
	 V2/J+k7t6GEkw==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2026-03-30
Date: Sat, 11 Apr 2026 10:09:20 -0700
Message-ID: <20260411170920.77900-1-sj@kernel.org>
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
for the week of 2026-04-13.

As usual, we have two time slots for meetings in the week.

Next time slots including six virtual-only ones are as below.

2026-04-13 (Mon) 18:00 PT (not yet reserved)
2026-04-15 (Wed) 09:30 PT (not yet reserved)
2026-04-27 (Mon) 18:00 PT (not yet reserved)
2026-04-29 (Wed) 09:30 PT (not yet reserved)
2026-05-11 (Mon) 18:00 PT (not yet reserved)
2026-05-13 (Wed) 09:30 PT (not yet reserved)

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
