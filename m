Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803C835F60A;
	Wed, 12 Aug 2026 23:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786578413; cv=none; b=GFC4O5RI3iC5tvDKx6ArhWzZZN+mamPjjpyh0LCS2dfDud6rHO/Oh1c0/s3yx6f9FpIuQh//xx+7GIeeNiLLQWpWgoOtpE/5YF/pjlvz9q/SAnTq1M6iHIpoAUe0f//PTX31XhjSALDj31o084rlB+sN0ZongD48NGx3LQrfhLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786578413; c=relaxed/simple;
	bh=DZZx+EOKxfqj2sYWnxCOZgvDjApUUaMY1Px7GaqFxm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IXdVhQb3Cj6PD2j2Y4hx85mkJuHQadEVq5xrtWiNl+BmFnHCHpY8kPOBogC9joOTVLf7kj1VuxK1twQMSdkfP3utSgdwitfEgICObbLuKmTWvf13a9fEgE1bOn96nYCgojsnFMpTs7tY2mOXhdfDRQb7YqQrpFquxB/1r7rQwEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3RMi0eC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3RMi0eC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070301F00A3A;
	Wed, 12 Aug 2026 23:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786578412;
	bh=STEyH6+S+leLoTBGNeAGk1gjokdgn1DVinq83zdPlOI=;
	h=From:To:Cc:Subject:Date;
	b=M3RMi0eCmHEW/N9RfgKNEe6lXHdIEpNYSTepzFpTd43JcPRHvF72rm7oxbktz6C8t
	 bEGFGe4vm0RI4WHbYgED/j5dE99qxKuSaXE/QSZhAoWb2TpaxJZFTgDLhzRWTNkVXl
	 NpHZxoGScnkFQ3p+ztr9aVLvtBHRtimRI36vgyTh8Re7ZVwRXmFpcTsIz0MSI5UY35
	 zOajhk718/au0hw9wXd5dIFS9eOXetMSsQic1ejVNh4b0IMI1FFgIsM77MoKybHH/6
	 ZWzog07G1bgLxNDnkmSbWRv8xYLKs0jv2lnJMUFoXSF+FcyjyctTo/5J+3QWZgCLPT
	 Yg8PASndP6x0g==
From: SJ Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SJ Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2026-08-17
Date: Wed, 12 Aug 2026 16:46:44 -0700
Message-ID: <20260812234644.128198-1-sj@kernel.org>
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
for the week of 2026-08-17.

As usual, we have two time slots for meetings in the week.  The slot for Monday
is already reserved, though.  Next six time slots are as below.

2026-08-17 (Mon) 18:00 PT (reserved)
2026-08-18 (Tue) 09:30 PT (not yet reserved)
2026-08-31 (Mon) 18:00 PT (not yet reserved)
2026-09-01 (Tue) 09:30 PT (not yet reserved)
2026-09-14 (Mon) 18:00 PT (not yet reserved)
2026-09-15 (Tue) 09:30 PT (not yet reserved)

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
