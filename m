Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26451799F;
	Fri, 18 Jul 2025 22:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752879552; cv=none; b=Fag0Lzcb3tjeQISiaRmCeR0FcVeYgMjpT3IBQfwfrJagrPTNg8gaqmYZCxAxajsJ5qKB5oE1SgTpgKjaN9cD9Gl/RUDRo4fkJhwmvKtqdWXc4Bm8qEjj5mMXbjWtuN3pNUNlxO7E4oYMF80vtF4KBXdE5bys+8w3B8bkXSh3t/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752879552; c=relaxed/simple;
	bh=EDbN0WfkGIaoc4lHbkm30KyYBssG6L4rI2PtB4WQ4BY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QRigvDJggITDEQq6qznWm07h05D8vPd/d2erIw4BZCFR/yy+W3QXexlja8qXdX5xKSziIooBCdKUxyHo/WNrfLv8pqN/OtCcmd1F4x30w8NCbm09PeWA0Bmtf4S44gRbx6+mcAV+N73PInzBFt9JULXFKN6v3cjKA4a3w5y+trU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLspo3z7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLspo3z7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BED9C4CEEB;
	Fri, 18 Jul 2025 22:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752879552;
	bh=EDbN0WfkGIaoc4lHbkm30KyYBssG6L4rI2PtB4WQ4BY=;
	h=From:To:Cc:Subject:Date:From;
	b=PLspo3z7n4Db4hpe53mkuTlVpXgw6SSJ0fLbjv1uTaE7ctAPuh1dOD5lrHHUtuVG1
	 bkEXH7xFXyazhHoXTlbdeq4sAWaVMrUNTT55/AW7TjKQaYsFUvW8t8RuuA3EP81/cX
	 Rb9TatRfVu9HcvKWORmS+CnS09Pt1gItQdnq310kxdKc1Qfyp48hKJekmU7rVJqXbk
	 9fOvQbqvFLUiVphKumH3b8iS5u8zDPbyHubcE7oHZC/4Za73QgXnh1MweVJbf1Np/u
	 z18SdG9AbYraar5N9wqosxO0/nwisRcn8uZfBLATtqpdgcwEl2ANLffxtVtTZEBydY
	 RqF80I8QPrTnQ==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2025-07-21
Date: Fri, 18 Jul 2025 15:59:10 -0700
Message-Id: <20250718225910.64167-1-sj@kernel.org>
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
for the week of 2025-07-21.

We have two reserved time slots for meetings in the week, as usual.

Next six time slots that I reserved in advance are as below.

2025-07-21 (Mon) 18:00 PT (not yet reserved)
2025-07-23 (Wed) 09:30 PT (not yet reserved)
2025-08-04 (Mon) 18:00 PT (not yet reserved)
2025-08-06 (Wed) 09:30 PT (not yet reserved)
2025-08-18 (Mon) 18:00 PT (not yet reserved)
2025-08-20 (Wed) 09:30 PT (not yet reserved)

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
