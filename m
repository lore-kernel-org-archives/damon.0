Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307632147F9;
	Fri,  1 Aug 2025 21:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754082106; cv=none; b=JwBF5LRl3OJc/C9MmmOacH5hUeW/odGkdBigpEcwqicMFhuXQDhzghudmqLgaOEfgq6wlAki+I4mfCOn6xMlykOnS9jY1HqSMSVCfkVEwMDnltAv7wUu4HmC2ObyT+tn4pt8W7j5bN35GZPjjxwI8rrU3347vNURaUYDmnl2V8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754082106; c=relaxed/simple;
	bh=eYn24Df2DPfktFg3q3iAncFfxzsR6pbSbJtejQ6BcTA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RBP57a0FCx5/4pD2TtS/aaaHvVyf5ZgGmEJOJOxqtvMm9kZu/Niu5YXWCH+KV4VfthISkiuPFXaZGL7/tKYwCXz7NwDMiRNLRvMJ4C4D6qygqGKEUx3jCaycEYQhDBMIb3QlQvVY/qCFSpQaz/rBMQbIzv9ZROKbllNUkWPg7+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntW0V/Mk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntW0V/Mk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D950C4CEE7;
	Fri,  1 Aug 2025 21:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754082105;
	bh=eYn24Df2DPfktFg3q3iAncFfxzsR6pbSbJtejQ6BcTA=;
	h=From:To:Cc:Subject:Date:From;
	b=ntW0V/Mke++hBis9S+ymDYqKcsySZKDRLd8xnQmQkmZhZjdpADMWV2hutrQmSN0OC
	 UKEGoz2lRSOLo74exG2gSDM9SSeDcF5vt7iu/FUbnKfWMmvhfOOUclUzgw0UjM6oUr
	 en5SzkaEt2FPUlhTZQZFK1VpP2Dl4QNc0mJTOcZruiR55ACtyf3WP8ttlxJZntmQL+
	 HlZpoo2/ZLk4DKeTKfd1TCVMjFpdwLkgW9KS1OKtIL9gpeRooV66B8ZWRo93RcoQv3
	 gKOhYWNYPP3qY8036i+yrxyIjggotyzu50Kl2lgFXIW6VXny+2+U3RWBxiYx/qm3jh
	 xXaZA9w1DXa8A==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2025-08-04
Date: Fri,  1 Aug 2025 14:01:42 -0700
Message-Id: <20250801210142.1858-1-sj@kernel.org>
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
for the week of 2025-08-04.

We have two reserved time slots for meetings in the week, as usual.

I will skip those for weeks of 2025-09-01 and 2025-09-15 since I will have a
travel during the time.  Feel free to reach out in any way as usual, though!

Next six time slots that I reserved in advance are as below.

2025-08-04 (Mon) 18:00 PT (not yet reserved)
2025-08-06 (Wed) 09:30 PT (not yet reserved)
2025-08-18 (Mon) 18:00 PT (not yet reserved)
2025-08-20 (Wed) 09:30 PT (not yet reserved)
2025-09-29 (Mon) 18:00 PT (not yet reserved)
2025-10-01 (Wed) 09:30 PT (not yet reserved)

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
