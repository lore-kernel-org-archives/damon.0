Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E601E570D;
	Fri,  5 Dec 2025 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764963355; cv=none; b=aQl4N0dOZ3gqSNOJIajWN8ADwObNWUrVtLyk19JSCOC1dB4xGcQU/DPKnF9zIgCzyusAzO3NQRbPkdvrthJ8XNdem848TfY5Ac3KQfyxienb2IZs7u17BfDLEY1Or1ymi28RjNyE/Fh/5+N4v2+aNi+nJv5CCmchwQjqGajRGeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764963355; c=relaxed/simple;
	bh=Jo4zjCKoG72AfS5e5YfO2hAlRtFfxB493GBbVpdnDZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ibra6UV55tvgMz3XKNrjk80YfyVYiv4VB3JJGH1/EmIPbxoKvCqGc7ySap6/HiDr/uPKZRKHmSPevIwlBgMdmcvD9BWixckEm1QhXrpyIHTLOaCZ2ZhyK8qNojDPST/HtKindi7k6eHiN8aHPe5lIVc6GfaSJEhwBfwabbrFvX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2q1VX+f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2q1VX+f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1E9C4CEF1;
	Fri,  5 Dec 2025 19:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764963355;
	bh=Jo4zjCKoG72AfS5e5YfO2hAlRtFfxB493GBbVpdnDZI=;
	h=From:To:Cc:Subject:Date:From;
	b=X2q1VX+fPSakm2kn9lOkU7VM3+bYchl6VDy99IAV7b8yB95z6MriO7Qs46gLDOqHo
	 oVrmeZK9xba0I/uQn8CnDddO0nr3aolWK+w4C4XbWCrsLyGhLqu7HQeDK3EuVU32lA
	 Y7zp7m8oMQfT9XiIjV6788caylne2dgns3SNRxpU3dA1ot3uJBixNour2ORLUiRWM0
	 24DkMadpERWJghahN2fWVcn25wDsAabQCp/G2bXCEVJ8swbuRjeQ+Hwj/vM4CY/m88
	 /MyyYtHohUGvElnGU5d+r216P2lRT5wM9LilhOjAvnmJGxCoHL3ZPFcgMBX8uOgQAY
	 2QYxp88BIquNA==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2025-12-06
Date: Fri,  5 Dec 2025 11:35:39 -0800
Message-ID: <20251205193540.75695-1-sj@kernel.org>
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
for the week of 2025-12-08.

On the week of 2025-12-08, I will travel Japan for OSSummit Japan and LPC.
Attending video calls on the usual Pacific time-optimized time slot during the
week will be challenging for me.  So let's do the chats for the week without
the pre-booked time slots, but as an unlimited and possibly in-person version.
That is, let's make it can happen at any time and any place (not only Google
Meet but also somewhere in Tokyo, Japan) as long as we can.

If you have any DAMON topic that you want to discuss with me during the week,
send an email to sj@kernel.org saying you have a topic to discuss, with
when/where you want to meet.  Then we can further adjust our schedule.  If you
also attend OSSummit Japan or LPC in person, you are also very welcome to just
reach out to me in person at any time/place without making appointment.  Then,
we can have an instant in-person DAMON Beer/Coffee/Tea chat.

So next time slots including six virtual-only ones are as below.

(week of 2025-12-08 is all reservable for virtual and/or in-person chats in
Tokyo, Japan)
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
