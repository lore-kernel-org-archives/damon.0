Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E21A230BCC;
	Fri, 20 Jun 2025 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750452473; cv=none; b=Y0yDX9Bj+MypvWCBpHzx7g6jboTiUSpq6fmH8HLliPFxEAPJCKOo0zUbBo8TZ0+q9Jm2rlelsZthFGEu9nER/qzNRCi4YBB/NgVNLIkvXRohBqi1byOOeKRMxhttxG46y09yaegRdRCWp1saF7joZ9LNCNt5ueuuuiqJDCTt54I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750452473; c=relaxed/simple;
	bh=Ikyc3rx+CEWEm9oMJEsMIqzvaTpKUnr3/zJcTFje4iY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e/4OIGZnoWWoKmAQAPzfO1ZdU7WzNz/7vENxbrAIKA5t8tyu2JLs4joOJMFB3nBLzMjsSd590MoY3qs4OEBO637KOqtdD4L0CfYaMA3wuTaTNidZMV0TKZ/DAOhvDn9LVW4wt0lLoNvFdIgBK/0kjbjJNnIGi/zEA6ZluRAd0X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lB9zax3A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lB9zax3A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DE2C4CEE3;
	Fri, 20 Jun 2025 20:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750452471;
	bh=Ikyc3rx+CEWEm9oMJEsMIqzvaTpKUnr3/zJcTFje4iY=;
	h=From:To:Cc:Subject:Date:From;
	b=lB9zax3ABhaMcNBFrgDurbOjZhZEETwKqs5pG2hB2fttlk2ILVe0wmfxDWUJ1+fsH
	 0tmQ+S5ucx2eq4xDN/Z+eJTFa7SFh3qIxHpaaarEjIQOjC7/Rn8dDmx25AuSwQ4VS5
	 SxsXekYclgFCugTfMb9hFX5e50IE8O+zKRfcytbgcGFuoMHI3qiq7C9i7HeGd+ygwl
	 Q+W2eHtTghqBXvnwD7UaW1dCKkU5l/WC2QKDhpu5kWT64z6BMUcqg5MhwKYzH9YRSb
	 ee2s9iLsln15kJsFrJzmDFxzq928MU7Qyz4VtC337c8kiW8gjE8zedUEWrNj/B1N1K
	 BNqHYnCgtlMeQ==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2025-06-23
Date: Fri, 20 Jun 2025 13:47:43 -0700
Message-Id: <20250620204743.98321-1-sj@kernel.org>
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
for the week of 2025-06-23.

We have two reserved time slots for meetings in the week, as usual.

I'll also travel Denver, to present DAMON at Open Source Summit North America,
from Tuesday afternoon to Thursday morning.  If you have any topics to discuss
in person, please feel free to reach out to me.  We can then have
nearly-unlimited in-person beer/coffee/tea chats :)

Next four time slots that I reserved in advance are as below.

- 2025-06-23 (Mon) 18:00 PT (not yet reserved)
- 2025-06-25 (Wed) 09:30 PT (not yet reserved)
- 2025-06-30 (Mon) 18:00 PT (not yet reserved)
- 2025-07-02 (Wed) 09:30 PT (not yet reserved)

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
