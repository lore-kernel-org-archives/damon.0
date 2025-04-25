Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467E1221FAE;
	Fri, 25 Apr 2025 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745616763; cv=none; b=ALoax+zg2Wb2TV5oOc7MlyyldWbgk66vh49vAuaOXfPwIdCAYLzw4SpHcdlhuulp3+9x+N3AZz5CnqNsMzTNCncZ9iTWmfe+5jnEZAy4vPjs3Jpl3f8cQA1qd4AeWtqs8Fs9rKdeVAXeykuTQRRzlZHtv0k1jgIL6/2RDjw43Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745616763; c=relaxed/simple;
	bh=Ukg4eJzpSRuoQnTM3/yr1cnOPT5Y7DCcKzHuHDThJho=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I9A13aQP15tSj9Bv2qC2fzUP+rdPo9qI7CeH5o+sbERY15ET13lyjcipvQ1BDa9Jxt3LZnUpMHU/e2qM5+lyQtfAnvnzs7ZhsiBdnar2sDiHQXed3OlTZrT5qkKjIwfr7WZ1baCpHpwtF5i5zgPBrc4h6DWSh2KYMUwWPFtduPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXWPsN6a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXWPsN6a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8552FC4CEE4;
	Fri, 25 Apr 2025 21:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745616762;
	bh=Ukg4eJzpSRuoQnTM3/yr1cnOPT5Y7DCcKzHuHDThJho=;
	h=From:To:Cc:Subject:Date:From;
	b=rXWPsN6a3S/O2HqshFlBZjg4UdXZYUvmBH/lO42cU47ZkjuHOsDk+gVhCqvHkD8GG
	 8eccAxSCbFLCOaIbQ0g0fdQNeiuUO/tps3q13lVWCT0c0ht37Va20UC6q8/C9AS+f+
	 88wAYWvO5252vwj9ECP9fAalNquUVPztB6r+HMGLR462v41laeEgqK54VOYYg/txb6
	 guh8vxEr8gT6v/Voy7I0h1Gb1OBcLvKftiNJ33du0mr3vuZMI5qFzr77pv5B4JHMVk
	 awHbdiYwwwo/1gXB4ElBV3BjfC0RLB+kMze2oNS+tI7gF9yqlW2YN6ZlvhIU1VMtNp
	 Agx3RQqnmlv/g==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2025-04-28
Date: Fri, 25 Apr 2025 14:32:39 -0700
Message-Id: <20250425213239.55435-1-sj@kernel.org>
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
for the week of 2025-04-28.

We will have the two meetings in the week as usual.

Any-topic discussions
---------------------

Next three time slots for any topic (no reservation is required) are scheduled
as below:

- 2025-04-30 (Wed) 09:30 PT (https://meet.google.com/ndx-evoc-gbu)
- 2025-05-12 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)
- 2025-05-28 (Wed) 09:30 PT (https://meet.google.com/ndx-evoc-gbu)

Dedicated-topic discussions
---------------------------

Next three time slots that I reserved in advance for possible future dedicated
topic discussions are as below.

- 2025-04-28 (Mon) 18:00 PT (not yet reserved)
- 2025-05-14 (Wed) 09:30 PT (not yet reserved)
- 2025-05-26 (Mon) 18:00 PT (not yet reserved)

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
