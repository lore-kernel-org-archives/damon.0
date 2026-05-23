Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EFB30C606;
	Sat, 23 May 2026 19:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779563457; cv=none; b=im+q9dppaKr0SQL6nMUhIHQBvCUupwh9Hxes09gRg0F7HhnGpDJgiz5bTosrH3SGRvbeBjeTplAcvWu8tEJpZ4FLtRxZ0oKt3CbIN1OmQTOCHFWVaSsaqTiVdezeShc/JJbrJoqvNyuLD88a0oa3CsuFrdWE6kXoACWNU34Ll8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779563457; c=relaxed/simple;
	bh=DIKwAQjGqHxaDvOVxrfpAnsCE1njJeduO5lBX62CJPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kbxW9Ch+IKaWuoaujhFulirs75ADJrPLpVYKFaegzVuaiL8GW9KPJNNdOv3JVerdaMGthU/I+PnL1fmtGTWg6LG/IOwEZNGyUddc+Z/YjvPrKG5QjIumFaTckD1YZU++OfsKkDBrB4dFo0n0ZrT6iP2W+HgYtiUKT5TgSdIzSN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovOmJy4l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovOmJy4l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685A31F00A3A;
	Sat, 23 May 2026 19:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779563455;
	bh=ZKdNn/A+P+yi+7VAFiqvUap6j4seStUV5OfOCYdtPQg=;
	h=From:To:Cc:Subject:Date;
	b=ovOmJy4leWcJL1PJ9vMEISg7k2WAY+wx22j9qy65lSwOnlBtFvkpHxXs149/S47hA
	 Un3MfueJ8FDcaANcUUsRrIIV9WxCz4QOAQVKOPrQHPYqjOPds6AdBQ3CIm2d93H4fw
	 cv6sSYt0ZcHcdOY7CH90uonvmG/JIjpZrJBohwJVPw3aEBKqnIxRMZptU1eqmlvwYM
	 ORK2hBNdZu43n9jY30rndw0+V5P+PPqZ6XoENeBAAF7bmz1ah7XjDtV1axESkYG089
	 kXQHXYQ7GOr+9/eRn8TObKQ7/HNja4XdYmUq21kE1Joy3Z8vVsN7GJkty0FertH0eK
	 hvcWVAXti/1YQ==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2026-05-25
Date: Sat, 23 May 2026 12:10:45 -0700
Message-ID: <20260523191045.91682-1-sj@kernel.org>
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
for the week of 2026-05-25.

The Monday (2026-05-25) is a holiday in my location, so I moved it to Tuesday,
and it is now reserved.

I also now have conflicts in Wednesday morning.  So moving all Wednesday time
slots to Tuesday.

Next time slots including six virtual-only ones are as below.

2026-05-26 (Tue) 09:30 PT (not yet reserved)
2026-05-26 (Tue) 18:00 PT (reserved)
2026-06-08 (Mon) 18:00 PT (not yet reserved)
2026-06-09 (Tue) 09:30 PT (not yet reserved)
2026-06-22 (Mon) 18:00 PT (not yet reserved)
2026-06-23 (Tue) 09:30 PT (not yet reserved)

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
