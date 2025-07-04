Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C307B2E370B;
	Fri,  4 Jul 2025 21:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751663973; cv=none; b=bdUnyj3XKHeVaVRLaWU3lODwIpD2nGToIu/55AIhPyr6qyGD8GIp2h6Q1twGEFaQfrtRSLZlwR5hTlnIz9zPx4JGh9XFMRMFfggugPaDcn+ZJAJgrNhcyT0AlWFqQlnoXgw4zXQbVe/mYFPu1gCfAHPud1FcRjKEkFlFgxBbF6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751663973; c=relaxed/simple;
	bh=LrtlwVu5XvZ/Gc8C8JMOv634lMY9wMduJ/sXkeUfLt0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UXG+oxHt2dkeOTMuSqGf0qcEnP4Hs49CFt2RLFMwI3famc/LTgVi5punN4aCaGLA1rnzz1spGgU8rRcvHdxId8Umjgd+bu/8/lKW96aYvU6B7cGQF8wmOQsGgU7BLCslZWOWMzJ/NCM70SE13CEu3S+4/XgYCIXorT42Io/OfX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QO8YJyMv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QO8YJyMv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171C8C4CEEE;
	Fri,  4 Jul 2025 21:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751663973;
	bh=LrtlwVu5XvZ/Gc8C8JMOv634lMY9wMduJ/sXkeUfLt0=;
	h=From:To:Cc:Subject:Date:From;
	b=QO8YJyMvuZy1REYqQrznSSPDJKThfG/4xrYir+Ku4pRjt386YAYAF+ElRk9f7VSJG
	 yxvG9ORQt7KO4HwNA8ABHu/onEg19JfkcFHjVcMI3bNWDUNhy/JcLeWZG/+q6E9EFW
	 4bvRLSmFT5D3SY60dibxyPjQONrA912kxGoABovQ+kARqmxngOYBhRu07FxsIpi6pM
	 xfMVWwet8kYUIN29TApkiajgBBdTQVkSLpsXt9/O4OgRdpDhFLFylUyjTzYjYaGqvS
	 HXz5N7FWzi7d5xuW0/xUDBPlLOFIebSQ8olLCEV1bN6i5FGPH18sTEsTj6FSDVUpOz
	 bAkFugU/M6QXg==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2025-06-23
Date: Fri,  4 Jul 2025 14:19:30 -0700
Message-Id: <20250704211930.23109-1-sj@kernel.org>
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
for the week of 2025-07-05.

We have two reserved time slots for meetings in the week, as usual.

Next six time slots that I reserved in advance are as below.

2025-07-07 (Mon) 18:00 PT (not yet reserved)
2025-07-09 (Wed) 09:30 PT (not yet reserved)
2025-07-21 (Mon) 18:00 PT (not yet reserved)
2025-07-23 (Wed) 09:30 PT (not yet reserved)
2025-08-04 (Mon) 18:00 PT (not yet reserved)
2025-08-06 (Wed) 09:30 PT (not yet reserved)

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
