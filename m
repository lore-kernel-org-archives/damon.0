Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E983CA5B;
	Fri, 15 Nov 2024 01:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731633933; cv=none; b=Wc7qGE1Lt+/EKJv1Lq1cx1KV5VjRqyuUzFpzkPSGFUgAKEEJgXraFlESzHY0n1qeFt8OG71+WrFLXi8a8ZvIhdFyV5UQkeAhkFiA2xgWEyyQih9orcCbvCBt5ZMjTU0BfsTO498Api/ZVq3QgK0MoEUV0JpRntLLVoT478vjfmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731633933; c=relaxed/simple;
	bh=x6UT6OVZn4jjNeukr+uzg+Hm6X47IC5kPd04Z4OXBFY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=psZ3cnHOzTvCCbVERTD9XQsGgGXXv9zw9ESeeJWJ+u0MylcwNlPUPpeaY0tZZNCqD7o+hgsHvpuKqFG5cwsWxMdsdIgKrm/3dzrup+6Fivtqpw9uYVHXqSN15XW6SbKOY44H2330gqp1kVEPjdVcBvtRaYvrAasw2hUNkTwmc+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftELgl0E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftELgl0E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F725C4CECD;
	Fri, 15 Nov 2024 01:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731633932;
	bh=x6UT6OVZn4jjNeukr+uzg+Hm6X47IC5kPd04Z4OXBFY=;
	h=From:To:Cc:Subject:Date:From;
	b=ftELgl0EtFv3hDX82+8GMoJ8jBKkWo18eN7vfvFGOFK06oa/+a/mjMghLOUDCmVCz
	 qO3F1EwAJ2TaLsZxxYh4RC23Lncnn/X+akoJ/MZNyI42rzTLcONYg/I/UJV56i8OIc
	 B6B2umgWkC76XI8aMFyBQQM6xxex1VOm5bMUeC99Z+Ko/T7ZVe/qWfgSNprxOOfzjN
	 2Vu39EMJFh5YK6tl7lgHcz9KzZQKB5GKqxeyFHNJiZvPCt/LVObkbDotqgTJzMGzso
	 BSnNywbvI3b8Ang1Q7VEW76B2J0riyRkVRqJcVk+4PWllsoMa+iV2U9R5Y9bAVXL88
	 otEWUdr67vIoA==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2024-11-18
Date: Thu, 14 Nov 2024 17:25:29 -0800
Message-Id: <20241115012529.83546-1-sj@kernel.org>
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
for the week of 2024-11-18.

After the two instances for the week of 2024-11-18, the week of 2024-12-02 was
originally the next meetings week.  But I have conflicts on the week, so moved
those one week forward.  Please check the schedule.

Please note that US Daylight saving time has finished recently.  The shared
calendar mentioned at te bottom of this mail could be helpful to set your
reminder regardless of the change.

Dedicated-topic discussions
---------------------------

Next three time slots that I reserved in advance for possible future dedicated
topic discussions are as below.

- 2024-11-20 (Wed) 09:30 PT (not yet reserved)
- 2024-12-09 (Mon) 18:00 PT (not yet reserved)
- 2024-12-18 (Wed) 09:30 PT (not yet reserved)

Please reach out to me (sj@kernel.org or whatever) to reserve the
not-yet-reserved time slots for your topics.  The reservation is made in a
First-Come First-Served way, and I will send a Google Meet link to
reservation-confirmed attendees.

Please note that other time slots are also available based on the demands.

Any-topic discussions
---------------------

Next three time slots for any topic (no reservation is required) are scheduled
as below:

- 2024-11-18 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)
- 2024-12-11 (Wed) 09:30 PT (https://meet.google.com/ndx-evoc-gbu)
- 2024-12-16 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)

Shared Calendar
---------------

You can get the schedule via this shared Google Calendar:
https://calendar.google.com/calendar/u/0?cid=ZDIwOTA4YTMxNjc2MDQ3NTIyMmUzYTM5ZmQyM2U4NDA0ZGIwZjBiYmJlZGQxNDM0MmY4ZTRjOTE0NjdhZDRiY0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29t

You can also get the past and upcoming schedules via
https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing


Thanks,
SJ
