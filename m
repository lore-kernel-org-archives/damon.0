Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE1E3876D7;
	Thu,  7 May 2026 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778142519; cv=none; b=BDH6iQ6Q7xhJKAQNPsOZs4sxSfN/uzkGd47A8l2QYIerTCFq2tDBAQuHy2txcSnCMit/yhsg3dI9JneHGH94u8Q6B0WIHd/SRRIGehPrYEW/a6MPJKzwdlmsLHlmQsRqMsnEZ0h8KoaGe0orQLxyugdlQu5H9giL4vcqnKQM2Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778142519; c=relaxed/simple;
	bh=xqpklrbR7ieOioYxjh3NJq3SfZb9K3qd09ghWsrlIVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sf1IPchxBPZ1k8tR70y7KlaaP75pQs5AOONg9scTV1ayvUiyVqUxk0PdTiXTlF2kX2svxoS2OURGSSBoHt4u7835p11AFFg1Jrrv6qtC+MoqnrUsKdWzXPKPL0jO+9AwituIkzqoNdmud3gT58Wi+DyBBhS6nK8b3vXuRSdO2Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiI/PiTn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiI/PiTn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AAEC2BCB8;
	Thu,  7 May 2026 08:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778142519;
	bh=xqpklrbR7ieOioYxjh3NJq3SfZb9K3qd09ghWsrlIVs=;
	h=From:To:Cc:Subject:Date:From;
	b=GiI/PiTnczInMT0qlaXy8HZLF9uhsvAR8n9NhWOlmwQ+7XLrc1TCmlcn0zBF14cOB
	 IsmXOonkLVHJhjvvOD1iUMn9FtqSRQ3Vi4ZJ75xLhlB3XdvaprO6rxfqm1MGy4inE4
	 9SKVt4RRQPWdFerd6z5uGbGqW2VbJtqkNggnuziQR1NA/hQ+NPoHJlR95HrYpRuxLV
	 Mxh2uTqIo6+u4mLGZ1X9CKVcOJzhgBZU4LKftR+vS8L+Bs70Qnuz7+erAe/1oUVjW7
	 F85KcBnH2vtk2P0QFZNNpBm5RtuoqVYppJkEScEvlMoVTnGoF2W1BBKezYg3cGTIyt
	 s+zqLLRAHCVWw==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2026-05-11
Date: Thu,  7 May 2026 01:28:34 -0700
Message-ID: <20260507082834.12043-1-sj@kernel.org>
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
for the week of 2026-05-11.

As usual, we have two time slots for meetings in the week.

Next time slots including six virtual-only ones are as below.

2026-05-11 (Mon) 18:00 PT (not yet reserved)
2026-05-13 (Wed) 09:30 PT (not yet reserved)
2026-05-25 (Mon) 18:00 PT (not yet reserved)
2026-05-27 (Wed) 09:30 PT (not yet reserved)
2026-06-08 (Mon) 18:00 PT (not yet reserved)
2026-06-10 (Wed) 09:30 PT (not yet reserved)

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
