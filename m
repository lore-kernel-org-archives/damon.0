Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339CC3EEAD0;
	Thu, 24 Sep 2026 08:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790239157; cv=none; b=sRq3ctxekCf11jBmI6FDYaHzW0ckXYCcjDqVl5YbpwMbsDuPDu/HqcsZfFNEmYgymMsxlvY5/xtL5ZgpDF/EHhqExisFhNzNUgOWS5kPGq0KduJpoG4qPi07Ri8bGVA83H+BL0+aVgz+KATEij3+DHrpk7ygEssHm20XQpihwa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790239157; c=relaxed/simple;
	bh=S4c+/bmaGgfz3uWgtzXhdA0PqaZdZtjKLDBaRYQNae8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mQv6r/fbK9WK6N8nOQXyu9AE3m+DHru0y67YRsFPm/hmFQgBq7YFvZyTyHZINMOu3ngAlHfakcg7usJ0HaV9cpJosu4Qkz1T7PMke3uFVho/mjnveZUA6PAlY+VfGiGPtvNxMOVpv+D+JXSpbHtKR+CryBhIbrqy8jDa+UVGccY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJaLWzWo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJaLWzWo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74DA1F000FF;
	Thu, 24 Sep 2026 08:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790239155;
	bh=DUq4tGaO0XgV7gLkA9KRgzuKApXd4+gn0m0gS9k1Cj8=;
	h=From:To:Cc:Subject:Date;
	b=GJaLWzWol9L0JtsIAb+i5Wc041CkEFDHTJ7tOdZO46kJeT1AkJ1tHegF210T+K9f5
	 ONNmIm7qTs2zNKKFWlk4tYJfRO6iV5B5tm5gzGJ0aFNWFrQ/GrGerCJbqWecLd9tfO
	 HqeMrW/J/gU8NQENyXDj/EYMcJghq+OoZETdT48c8gvdGLKOn+hrnn6MDQadc+mA9m
	 NGyuJiAEEMk23fQwhZwnD8NjRvaPnJ1p6dEZqwnjZ43m/sRtNd+PSBwCvo5xk6k/cN
	 rnwsfdxQMey6+EHiXwGpmXXI7shytME+SDNrU70CLuCkuY4hiTUY0LleO+to7ktWrZ
	 M6G854jyyDCEg==
From: SJ Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SJ Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2026-09-28
Date: Thu, 24 Sep 2026 01:39:11 -0700
Message-ID: <20260924083912.3464-1-sj@kernel.org>
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
for the week of 2026-09-28.

As usual, we have two time slots for meetings in the week.  The slot for
Tuesday is already reserved, though.  I will also be in Europe in the week of
2026-09-28.  Changing the time to CEST.  Next six time slots are as below.

2026-09-28 (Mon) 18:00 CEST (not yet reserved)
2026-09-29 (Tue) 09:30 CEST (not yet reserved)
2026-10-12 (Mon) 18:00 PT (not yet reserved)
2026-10-13 (Tue) 09:30 PT (not yet reserved)
2026-10-26 (Mon) 18:00 PT (not yet reserved)
2026-10-27 (Tue) 09:30 PT (not yet reserved)

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
