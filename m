Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462773232;
	Fri, 24 Jan 2025 21:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737755831; cv=none; b=p0th1tuKOYiTChX17lyxy2QLPMt77krAkzPOXn6emHR6uE+tnMLuk+kX6Pi/lrPfGy76HXAlVSb7Vd4ojkNpWKaXXPidcfPZHhsW1vUkU6CTDPONeAejxZRSyMKmJBLTmV9w3LSGiynWIIRD2tzuJDZ7rlpKM6moEQIueTwbaaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737755831; c=relaxed/simple;
	bh=Xv23MRHjTI9+gAGvV4+MHyYCyjb/nph5+E0J1e/TqII=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P2jgFVEz72+OWLgP0VTU+U2CJkw66yPY/9uhbPIT6ciD3Qg5KfAHdrqP0VYbNaapl3buNKJN4D7ikAyOumvSgUdHgju4OOYc4wHXLg/IF85WHqTJQnZwtaMOliO9/Pa7vk9K6i85j+fgLBUectLuK8WdEplB4pFmGOvwx0+dWiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e576WOji; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e576WOji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F8BC4CED2;
	Fri, 24 Jan 2025 21:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737755829;
	bh=Xv23MRHjTI9+gAGvV4+MHyYCyjb/nph5+E0J1e/TqII=;
	h=From:To:Cc:Subject:Date:From;
	b=e576WOjizKlYdMyi6mxecoQJb9LFgWp1doB0i6X5beXHArRIZocVM+pB5F5fOhfVr
	 yCWl+0KgsRNh5I947YviecnDdMmpMP//g02LPVghxhjW+rM6Owr0nGUmNnryt8sppB
	 4zt2g7lDDPqaE6wJi1oYEVVj7VLUXyA/s8z9lSBGCSU2jqWyUTAvvCXy8zt+s6CbDt
	 SR8tw/cdir6g63cTqRDErt4JDacdqEj7neMBt711T0jNclXl+6si07YzzJda6zbVgb
	 HbrFK1o3evYf0A2KRpScF2afya/uvsOE97JC9oYM7L2FRNXPB3lCpOG0cE7zvtDIAh
	 cWNpcWLsv1reg==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2025-01-27
Date: Fri, 24 Jan 2025 13:56:59 -0800
Message-Id: <20250124215659.37621-1-sj@kernel.org>
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
for the week of 2025-01-27.

We will have the two meetings in the week as usual.

Any-topic discussions
---------------------

Next three time slots for any topic (no reservation is required) are scheduled
as below:

- 2025-01-29 (Wed) 09:30 PT (https://meet.google.com/ndx-evoc-gbu)
- 2025-02-10 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)
- 2025-02-26 (Wed) 09:30 PT (https://meet.google.com/ndx-evoc-gbu)

Dedicated-topic discussions
---------------------------

Next three time slots that I reserved in advance for possible future dedicated
topic discussions are as below.

- 2025-01-27 (Mon) 18:00 PT (not yet reserved)
- 2025-02-12 (Wed) 09:30 PT (not yet reserved)
- 2025-02-24 (Mon) 18:00 PT (not yet reserved)

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
