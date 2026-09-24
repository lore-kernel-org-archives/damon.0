Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FF041F7F2;
	Thu, 24 Sep 2026 08:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790239396; cv=none; b=jisq5b/hw2G1uhtTbkKk4WhR5SAI+VnpLic9qz/TdGzNe8o7IQ30270y5MyYYFmBdwLaxdXGMJXyHqfGOdLUbswOu/3dDlfY20PFE91zH7v8BLPWC0gJOjqEC8Jg4l/Iu3UG4O+qgYZdfKkdv0fOR712V1gkf3ZfZoWlgdSi3t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790239396; c=relaxed/simple;
	bh=ao9A3C4ZW65ml5Wn4KQpaGhMDAAiKaF8qV2U/5JqGQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyW4V2vi3LrYAg3Y8DhfNeTxcBZRC40uheYFESZ6yLtQO0Zl3YuFYu40+XTS6ILexjfDD6K9y/bN6TuHjI8LVZl1/ON3h2ueEkyQz+vsp4r/hrOhxUcQUikfbdhSTUOqLvclm9z1HtCc4nUT2u5CmbljkdQJMNwv+xU06vFANKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCTnzgxu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCTnzgxu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED701F000FF;
	Thu, 24 Sep 2026 08:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790239394;
	bh=hMq8QR5h18vm/WWPf2tv3W8LVB5hO9oSgXVqugErPLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JCTnzgxunf1khUtNUynT7epEs5UcIa8xdYGplAoe/vycsrThaCYfYntIdqXoFEAKW
	 lBDIjgIe8NVsrE7Yu2MwTZbFZW+Ho97F+HBTQb5DoVEcIaSIUrLM1syQsy7zx33yQq
	 lRyRTuxbZFUgf5YyiN330R3QtZPXh1W7skajl6IVT57BMhSvnbWqcF7LIvjJ/UlME2
	 h1dcg9EcFXe32LxIKbOulNNJkPjkufRH2jXN9ztEUJ04Xr+O8ArD/5NAWxMko3Y3wm
	 t8P7I59BbE3znMwZIlfgAm2pZMhz0lA1VQ630PKdoaGiWqndt2y0Ma4Jo0iYdqZUU7
	 CrnmRENEuCIDw==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat reminder for the week of 2026-09-28
Date: Thu, 24 Sep 2026 01:43:11 -0700
Message-ID: <20260924084312.3773-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260924083912.3464-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 24 Sep 2026 01:39:11 -0700 SJ Park <sj@kernel.org> wrote:

> From: SeongJae Park <sj@kernel.org>
> 
> Hello,
> 
> 
> This is yet another reminder of upcoming DAMON Beer/Coffee/Tea chats
> (https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing)
> for the week of 2026-09-28.
> 
> As usual, we have two time slots for meetings in the week.  The slot for
> Tuesday is already reserved, though.  I will also be in Europe in the week of
> 2026-09-28.  Changing the time to CEST.  Next six time slots are as below.

Sorry, forgot updating above paragraph.  Two time slots for the next week are
available.  And we will use Europe time zone for the slots.


Thanks,
SJ

> 
> 2026-09-28 (Mon) 18:00 CEST (not yet reserved)
> 2026-09-29 (Tue) 09:30 CEST (not yet reserved)
> 2026-10-12 (Mon) 18:00 PT (not yet reserved)
> 2026-10-13 (Tue) 09:30 PT (not yet reserved)
> 2026-10-26 (Mon) 18:00 PT (not yet reserved)
> 2026-10-27 (Tue) 09:30 PT (not yet reserved)
> 
> Please reach out to me (sj@kernel.org or whatever) to reserve the
> not-yet-reserved time slots for your topics.  The reservation is made in a
> First-Come First-Served way, and I will send a Google Meet link to
> reservation-confirmed attendees.
> 
> Please note that other time slots are also available on demands.
> 
> Shared Calendar
> ---------------
> 
> You can get the schedule via this shared Google Calendar:
> https://calendar.google.com/calendar/u/0?cid=ZDIwOTA4YTMxNjc2MDQ3NTIyMmUzYTM5ZmQyM2U4NDA0ZGIwZjBiYmJlZGQxNDM0MmY4ZTRjOTE0NjdhZDRiY0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29t
> 
> 
> Thanks,
> SJ

Sent using hkml (https://github.com/sjp38/hackermail)
