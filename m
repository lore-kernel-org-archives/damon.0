Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353897260D;
	Fri, 16 Jan 2026 22:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768603681; cv=none; b=Ov6dWcrgei/CT0xTQ738Wn8PGp4Wu1YuV+1oKtuZ8YiCFbmpkd6s1I0T2E2LceUssHjBcuezEy0eW+cmDNQ2JPcynT3+s8U5cBx9/Cb7VcgGVJJiZ+s5sT8A0a56sxchzsTan747Tkxtmd7hBcZtvumH2Zcb65aotZll4IzR1/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768603681; c=relaxed/simple;
	bh=Y1fgslvUFGv7FFMMxCuMeKzRLD1x+G0p7+kfTN3IfXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=utCLpGP7H/JvkeMxgjL7ujGkNb30G+e88bKelYQtzPQkj0tKMAvOewCzTp0CgkbnOK8FjLJAcX9k33mFDissP02HRoKN6QWQC/0TYg7wHV7tfI2/jT7Cx9IxKVr4us04twmY/GbaPmY7iXXw9U7r5OChA6HuvMP8UfuMAnqOp84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpii7T5h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpii7T5h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBEDC116C6;
	Fri, 16 Jan 2026 22:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768603680;
	bh=Y1fgslvUFGv7FFMMxCuMeKzRLD1x+G0p7+kfTN3IfXM=;
	h=From:To:Cc:Subject:Date:From;
	b=fpii7T5hayCWs0pysxiBoH/iS//50XKk8pkwZJCe8ne1rJaRGKqDmnGFwq7QLEwDf
	 bddwlakbSJUPQK5sXmD970nQLqrMwGuwRE4KkvwTjep2AjQQ3QgDTiufVk76Kq9G3n
	 C/qAYglLGofQUBChwX+exBOe92JHFV1MbVr9KzTB3NkWQIjj+mg8k9JLrv5v8W8KU+
	 dQIIHB5ci5RzVBX5dlAgCZo1GzmBspVOURgenyygeKmWcCBOZ1ROtutxQLytVYhFS4
	 SuMxJ6nwQ0YxU2rSo7GBlu3hdnCLlBMIOItn0TRIx2sNx4YSpq+1nkCln6lTkS9CEL
	 tNI8FvKST4G3Q==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2026-01-19
Date: Fri, 16 Jan 2026 14:47:58 -0800
Message-ID: <20260116224759.40500-1-sj@kernel.org>
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
for the week of 2026-01-19.

As usual, we have two time slots for meetings in the week.  The one for
wednesday is already reserved.

Next time slots including six virtual-only ones are as below.

2026-01-19 (Mon) 18:00 PT (not yet reserved)
2026-01-21 (Wed) 09:30 PT (reserved)
2026-02-02 (Mon) 18:00 PT (not yet reserved)
2026-02-04 (Wed) 09:30 PT (not yet reserved)
2026-02-16 (Mon) 18:00 PT (not yet reserved)
2026-02-18 (Wed) 09:30 PT (not yet reserved)

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
