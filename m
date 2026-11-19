Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119118;
	b=T37wlk3ErlAzfpbF/fqtsUaF40CNY1LbNPQA5wu4o5WmWKd/T8MRv5EvUcB3T0MR/3XX
	 JHKux8SJGuD9afKEieXv46wHhN3nUMyPWkzSaqMyQcXaPC4hes+Kuv0S3f/wA8tNwQPQ+
	 Iacc5xUVsSSiINnvTwOUY5QNeWgSsMn7ts+iaJLhJBKZh1SE/8NyUqO+Y/3qV9EUbFRFT
	 bxyIUSHxrJCSYl0nxCSTrWH1Uw9fjkXvX6zECLIz3vwIP9QKL1UY9TFm9KiavvUaEewJU
	 bQ7tZzkz5Czogur/tc8v1WwV5+nD2rp5LoL5YkKPJYiPVLwJFagI/sq120zC6hNqLIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119118;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kdpYcWkYOK7qIBcGPyFrGE+aMeLsucfyxt+AVbDijN8=;
	b=iMxbgYKaobkR83Pmlk/XC0tkhShq6+p14/1k16kaiWVvIqaCiUYq+IpCE+zshJ6ciL8c
	 HcoOzGsH72jLPWUzYleICi8XKSLTO/kYBvEB09jQc5eEzn6+Kfv/Cwq83OIPCknne9fKm
	 F/x98wTCnCCpI7Ygi0z+Y/J0e6sDC+HRE0oQu/JOCcxCGh5YLpmp1ac6+mLCoe9DemRIS
	 Ylm5gaCLH+pUsoa9vTKNVAS1Ni1AW0mtbs7wHmXbVSc/3WhfxTniDTCaSgy9AAwQZUB9n
	 zHs29lAAMdypJJ78CY/Brn0qHGRKxuOHqMUEfNrUpPJPqfpXcnGqA8DdCiiP8z8pDCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KN/V8eP4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BC4606A320;
	Thu, 19 Nov 2026 20:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KN/V8eP4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BA21F000C4;
	Thu, 19 Nov 2026 20:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795118621;
	bh=kdpYcWkYOK7qIBcGPyFrGE+aMeLsucfyxt+AVbDijN8=;
	h=From:To:Cc:Subject:Date;
	b=KN/V8eP4q5tJkrGmCGhhLeBZxnOSMDutKAZuIwiS+Og2wHsAKijw5WOuGwrrjnfIO
	 Vi/aeTrrEEbsh8LtylKdacVoI6UxC/52Srsv+Q1QdewLatlFqCnZS6PCPIh4Xz7SD3
	 OEm+sLxGoTZ7TSpplO0r0xPVqar3wnA64K0aWN0MBRRh571+zh1Q0X1AA7AvcXtzin
	 AHHDsnqe7dVxBaQXRYXziq+BiS9Ip5f+OBXbRSHXv5OSJyqGKXEy0bqtt2ikgTAJtp
	 k+xB3iWaDDQLyhpR3M37rJpZwmu6+Kuc3VRtM5HZZDnCEpZBE+0lnU3EvbkiiqUOgv
	 LFYLS5SkBexlQ==
From: SJ Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SJ Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2026-11-23
Date: Thu, 19 Nov 2026 12:03:33 -0800
Message-ID: <20261119200334.83935-1-sj@kernel.org>
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
for the week of 2026-11-23.

As usual, we have two time slots for meetings in the week.  Next six time slots
are as below.

2026-11-23 (Mon) 18:00 PT (reserved)
2026-11-24 (Tue) 09:30 PT (not yet reserved)
2026-12-07 (Mon) 18:00 PT (not yet reserved)
2026-12-08 (Tue) 09:30 PT (not yet reserved)
2026-12-21 (Mon) 18:00 PT (not yet reserved)
2026-12-22 (Tue) 09:30 PT (not yet reserved)

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
