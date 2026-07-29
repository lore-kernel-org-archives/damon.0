Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416A723ABBE;
	Wed, 29 Jul 2026 23:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785369528; cv=none; b=glqQ0x6hUmjTfr8fX243AEaRVyb5VQBY5NFPSOj0P6HWb7tKgGzwwO3V0WI8A4h9fFtRVrlZTIR+qRbsszrUzvDxbRVeYOVUwHJHvYfnCscxopld1aAhUaSycMn0KJ10XaioT3pm0yvfxG/Zrfd51h+0lrVi7TPQZ89AKbQX3WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785369528; c=relaxed/simple;
	bh=wXw/dqoOvjXmB1QkyJyDOZjGD+gHFDbfcr9XvkakBt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CITH5h0ztZmeFL/WEYxuj+584uWChdAzDTBnEXm5As7/fXVN8cmAZmW8dO7EfvKoHE0XNKmogeC/JOmbp/l6lYVQb0wKfgZra/6cAnpQeSsLpLRvboFOJstKeQVMPU+eTcvY909Axy9lkRyK5FJaHYIPQnl1oqZ3M5gMKl56RPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B48pzRbH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B48pzRbH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015B21F000E9;
	Wed, 29 Jul 2026 23:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785369527;
	bh=lMG9XAmDUxsCuNndcn5JjDOaQZspMJ2xjW59i1csd0Q=;
	h=From:To:Cc:Subject:Date;
	b=B48pzRbHUb/BDUQAljAcXJt9sU1hRGh2m+Em5JJJA847HEgPOQLaE6+Bm4+6MgqB0
	 geqEqVD32hBbQcvpciP2W1DkhuSJOnRkEx+qdEEIFLZxrfzfhiqWdYXYF/2O6pMS0z
	 +AuwddE3TcqJSDj8t9NVuOT2WkkKuQV9t3IP9sTaUDvxOdhS8XggquBBp3XFjGmiUd
	 Dr2Md6jt7kb1elj9Y38eUT6ZrAC9ciLb2wU/TnHLrTwRgsaxAg3rL8P3XtIyat8Kzb
	 fE3upX415cK8638olpgAHFuo3kqDG9E64AEulbLiXlAYm1N7opSq0uvUwKUztin1VD
	 nPwAFfz7WFmVQ==
From: SJ Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2026-08-03
Date: Wed, 29 Jul 2026 16:58:41 -0700
Message-ID: <20260729235842.99360-1-sj@kernel.org>
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
for the week of 2026-08-03.

As usual, we have two time slots for meetings in the week.  Next six time slots
are as below.

2026-08-03 (Mon) 18:00 PT (not yet reserved)
2026-08-04 (Tue) 09:30 PT (not yet reserved)
2026-08-17 (Mon) 18:00 PT (not yet reserved)
2026-08-18 (Tue) 09:30 PT (not yet reserved)
2026-08-31 (Mon) 18:00 PT (not yet reserved)
2026-09-01 (Tue) 09:30 PT (not yet reserved)

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
