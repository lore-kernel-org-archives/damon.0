Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E1084039;
	Fri,  6 Jun 2025 21:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749244711; cv=none; b=i0zK04BGeLsMn/qzg9SMY+LeNA2ahQ1pDZ5Ex8UpwqH+gNuOplwaKd3dF/TVi8eCh90Nu3pqAPtqwies6/GBKTQ4FvZ1d2JiAAmFryywI9bRIXd+cAIWKUOMpElpRYIU9RYXIRBLtPMXgfaoe2JUmPJvKEiis0PVOhlIQX2oxRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749244711; c=relaxed/simple;
	bh=0QrLvxsZfMZZ2xtWxbnQNPtiR4r333EEtdRKJX3mtag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hHtG3dsONEk+gAn8P/abVAHWRoiuAVkTJ+NZXVVFPajrWLBNqbISTbShpNfSu+PZhV0X9F8dZzQY5JljQmyn9+WFbfu8hwRVdTtZ4FI5VJ/9a9V/Ye9wbd2fkFp4e3+5jo/DkrYDimt2NLilv4RHSQ9OhII0gz3G80Xknm2jmmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9Ii3qvU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9Ii3qvU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C7FC4CEEB;
	Fri,  6 Jun 2025 21:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749244710;
	bh=0QrLvxsZfMZZ2xtWxbnQNPtiR4r333EEtdRKJX3mtag=;
	h=From:To:Cc:Subject:Date:From;
	b=C9Ii3qvU9F3QpBu4hk6+YQa8lrMJB0xCLcDfHpKYEuRkaQQPa355nVFzhpN4rupO1
	 6GcHVT47LLm36n7wTuEeV6l1lMa2xVjyc+awIAlXiW2icPaQWtqInisb6loFA1SwGS
	 4ohnP6j7su1i86AsjMK0Wr+9BBIk5GMUi//4ks4LDe88TsWhc9nm1aaI1l17hCbx49
	 Tu32fxoyHJoZQxJJbIptExRdldDpT7pN2U5v8iuTCA7a0aNQdOn2niCQnvKvL9davI
	 L8gkJZvj0TX03CXNqx7OTAjEDK8+BgYS7tzIkRGdhA8aQBkgmzvJYdv8V1bRtaeJst
	 dwovjY9yHGbRQ==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2025-06-09
Date: Fri,  6 Jun 2025 14:18:28 -0700
Message-Id: <20250606211828.170560-1-sj@kernel.org>
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
for the week of 2025-06-09.

We will have two meetings in the week, as usual.  Note that the next any-topic
discussion will be the last one, since we decided[1] to merge any-topic
discussions into dedicated-topic discussions, and received no objection so far.

[1] https://lore.kernel.org/20250523225255.61464-1-sj@kernel.org

Any-topic discussions
---------------------

The next (and final) time slot for any topic (no reservation is required) are
scheduled as below:

- 2025-06-09 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)

After 2025-06-09, no more any-topic discussions will be scheduled unless
someone requests.

Dedicated-topic discussions
---------------------------

Next five time slots that I reserved in advance for possible future dedicated
topic discussions are as below.

- 2025-06-11 (Wed) 09:30 PT (not yet reserved)
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
