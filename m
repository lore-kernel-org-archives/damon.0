Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074502F7EE3;
	Wed,  3 Jun 2026 21:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780520469; cv=none; b=jtzNMjxhZNvQl6LH50Cq4TkDzJ9cR5spIBJfkmQ5hgcXCNDNuIChZwbhbt1FqwXTZ3XHGmv6A8yybwjmM6AV6+BxBRTHdyI4298nqvLlJ7avEVFR/Y1LKT7zqlvi64lnJsN96iHA3eXllZ21Dep1Z1PoTUIkWQwBT+03lqjJkmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780520469; c=relaxed/simple;
	bh=PcwXZ8Nj/G5ri3I1x0kn81IRjcyAugdYLgW+1BbzNqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e+bndbReR95JgOXKfJEPg8sRFXt6bZhW7orv/NK5c1v+2Pk/JDKQ5Y/A12MvW3kMNA4qwJG/Fo4nqtbr3sAtlosa0igVw+VJBCGeNzsSDsPsbWqkdhTYSYTGbkKyX16tVwP6V2kMOv20caQ7C3XKLztUIeYGgEwDBnRkzZhefPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBO6u+S5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBO6u+S5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B02D1F00893;
	Wed,  3 Jun 2026 21:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780520468;
	bh=kGZJGw424yME+fD2arJBJd0mBfOG7n7nCcKH5ittnhA=;
	h=From:To:Cc:Subject:Date;
	b=VBO6u+S5IYaefjUFI1pd9/q5UbuO892Qmaw5jgN+uo9Asfy2mcASp624cd+BN8OAc
	 xHNhdiCvOqr7VrD5Su6/nGnBzosBA4v6NOQG8xPqt2mwr0vP4HSoKsIqPVaWofUqsm
	 RDkTFm+2fpfQq8RuTkKCNBnKSlgUH3LToZk2qhW7HLjgRDMjoKjlhiJtDhGnaAM3IX
	 gwGSUQ5yeu1wqMXPVkkm1kqEaedvj3GS3AOR/U/dtz1Q/9UUywSgRNLOuji5oy/8E/
	 R2qp7PogBIFLuB6GyMbzEPTzluNi4i9jsv1TkDXgPXZXfyHXFPRhonSwVlpdhK83qP
	 OYarOGopxLsqg==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2026-06-08
Date: Wed,  3 Jun 2026 14:01:05 -0700
Message-ID: <20260603210106.14684-1-sj@kernel.org>
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
for the week of 2026-06-08.

As usual, we have two time slots for meetings in the week.  The one for the
Monday is already reserved.

Next time slots including six virtual-only ones are as below.

2026-06-08 (Mon) 18:00 PT (reserved)
2026-06-09 (Tue) 09:30 PT (not yet reserved)
2026-06-22 (Mon) 18:00 PT (not yet reserved)
2026-06-23 (Tue) 09:30 PT (not yet reserved)
2026-07-06 (Mon) 18:00 PT (not yet reserved)
2026-07-07 (Tue) 09:30 PT (not yet reserved)

Please reach out to me (sj@kernel.org or whatever) to reserve the
not-yet-reserved time slots for your topics.  The reservation is made in a
First-Come First-Served way, and I will send a Google Meet link to
reservation-confirmed attendees.

Please note that other time slots are also available on demands.

Shared Calendar
---------------

You can get the schedule via this shared Google Calendar:
https://calendar.google.com/calendar/u/0?cid=ZDIwOTA4YTMxNjc2MDQ3NTIyMmUzYTM5ZmQyM2U4NDA0ZGIwZjBiYmJlZGQxNDM0MmY4ZTRjOTE0NjdhZDRiY0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29t


Thanks,
SJ
