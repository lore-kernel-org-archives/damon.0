Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09012E65D;
	Fri, 19 Dec 2025 23:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766186546; cv=none; b=maQCTDg6b6OMT+YeukGLwOv8jb3Syfki6UF0ywcUYxwDTtKzGdw1rHfdxunqnv0adI+udREGLRZ5nYCVunaJKYtWp+HOmQX2B04AudPTyV/YDnjwbR6IjmwmsGSrZwLs8WV3b/YgUJlta6FfdYDtQQzQZvcbbbJn1maV5sdIqRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766186546; c=relaxed/simple;
	bh=Xyp7hdCasBObPpRV++A/ph59ZovCA3G04WmnXF7cUeo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q5fwkqZu0t6/v4xbhOL85j1nTx+VhTQd6jqg2jnc6t4OdX/Xmr87r6z7izy7xOsydmfiEI6FA1wLP62H/bjTSTPEHJaTUP1J0cNBrWQcSw8xjLK/Yp1r5e/kSUT2D04jS7MjJFx0bZC4CYw8V0jZZ1OGp51AtyuAGelWrFPUZs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOMplN2n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOMplN2n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90EEC4CEF1;
	Fri, 19 Dec 2025 23:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766186545;
	bh=Xyp7hdCasBObPpRV++A/ph59ZovCA3G04WmnXF7cUeo=;
	h=From:To:Cc:Subject:Date:From;
	b=eOMplN2nRk0XGZ92izM2nlZHQOBLXubGCRgUnXQXCFtlUNw2O9n0E9C8fRWoIpaes
	 DA+AEJgU20yGmRth4gMeUqhtyQJpRB0Fvpm6QvjAcOvqIXXjMCkyNCiSTUHdShTWM4
	 ESOoe15nMpWhNERibRBY3D/XSrTNmuKkFhrVJYoLd5F9raoaigxJls6kVe2ta7mD/k
	 IWWRq3BzemVedOI/BHRnP/uCDmITSni153yJhfFvLfi8T4Xw0t19bT9OCy+1ljp8kI
	 uSLi4JjwQQVmEk7QmeEi2dqMgP2HgaCm3nK8aKPAhNcoQSYyPsdLNbqWnsAxGShn6E
	 GxMs4R8MM3YLg==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2025-12-22
Date: Fri, 19 Dec 2025 15:22:19 -0800
Message-ID: <20251219232219.41792-1-sj@kernel.org>
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
for the week of 2025-12-22.

As usual, we have two time slots for meetings in the week.  Both slots are not
yet reserved.

Next time slots including six virtual-only ones are as below.

2025-12-22 (Mon) 18:00 PT (not yet reserved)
2025-12-24 (Wed) 09:30 PT (not yet reserved)
2026-01-05 (Mon) 18:00 PT (not yet reserved)
2026-01-07 (Wed) 09:30 PT (not yet reserved)
2026-01-19 (Mon) 18:00 PT (not yet reserved)
2026-01-21 (Wed) 09:30 PT (not yet reserved)

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
