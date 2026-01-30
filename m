Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72240358D38;
	Fri, 30 Jan 2026 22:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769813589; cv=none; b=a5LBYMI2RzwJyjIeQBhvglVQ3N7jfD2Hmof7+t68ai2RMpTphrXZEBHV+b4UdTmsmNrDNPyeRyd4FgkemRbzTKz2qDGIbX4D88CWT11rpqzB7Q9Me3ScZNruitr0fmW8p1fDolY9ppQBt/mvh8Ee+BYgkbCh3m+mk98a+XJmrAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769813589; c=relaxed/simple;
	bh=k8GNiLu9t6lAJMzr5pd4SlKRmsP75pqFQ7wO4JB6poA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qQ9WhrtpphtBb8kKSr+hVzxlZzgxQST1kI+oJa8WZId0lyaV+zp2QN5/4lZPLxiYVszxWvSeD2CCq0cWv6yiRODRDBRQq4cu42VEQjdpNuLbGlTu1rTEpOkCHAeL41Z+SGncZal28gznaed0RT/EjtlihowM4seu/Jdh6j2FmfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqlrB4oL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqlrB4oL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1148C4CEF7;
	Fri, 30 Jan 2026 22:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769813589;
	bh=k8GNiLu9t6lAJMzr5pd4SlKRmsP75pqFQ7wO4JB6poA=;
	h=From:To:Cc:Subject:Date:From;
	b=YqlrB4oLJomRX+XETNSkfX02HMmScN9HaJk1KV6EXrcLiQhvC0eezZkFbNEslCyJO
	 KIf3IDXPl83ddjzrtbuW85ZPhzQXNWwrMMESkE9aMPeE7rz4CqKhiFfZfu6ZZg/yzA
	 fiaqOWQsU5y8Pn6OPXqDEcKDJbtOGru2OOwlCvIbFVF0SDam4OzzphNErSPuG7466c
	 y+hNH1M329NhQ22XrmHarSXissz1tK3VTG2cM/MW/8qjEDCfYCyrPxPg65+6sMJriQ
	 6nR4h1ULOXESem90Cu6Q6w1bXDVQ8jMDvYGVU63D8bwXVFtX2RF4fAitooxz8MRGRi
	 N2lis/FnrXKwQ==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2026-02-02
Date: Fri, 30 Jan 2026 14:53:06 -0800
Message-ID: <20260130225307.43208-1-sj@kernel.org>
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
for the week of 2026-02-02.

As usual, we have two time slots for meetings in the week.

Next time slots including six virtual-only ones are as below.

2026-02-02 (Mon) 18:00 PT (not yet reserved)
2026-02-04 (Wed) 09:30 PT (not yet reserved)
2026-02-16 (Mon) 18:00 PT (not yet reserved)
2026-02-18 (Wed) 09:30 PT (not yet reserved)
2026-03-02 (Mon) 18:00 PT (not yet reserved)
2026-03-04 (Wed) 09:30 PT (not yet reserved)

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
