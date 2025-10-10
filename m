Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9132FA0E9;
	Fri, 10 Oct 2025 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760132307; cv=none; b=Lfvf+yQ4k6LponZmri1SzXVvejeTK6cAo0C5660htDAWxW2/V92+WOhr4Jj6MUArAVuAa+pITW1gb3n364UCeR+mlp2vFFoYVPypNrAFykWpeitAH8lp5un8CqGc4aDtYEidcB7B0gUc3NLeMQELP2vLvPtYdiKfFANyRIQ+vJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760132307; c=relaxed/simple;
	bh=8OpDKQnSM0NrVzRcvtxCdJM6gCY5wpRNmlgvpcWQ47M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ppaPF8LNgrBFatYjX4Ifaj9PfiN0G7e+I1nbullqkWzvjJiiQTLrq0Mc7MCJxxhJyZnILwiTwMwY+2lHxJiMZrmsK4Rf6bfeBIFhW4cBrFc6grrMfuEblYNYtMxtutH1qjplxYVaXYvyY+CK1YW3IQ0U05/1WMlaI+vLROIp5kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLQyJZIo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLQyJZIo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211E3C4CEF1;
	Fri, 10 Oct 2025 21:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760132307;
	bh=8OpDKQnSM0NrVzRcvtxCdJM6gCY5wpRNmlgvpcWQ47M=;
	h=From:To:Cc:Subject:Date:From;
	b=kLQyJZIoHG2zHO6pSGAjhApaLRjcMyS4i2E3SHmYG1DSKbBK2gwDNosLvHAKyHYO0
	 nYidffdzZWYyG8KgHsPRearYuUiyYhQU8XvUW7fp1lyxcoHJps7zkVwY+YnEsoJcJF
	 bHHNf6oYKgvW1+UK8B3sf5I0FC1fnurGBk569gmYZuIYTMhRitl7hTza4uyn8iItC8
	 Bl3Mx7oJCfEAkqlSsysPl1ubtbJ5r8Rpct/QZqeOTx4abmjfKIjjuMtSKO2hdtmEQ+
	 9UmiiXKqFE/hZDyGECuqDrfMNNyOUuN40j3oRG9hmu3Deh/htdw1g4freUzoQer8y/
	 pw2rf7k4ujIkQ==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2025-10-13
Date: Fri, 10 Oct 2025 14:38:23 -0700
Message-Id: <20251010213823.59564-1-sj@kernel.org>
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
for the week of 2025-10-13.

We have two time slots for meetings in the week, as usual.

Next six time slots are as below.

2025-10-13 (Mon) 18:00 PT (not yet reserved)
2025-10-15 (Wed) 09:30 PT (not yet reserved)
2025-10-27 (Mon) 18:00 PT (not yet reserved)
2025-10-29 (Wed) 09:30 PT (not yet reserved)
2025-11-10 (Mon) 18:00 PT (not yet reserved)
2025-11-12 (Wed) 09:30 PT (not yet reserved)

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
