Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809EE372699;
	Fri, 13 Mar 2026 21:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773438154; cv=none; b=O5sVlYZJGwLLLU8YBETUbixltaZRtBI5luAPyDq9aTy7DlwWqD09cuUzGUrfwflQ7PfTN0L3/WVZqucR7l8Qqfw45VYI3a20bXQk1JTZ5P3OkMtQu2ewqTm6szwTy8W9oeDhcqcnjoHJsy7F3WWZY9wX1FV/oT4w3nLwkotiu3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773438154; c=relaxed/simple;
	bh=mpFwuPeB7aWEz2OJJgracIYRDJUkWSizNiHYzWcBxec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JDFQWDYmofQpHqXQ6x6nH+WEr3jWJm8PCI+kbTsZ9wbsEowJ1tR8D5HWfPTswdVzeFioobobKBbAvc08WQ3GUPnEuAFID6MTJ7GVsxQ3yttZXMm0I4a1DDCeTHRVrqr5h0kOfMmHeMuwkcYCY8Gfdw07iq+zSb1CkorGereiWGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALvhC6pU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALvhC6pU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D03C19421;
	Fri, 13 Mar 2026 21:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773438154;
	bh=mpFwuPeB7aWEz2OJJgracIYRDJUkWSizNiHYzWcBxec=;
	h=From:To:Cc:Subject:Date:From;
	b=ALvhC6pU/XG+nKM0JpP4HwaY8kCrjmlkVSqCYPmpCN/gJFjU2OMZBGamfvXs7XbUB
	 UmRJCCVIWFWA3BdQrW36pElsnXx+edFJu0+dB7hGv/jatR2wE0UrlokemmhZdlDPVM
	 L8VsYkC8L6caWvFafQoUN0PtFJzIT1mEiY+Okq2kVoYCtVYOp3QV6wSukwj13Ivjak
	 hi5I4iLWyK/bgjGPPpDjt1c09BgZ91ClyMbbL5F+fiK0bflTDrs3G49xB3bNWGd+1E
	 mY71hYNY7P5b3iiR7gdBY6oXIRQmUnCfQubdWmA6Bg2ZoXQlM2SmDwZwTK5B2jzZY8
	 8BvBzoBvZklfg==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2026-03-16
Date: Fri, 13 Mar 2026 14:42:31 -0700
Message-ID: <20260313214232.25099-1-sj@kernel.org>
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
for the week of 2026-03-16.

As usual, we have two time slots for meetings in the week.

Next time slots including six virtual-only ones are as below.

2026-03-16 (Mon) 18:00 PT (not yet reserved)
2026-03-18 (Wed) 09:30 PT (not yet reserved)
2026-03-30 (Mon) 18:00 PT (not yet reserved)
2026-04-01 (Wed) 09:30 PT (not yet reserved)
2026-04-13 (Mon) 18:00 PT (not yet reserved)
2026-04-15 (Wed) 09:30 PT (not yet reserved)

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
