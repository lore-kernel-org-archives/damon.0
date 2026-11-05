Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793850841;
	b=BhEBHKcG+q4I7D7/9q5mBHGbGcjNnlVBzVhdGLDx6UcjyjUFs9GnRGWNpwj0Y4opwdNw
	 m9ePCJEFe0KE946HiBeoUTDQdyoOcE4MHecbIT081L+22oJZEkA/g82Zh+BNZSJCOBUiF
	 OtumaefY/uhRI4frzpSjmq55cRHYWazFdYfPr7e7MhOMaMsIZ9EW9UyYQ1B2637xPqrGf
	 nUlPrfH0kYKSBw31j/HI53lt39wdu2TKy14tJrLOzIxE5YROPfXU/iohRk3jB7M3iBLQp
	 xfBHFPIB0ufGt24ybS/Md0o5uzFhO+V3zG7FQxjquGMOh8Wfu7iZNPFJr6ys8IpFexQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793850841;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SyYtWJd8HkAgxcNPjNyLkkcWf3ysT6ZQbYCzKJBembs=;
	b=t6+yR0wmxDNua7boNxSwSHSPtujWh96M/j24FqehzZKOGmUCG/+nE/9KXoz5vztTQfM5
	 wGhyzzG77qLQ1UwftB5igVMI2gOCpsV08y9XXn3EGy9l1mHDNCJ12mB/2MCVt7Ogt4VAo
	 JjDMTHtRZY1+olWFPMISNw/6Nb+chAa+5K0vo7wzFEclxu3yg4Q62BbEjtOKj0GAaOKf2
	 S/guel6x5rWvMKBYcnBLgMuM3zEmOJoWR5DznNa95XYOennOquY1/ssOM5/Z/Gzkqrm71
	 iVfmyVnnLRvG/F9ARChrGv0l1TNy+SMGvZZq3QlP2ML7Vl4PFOH2htDPLVkaFazm8Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CKNMIQEn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5134A606A31B;
	Thu,  5 Nov 2026 03:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CKNMIQEn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9411F000C1;
	Thu,  5 Nov 2026 03:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793850840;
	bh=SyYtWJd8HkAgxcNPjNyLkkcWf3ysT6ZQbYCzKJBembs=;
	h=From:To:Cc:Subject:Date;
	b=CKNMIQEnnhY2QbBFROUSjMbFm4V6oQxsptiUgzTk6dVdjhi2uYuTS4ff3jB9hR5oy
	 W/wxI8iRZf7DBrvU6GoQG0jUOucDRSBO2c0frGqlSDwr1ahnr1S7xe8ipj3mIMpzg+
	 e/rH+4AjJgxdXDywJpm8kA7czou+8ouTnIG6VyKKmgiOsI/4RCrXeK047OugyJTD61
	 AEFsEYMUpMoSot8eE9LrM0JJhjNi/3NDDO7R1+If40yEDjxpruOz/z5WtMHS+GpGcI
	 /wPZTIt0/p636/wryBwY39rkt7fdDfnfX1k3xe86AUOqOaMDrQMYOq8dh12c9HETbx
	 G+LAsg8gtwtlw==
From: SJ Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SJ Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2026-11-09
Date: Wed,  4 Nov 2026 19:53:52 -0800
Message-ID: <20261105035353.89667-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,


This is yet another reminder of upcoming DAMON Beer/Coffee/Tea chats
(https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing)
for the week of 2026-11-09.

As usual, we have two time slots for meetings in the week.  Next six time slots
are as below.

2026-10-26 (Mon) 18:00 PT (not yet reserved)
2026-10-27 (Tue) 09:30 PT (not yet reserved)
2026-11-09 (Mon) 18:00 PT (not yet reserved)
2026-11-10 (Tue) 09:30 PT (not yet reserved)
2026-11-23 (Mon) 18:00 PT (not yet reserved)
2026-11-24 (Tue) 09:30 PT (not yet reserved)
2026-12-07 (Mon) 18:00 PT (not yet reserved)
2026-12-08 (Tue) 09:30 PT (not yet reserved)

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
