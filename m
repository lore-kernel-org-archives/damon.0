Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44BD18E1F;
	Sat,  5 Oct 2024 20:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728161004; cv=none; b=ZdoPe1Z/EGVG8jEJti8DDOE7ZetkUO8u4xDSzOnRMKAztGVA7IEuQuq/nO1YLjVRfYP5qCTqvh7VVggkYScB4CuazTVIjP44lvl4bafb4Q4cdZPxAsetJu7aIJHOX71aHp1GrIGeI1L7SXmmV1xQvLTCpKSsruJvcpHvrSIK5Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728161004; c=relaxed/simple;
	bh=w1S1kccVHqOlIDjO7bcM2/Es9N01G0yiryLEDKVmDgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XsAclDyy9fztD5vcLA7n0nkXBsUtfKDt9beA21XvBIsHwqcBy6EN6EjARiu9a8lPildmAbq5NCatsGIDXGfNG9AEj6nef10EQ2ZFd0/vvcdF2EtAc0IP6GAwQx8OuP9JY/DoBLeHZyemJXRRnzuNWKu8VtfFlIIClxax1wjaPQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akKSLHmV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akKSLHmV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FA9C4CEC2;
	Sat,  5 Oct 2024 20:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728161003;
	bh=w1S1kccVHqOlIDjO7bcM2/Es9N01G0yiryLEDKVmDgQ=;
	h=From:To:Cc:Subject:Date:From;
	b=akKSLHmV8HXhgGgjFFzr0V2j+M241Jd+TvB7ccDDP0oUnxd2VWMzeWmcs85ulS6Gw
	 4Ts28h2dvqLkBOLlfhy/BdUPnPR+ecOys0NtIDOREoZll/pQwwYGdwifYiYfYXa0bQ
	 ZbyWwlocmY1+G9McNtcrw2F66lz19NMD/VVkVQJMFSIcaxoMQXz/xl/1mqUgexGZyh
	 YxEA7shMgJzGtLjoRDM2R4ovOQbLjftjIr5IgBJYVTAzlI0t7tMy2cQQ5YIH+hRdKo
	 IGqJLUqlDyiUhZPfAbJZrgxRFo2JyRQl/ty/dJZq2TPUCzDQoQZcCaGwzZC8fmQQPW
	 77X3qwmuf35pQ==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2024-10-07
Date: Sat,  5 Oct 2024 13:43:20 -0700
Message-Id: <20241005204320.68531-1-sj@kernel.org>
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
(https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing).

Please note that time slots for Tuesday are rescheduled to Wednesday
(https://lore.kernel.org/all/20241003182543.66235-1-sj@kernel.org/).

Dedicated-topic discussions
---------------------------

Next three time slots that I reserved in advance for possible future dedicated
topic discussions are as below.

- 2024-10-07 (Mon) 18:00 PT (not yet reserved)
- 2024-10-23 (Wed) 09:30 PT (not yet reserved)
- 2024-11-04 (Mon) 18:00 PT (not yet reserved)

Please reach out to me (sj@kernel.org or whatever) to reserve the
not-yet-reserved time slots for your topics.  The reservation is made in a
First-Come First-Served way, and I will send a Google Meet link to
reservation-confirmed attendees.

Please note that other time slots are also available based on the demands.

Any-topic discussions
---------------------

Next three time slots for any topic (no reservation is required) are scheduled
as below:

- 2024-10-09 (Wed) 09:30 PT (https://meet.google.com/ndx-evoc-gbu)
- 2024-10-21 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)
- 2024-11-06 (Wed) 09:30 PT (https://meet.google.com/ndx-evoc-gbu)

Shared Calendar
---------------

You can get the schedule via this shared Google Calendar:
https://calendar.google.com/calendar/u/0?cid=ZDIwOTA4YTMxNjc2MDQ3NTIyMmUzYTM5ZmQyM2U4NDA0ZGIwZjBiYmJlZGQxNDM0MmY4ZTRjOTE0NjdhZDRiY0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29t

You can also get the past and upcoming schedules via
https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing


Thanks,
SJ
