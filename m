Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4DC10F4;
	Fri,  1 Nov 2024 00:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730419618; cv=none; b=DJFGVi4bFK9VS3k2dkeT1mknK+mfuSiHoW8fPRWmypnNaN5g9wawPq6BqHtR4eYAyIqnWKeAMf1QoKVN78aeeBrEs/ek3vXRm/wRnqtQkdzhURXFkcT0CijDT6aTUF+nUgMrgw7ZVuAJ+AgrUoURqcvM9r+CrqQXB1Pfit+ulk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730419618; c=relaxed/simple;
	bh=wpvGBmUGMH8GauYxH+rCYO2265hJO9DTbiWd6kguyvk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=di12u1ZpcQ49GxtQ8sButLMFaeCiSB/FWOdRqCdJ+dkYy8Y/HDWI6IlmEubSQhTz5FkWqISfMR5AAUJGnwCMFOAWFeoebRFBPPyJWwo8StNuhV4maCUNSvWIJwAwlL7t3yZeu/A7OZJys/Zcgv6jqE6zzt5xIk1CMrsMDVEEj2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n27pFNrf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n27pFNrf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FA9C4CECF;
	Fri,  1 Nov 2024 00:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730419617;
	bh=wpvGBmUGMH8GauYxH+rCYO2265hJO9DTbiWd6kguyvk=;
	h=From:To:Cc:Subject:Date:From;
	b=n27pFNrfxM/xBmxXbEo8IzsjQ7hk1pNwvBcOdFRCRUuVo2DL2Ri3TDmJA96sk4S72
	 x+lw/qbNmWTcjKGPduFz50om2Uf+2GIf94f3wpcpk5zFRBHPmp3kzMaTRq4ks5VvH+
	 CP9Bdrl15WqJaZe4WVrkkVLBp+/d0fius5ZKz0aq5xdeLRuAL2Q1rfC30yzSdI5UuD
	 ekDK0wEUcfYwJDgd8Z3ZDy6xuZqYAg6Wy+CE6jyQKdPmeE1Ksl0vUwD9koKNh4tO5B
	 yJ6t1gb+HU+kkNVHTOHHrcwdY7JPlUF/46sex1MP6qtrsqSJOc/obbakkoLVHrGgDc
	 zOWasF8NEvJQw==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2024-11-04
Date: Thu, 31 Oct 2024 17:06:41 -0700
Message-Id: <20241101000641.52019-1-sj@kernel.org>
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
for the week of 2024-11-04.  Please note that US Daylight saving time will be
finished on 2024-11-03.  The shared calendar mentioned at te bottom of this
mail could be helpful to set your reminder regardless of the change.

Dedicated-topic discussions
---------------------------

Next three time slots that I reserved in advance for possible future dedicated
topic discussions are as below.

- 2024-11-04 (Mon) 18:00 PT (not yet reserved)
- 2024-11-20 (Wed) 09:30 PT (not yet reserved)
- 2024-12-02 (Mon) 18:00 PT (not yet reserved)

Please reach out to me (sj@kernel.org or whatever) to reserve the
not-yet-reserved time slots for your topics.  The reservation is made in a
First-Come First-Served way, and I will send a Google Meet link to
reservation-confirmed attendees.

Please note that other time slots are also available based on the demands.

Any-topic discussions
---------------------

Next three time slots for any topic (no reservation is required) are scheduled
as below:

- 2024-11-06 (Wed) 09:30 PT (https://meet.google.com/ndx-evoc-gbu)
- 2024-11-18 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)
- 2024-12-04 (Wed) 09:30 PT (https://meet.google.com/ndx-evoc-gbu)

Shared Calendar
---------------

You can get the schedule via this shared Google Calendar:
https://calendar.google.com/calendar/u/0?cid=ZDIwOTA4YTMxNjc2MDQ3NTIyMmUzYTM5ZmQyM2U4NDA0ZGIwZjBiYmJlZGQxNDM0MmY4ZTRjOTE0NjdhZDRiY0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29t

You can also get the past and upcoming schedules via
https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing


Thanks,
SJ
