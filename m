Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18283A1E99;
	Fri,  2 Jan 2026 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767390986; cv=none; b=nDzXu3szZA+RVD7GPhHbC1kqeMPhX5St2QNXgY4dwtQw90HYgXZM0ZQN2O9esEp4dNoG4D8rvbtV3ceOSnf1siWBA94HrXjvC5xTBn47f0IpwrHPsMvcjRo4t13GQ+eR466ULQG4pH6bETdEFzif6TPzN2jlWC+eRiRFMPAOmTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767390986; c=relaxed/simple;
	bh=zppH1GSQx/tNdznTh//Ks2re2fvotGy+Qeog1ZBigx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LXr3bmCWQsc0P6zEVV4CH3Eg0dOWxz7wWgzRHD4sfUC6Ofyf4nAP6DkMNTfBpb1kRlterUzJU+6uFYM8tRUUp5val2OfPv4doW/N/ecQS48Ut9s3HMbtmdPt3I/XWrSqcdQfrjl+9XpUM8+zLdqLvM8/Jgr75suVLajCn3aCs/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHhTDL/u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHhTDL/u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA28C116B1;
	Fri,  2 Jan 2026 21:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767390986;
	bh=zppH1GSQx/tNdznTh//Ks2re2fvotGy+Qeog1ZBigx8=;
	h=From:To:Cc:Subject:Date:From;
	b=YHhTDL/uzpc346i3hxHanQxC60ihe97sWe8b+0kXUvmpHTKPC8Wk1XxjFU1v5rVAg
	 43upO40P6MatG3NYTtPsDsH+VX4nDKkiola9pjGLvYPK/3zGv5/SFiHR6FrGd14IJ7
	 nl9DTCW8C+xcfd+U4CgOBXtylnMmLkrgg3OTOZhJPCF9+QYontU7HyHwRz6vQh1Wlb
	 auGm55oARBPbdJT8N9C9wStwq5+Snl09FYJ0q3akE8k6rXvwc6Yh7HsFwDuYcQ/rAD
	 JxNtrTuuxdeJ+siItPHn/PS6+Ir6wvJxwTo1uogvR/qWSxQKDNcv0zPOoZtjlZEtAZ
	 yRBvgC0d85g6A==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2026-01-05
Date: Fri,  2 Jan 2026 13:56:21 -0800
Message-ID: <20260102215623.41110-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Happy new year, DAMON community!


This is yet another reminder of upcoming DAMON Beer/Coffee/Tea chats
(https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing)
for the week of 2026-01-05.

As usual, we have two time slots for meetings in the week.  Both slots are not
yet reserved.

Next time slots including six virtual-only ones are as below.

2026-01-05 (Mon) 18:00 PT (not yet reserved)
2026-01-07 (Wed) 09:30 PT (not yet reserved)
2026-01-19 (Mon) 18:00 PT (not yet reserved)
2026-01-21 (Wed) 09:30 PT (not yet reserved)
2026-02-02 (Mon) 18:00 PT (not yet reserved)
2026-02-04 (Wed) 09:30 PT (not yet reserved)

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
