Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B0378F45;
	Fri, 11 Apr 2025 20:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404188; cv=none; b=GR1qlvznEE3KuySidB0U1z9/d3UhhotdYx8sB7dMTWWH39Wet0a2MqZxsBZPiBdh8+v/jJt1mw4FB6Hw3EILJ/FXe1dLdMmFAyxPqFCUJccrTAMNL69U6X7lGnu3EPDMEdoTsWUESouyXyYDBOE3KujJG4KZdm0wh7XwXjf4DCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404188; c=relaxed/simple;
	bh=5WqwkdeEs9aPFAO/sckYXY/Wtq3x4uTjmQJSyd9Pkgg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jhK7yRMLgVxvzvt93C/MvG1nrNBqKF+NTb0yy6EXDIr22fvYsiUNeIqZlgJlS91OXQTnBRj2g7SLQMcA3IhfoSHK79vigF8gLKWywb32DLbfjF4h0HH/y4R8XiAR/9d9yQTZCiVuUbldYXRM9EHpd2fKh/E1AU4WDAbFpobKD8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cO7IsGDQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cO7IsGDQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A001C4CEE5;
	Fri, 11 Apr 2025 20:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744404187;
	bh=5WqwkdeEs9aPFAO/sckYXY/Wtq3x4uTjmQJSyd9Pkgg=;
	h=From:To:Cc:Subject:Date:From;
	b=cO7IsGDQbv15oF8AX3VEGshJWiEmgcQdEo/ULfh2pQI6V7cRbdEFbLIuI3RV7Jr+6
	 4ak/jASHAP1cKYg8NB0QPi28E4BC1zA9oI7dBjdtU5NWtAHvitu5qrxYqQU/1Wipg/
	 Cr7QxEhNGpadtsnUczQ7bWu0hVt5HmhZ2x/UK8n3417N4jRDy3YL9Pt0/LDPADs6JB
	 T34RwMS0zR6cm1UWBLjrYHYPJ1Gx75j8oP3Acrr5eTDSm4udPAOHYzkIBJ0CdkR9kI
	 +RfnbTnBg9DH/TK7nNHERPYK+O16ubJdxWjF+q7Gx5u6xD9nvhYsHxFEJhtCFqAdYQ
	 JT4hQxKAh0BPg==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2025-04-14
Date: Fri, 11 Apr 2025 13:43:04 -0700
Message-Id: <20250411204304.53401-1-sj@kernel.org>
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
for the week of 2025-04-14.

We will have the two meetings in the week as usual.

Any-topic discussions
---------------------

Next three time slots for any topic (no reservation is required) are scheduled
as below:

- 2025-04-14 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)
- 2025-04-30 (Wed) 09:30 PT (https://meet.google.com/ndx-evoc-gbu)
- 2025-05-12 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)

Dedicated-topic discussions
---------------------------

Next three time slots that I reserved in advance for possible future dedicated
topic discussions are as below.

- 2025-04-16 (Wed) 09:30 PT (not yet reserved)
- 2025-04-28 (Mon) 18:00 PT (not yet reserved)
- 2025-05-14 (Wed) 09:30 PT (not yet reserved)

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
