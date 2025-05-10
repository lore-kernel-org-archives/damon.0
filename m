Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03192594;
	Sat, 10 May 2025 00:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746836871; cv=none; b=ZPvK389GmQM5Av46YaRD9GNNhLTa/AltNgqapQaKucGxXikWHdSjkmRFGGXo4L2u3/Z4ZAFi9Z4/MUHRx7q5+AYCyqCZwMNWkswmvnaUOy+PBfufv/TqVhHXbWDArd/9E/b8WdDRXamD1HXkCUvpuaQHns6MwdjUkEkkD1E1rdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746836871; c=relaxed/simple;
	bh=HqMC/PvO3hI0omYHl1kiX7py/howh1t3h7nulYsHeA4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n+KdCVVQlJbuugJxrvuHUn7aAQ5awCwvoK0DzNvr/CNYFU+PV+XATqvgeKU1+C3Acs2gT1ucJlgk6HLOxSd4OZoXXWQYW/05CLh9e2BNx1KiYOE7Ez7mc3w68zcAAxobTY9D7NYZ3y3IgtFTfAxtKOWgI1NOoVM7/dwnOq7ZM9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zc8yK7lP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zc8yK7lP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118AAC4CEE4;
	Sat, 10 May 2025 00:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746836870;
	bh=HqMC/PvO3hI0omYHl1kiX7py/howh1t3h7nulYsHeA4=;
	h=From:To:Cc:Subject:Date:From;
	b=Zc8yK7lPMH4Wvj+nKpwVYUsupUfWveByPXcHbw7wwSK4aCzBQMv3aX2n9p65JHPLQ
	 gHAlAGPFjgUZT1pXT6+1MDq/sTraeEh/RrzFRYdYnezk2i+oOoDGX6DIpDKmQ6VRDS
	 9RM07OsaYtJXh6uCQ5c9oZLvHSMyqilkzbay0aLq81P1atJZc6RtJ5OLtehvMteiv9
	 6PpHf5EXKAx5RuW17Iw6Bf6Cvi5oSOSxFyNPoKoZUAYfK7aPREyaQyDDD/8NxBOAxs
	 hPIo9JqPAScHY/FzWBwVyxV5Tx0qNkGvO0N/UQW8BpVnEhUflnM5EdVs4yKT1kuX9k
	 DGRdelXk5YaWA==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2025-05-12
Date: Fri,  9 May 2025 17:27:46 -0700
Message-Id: <20250510002746.58427-1-sj@kernel.org>
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
for the week of 2025-05-12.

We will have the two meetings in the week as usual.

I'm also considering merging any-topic and dedicated-topic discussions since
apparently people prefer dedicated topic discussions.  For any-topic, I'm
thinking about creating a Slack-like casual messaging systems.  Nothing has
decided so far.  I'm just thinking about options.  Please let me know if you
have any concerns or suggestions for that.

Any-topic discussions
---------------------

Next three time slots for any topic (no reservation is required) are scheduled
as below:

- 2025-05-12 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)
- 2025-05-28 (Wed) 09:30 PT (https://meet.google.com/ndx-evoc-gbu)
- 2025-06-09 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)

Dedicated-topic discussions
---------------------------

Next three time slots that I reserved in advance for possible future dedicated
topic discussions are as below.

- 2025-05-14 (Wed) 09:30 PT (not yet reserved)
- 2025-05-26 (Mon) 18:00 PT (not yet reserved)
- 2025-06-11 (Wed) 09:30 PT (not yet reserved)

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
