Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA933F12DC;
	Sat, 28 Feb 2026 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300536; cv=none; b=sbzvXypunQ+nKGC55ekHZsVlH2J+TKl/HueEdHfzz4eptxU4wCWoj8MAq1GS63/+Jb/6Dx4RXFP/KXooaT7uV6LZ6X3xKTmkEWNJ6kZhSQhyP300ju7kgHNr/GQQ7A7+PoKRxYIu7ViotFW4bvUlBVviOD6eqZSLkgONP8ENKcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300536; c=relaxed/simple;
	bh=wojLBurTdVIocTYrUG+SckAORkviSrPRVTgmvgwchPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=shl+tgGdrbRfpJFKBizRXFeCoaX8V1NthkyINrm/CRqkudrTwjJNm2uo9sPeGUhkO/d+D/YWxf/Pv53sQSeLGyVV8+Fa5ISEHKCXUIxCvir7USvXvN+A26vgycUmV3zT30d/bBfnjPZpJ0UWEH5KMWT4E/JoTF2ibmLemd2pWB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhIVkNU2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhIVkNU2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271E3C116D0;
	Sat, 28 Feb 2026 17:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300536;
	bh=wojLBurTdVIocTYrUG+SckAORkviSrPRVTgmvgwchPQ=;
	h=From:To:Cc:Subject:Date:From;
	b=UhIVkNU2kb6XM1y94sNzc09rbebeZn2OIiFwW5C7n/NQhg5yuMYAcIzAsdgxkhuyt
	 ASC4u3o7MRzENnyn4Ip9OkR5vMjxMDchyIVa735Y8mBivSImwHMNNOiYhvCArFSxA+
	 OiB6nm7O7ThP0u/doHJsqzovYjc2U3bEe0T8wwOJ2ZGfmEaDe6h5pFoe0x1EyT3Hl1
	 CoKf2t28OfMSl1oqX8gNcIpwDswjH7wl9sCkmXXOCJ6z0BU6tgk7zE9TVJK0XNfRov
	 ktNJf4CatgswoMv987lCkQkXttThGJBvpPyMalvHvfSMhDu24JK5t8XgTCMbTs8vgu
	 /fyIf671Rl8Mg==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2026-03-02
Date: Sat, 28 Feb 2026 09:42:13 -0800
Message-ID: <20260228174214.91429-1-sj@kernel.org>
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
for the week of 2026-03-02.

As usual, we have two time slots for meetings in the week.

Next time slots including six virtual-only ones are as below.

2026-03-02 (Mon) 18:00 PT (not yet reserved)
2026-03-04 (Wed) 09:30 PT (not yet reserved)
2026-03-16 (Mon) 18:00 PT (not yet reserved)
2026-03-18 (Wed) 09:30 PT (not yet reserved)
2026-03-30 (Mon) 18:00 PT (not yet reserved)
2026-04-01 (Wed) 09:30 PT (not yet reserved)

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
