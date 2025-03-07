Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A64924113D;
	Fri,  7 Mar 2025 21:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741384381; cv=none; b=Lf6RB/BPGhBxiqbcTC88I4NwvTa0cUOlwAi2vNZyni36WPkCrHN8yncDi3iWqWxq3sUEpfKlz9D2hK7UdoMr/wiX/X3EZv0P/laI9i/Vv4FLvGnXW0wQDiiY0+MQa8euokS3Zu6mMSm5BcIU+eokYGdQxSq3+yZsun5j0+C0ud4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741384381; c=relaxed/simple;
	bh=7dSg+utetCMtnZA9XVH4esLJehzZUUrlDj3DsF4lJLY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sQrtE1+mRUGk4Ez6/tDk3jBrTvzVzGjaSNjlofd7fDnUc10OIg8OBUOuNplqIo/iUaa2OjCXLw4y+HM5gIUKBsaqQ7hrTB1/lAj+57LyX5AIphPn/PrgKt/dktoT5KtJZHcBepOEipK3U/kZfu4n4YTEYkrQhVxMMuXeADdmi6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFmzQJiq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFmzQJiq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7333C4CED1;
	Fri,  7 Mar 2025 21:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741384380;
	bh=7dSg+utetCMtnZA9XVH4esLJehzZUUrlDj3DsF4lJLY=;
	h=From:To:Cc:Subject:Date:From;
	b=rFmzQJiqWhLogcu6MOGxgwABpUShFhNgvs57GuqnnkxlnKE8xgrawbDrEXvWM4vqM
	 xOBB+/24OmgJNKpVPPaF4KpOoS9v5oMN+q2A8X42CGJkLl9XZyqitNPz6X+F1R+rry
	 +oYJiJMQSG8Q/r7TyBOXWenNTpiirivPG6PmV2vgE6akhncgHNoTutpjTVyYMXff8n
	 WSK6vQQgBVbPBLkd8pQ/khMil4Lgfd5sRaP1FLO3Nsb4wHL7jABGSH3/QYKNSJRff9
	 oo+66tdUexEwlGPmvVtRbMxgJ9f81Nq74MYf9L9NIfX5vkR73owCm4J12eGjLyNCvT
	 azkzm/c/VK1fA==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2025-03-10
Date: Fri,  7 Mar 2025 13:52:58 -0800
Message-Id: <20250307215258.1900-1-sj@kernel.org>
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
for the week of 2025-03-10.

We will have the two meetings in the week as usual.  As previously noted,
future meetings for the week of 2025-03-24 is moved one week due to the
conflicts with LSFMM.

Any-topic discussions
---------------------

Next three time slots for any topic (no reservation is required) are scheduled
as below:

- 2025-03-10 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)
- 2025-04-02 (Wed) 09:30 PT (https://meet.google.com/ndx-evoc-gbu)
- 2025-04-14 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)

Dedicated-topic discussions
---------------------------

Next three time slots that I reserved in advance for possible future dedicated
topic discussions are as below.

- 2025-03-12 (Wed) 09:30 PT (not yet reserved)
- 2025-03-31 (Mon) 18:00 PT (not yet reserved)
- 2025-04-15 (Wed) 09:30 PT (not yet reserved)

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
