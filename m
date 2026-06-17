Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CB127FD4B;
	Wed, 17 Jun 2026 21:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781731329; cv=none; b=cElAXSaMshniJnsm6LB9vAadwaMUdz+urb13EihzxZP+3xwFsGPaOzPxuSD2hlnacF/otW7PI1KV8P/qktUtQdrvFdBG7PClKg86fniO/AMoOPBq3wBtKIJA+exq+VX2chFHcc5aOSQrceXRFO6reU4t76BDk9pon6sG1P7wOKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781731329; c=relaxed/simple;
	bh=yPCNtLJjnhtWdMzs/28dp2I8exEjOw7ZEiXcbOBAiUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GSx5alpRUJB5q+VyVncIQHVHK+ZEp/CtxTO5qMpLIChKW9uQA8TAGOewuIRawl9sjJ6jyRbPiw3OCqdoHF0ONQOwO/vLzUUwUXw6j6pz/oBCLw7Vro5S9rC6gu12kRbi3erYGGXxMrrB6vpEHEHZ1bx0QEJJUgBDPUlh8Ypl1gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvgBeayl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvgBeayl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1E31F000E9;
	Wed, 17 Jun 2026 21:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781731328;
	bh=kUSLuADlGuyB6w8Kyvi/AxqjQ412r5lYEyZTSDVMugo=;
	h=From:To:Cc:Subject:Date;
	b=EvgBeayllHaViEBS5h9q08CKx5DMzcIgVNXIFEO4KwQe2U1XFQJBK+Ryu8feTtvdo
	 L4uXXnQ4rDw58kGU1jthhJTYSJ7rfJX8U3n1B2bGXwi1duiSM1oK416D/bEtBT9iMD
	 hfoIHeooJu1OQ4RtZXuJW2LAaQk09NfqCa4pr6MZL+1Lj6c3vIBH+8e3AZHzh9CQqW
	 n/GDcg+dxk24DsDjL6AtVLAflq9srCyCExrKYeOCV+X2Gtm4u6ogpX1iDTJh69DOsX
	 H38B7lVN2R92E5/rzmS9iPhRq/mb550L+08SGReJqBMv08pF1eQEiK/RBmbz6cX+Vc
	 N3n+bPTwAk/jw==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2026-06-22
Date: Wed, 17 Jun 2026 14:22:06 -0700
Message-ID: <20260617212207.4584-1-sj@kernel.org>
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
for the week of 2026-06-22.

As usual, we have two time slots for meetings in the week.  Next six time slots
are as below.

2026-06-22 (Mon) 18:00 PT (not yet reserved)
2026-06-23 (Tue) 09:30 PT (not yet reserved)
2026-07-06 (Mon) 18:00 PT (not yet reserved)
2026-07-07 (Tue) 09:30 PT (not yet reserved)
2026-07-20 (Mon) 18:00 PT (not yet reserved)
2026-07-21 (Tue) 09:30 PT (not yet reserved)

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
