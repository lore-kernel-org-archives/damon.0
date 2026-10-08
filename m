Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1B71A6807;
	Thu,  8 Oct 2026 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791458224; cv=none; b=tVx+2Mif4Lzk9dioZnGMV3vGH4+8n+5wQ7uPYVLmhXap9MRb8CraQZQxnmeOa5wxA0YYWmOECPcNaUEfmTFVMtSyM0LunGLXbkFpc71t2FsF7aHnumVGx0WQcoqzPaaDt/VlnTi7qfT2bQCQhDIAMaQ+Fd8v8I6326aaOcmW5Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791458224; c=relaxed/simple;
	bh=DY7ufMWE4dqTnKsh2TrFy9VDMFW/JNleqyyqmc9IPYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QbZvUEcpPNMOtv/q98lykuaYXLrMpYJV2yM3c8PJslYDgvd6OBq565sHAqMGlAXLRmdHsKEW4ijbmNsnsx1P/T2FBJ8zm8+TIVM/4hx30hEk3eiAbiabiUO9NVXmWnrrOff1N5P07vJKekpJl3uNtuJCRG/b94FgxKZ+rxIrT1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffnm6R14; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffnm6R14"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C36D1F000FF;
	Thu,  8 Oct 2026 11:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791458223;
	bh=eRfplKRiHdz7gMgIh0TjaeCLxu6xLWkA65cW/q3IdPE=;
	h=From:To:Cc:Subject:Date;
	b=ffnm6R14JjZobeb6o4xC35qwqQdnDuJwvl+gxSq+QSf/Ia7TOXp7LMzoH3wpJK2ZK
	 BKMOES8seICSinxSNq2te9Ok+6sjF9qfbWWyiUN/mME1edMuElY5Xg5Ac8u5H8C33n
	 lJUAtIIulk4cst0BJGN9753F3cdCGUfyjEAooxJ0/szsFptIG3a550uV9yRqyKQ3tT
	 4CKeDzL78QRym12xBu0A5jlwtEBBkbokfiuA1GfqK9Cq3oVRNUlJB9ncANTNxQfxNf
	 nE1KSCjk89v6iTWnWN56wP4p6mBT/Rjaujxv2c2bRWuyQk0ERIbR8a5RhT/WQ528P5
	 uCRZr9YCn5mFg==
From: SJ Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SJ Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2026-10-12
Date: Thu,  8 Oct 2026 04:16:58 -0700
Message-ID: <20261008111659.42463-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

Hello,


This is yet another reminder of upcoming DAMON Beer/Coffee/Tea chats
(https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing)
for the week of 2026-10-12.

As usual, we have two time slots for meetings in the week.  Next six time slots
are as below.

2026-10-12 (Mon) 18:00 PT (not yet reserved)
2026-10-13 (Tue) 09:30 PT (not yet reserved)
2026-10-26 (Mon) 18:00 PT (not yet reserved)
2026-10-27 (Tue) 09:30 PT (not yet reserved)
2026-11-09 (Mon) 18:00 PT (not yet reserved)
2026-11-10 (Tue) 09:30 PT (not yet reserved)

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
