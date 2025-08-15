Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27882A926;
	Fri, 15 Aug 2025 21:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755294284; cv=none; b=IyWpimXuR8Pvr5U2VyPMfK85GGHpgRUvhMhGu0MqYUr4fojWfHdx4JuOI8qmaeOwfLbxqRLs4K/blSY0AX49dXq1yOnfp0IrBICF8AadHHW+aCPaTkIOGOCYFNwBGHgPrhOpBIkJzXj1kRXvvuYT/z3xdknAzKfYaZxzN+/5YMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755294284; c=relaxed/simple;
	bh=w8bI3K06v5qE0O96wS27g3AHvYkRCqTbCUA44CgzYFw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lApIPdTD2q5pJbE8t6xF/g5XgaFu+AaHQ4Y++5j4ZCiVjr6Dre/HvjsFOaOXfe0WCvMxzInE3MX/TeNcsINoehkwKqtX+JQKzgGI00gehcfTgkCChPLRYIOdeOpIOgEfaMH7rB42cJo//U5cVs41Om9j9+B8oBqfC4Vt4PYfMh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvJKmlGo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvJKmlGo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4E4C4CEEB;
	Fri, 15 Aug 2025 21:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755294284;
	bh=w8bI3K06v5qE0O96wS27g3AHvYkRCqTbCUA44CgzYFw=;
	h=From:To:Cc:Subject:Date:From;
	b=MvJKmlGoGPC3SoPcH3STEEW7WDVtuMET4SzWHzRaP99yr+4AfL17RZ0G60aMb5OsE
	 COmi1+feMJWR91MG3PCVj/RoGLw7h5HxBcY2QwKWNzxS9SNmq3rPCD60Gdfbfs79L0
	 zzftKzqvFWf3uHcaAchh9zYTpwkr86igzFIXGcMnYU0/ebksTGEkRXPNHeW7Xz6KQC
	 pLu7Jz9xn7602d8cxWvHV6SpVVsdd+J/V1pMw4rfULFicjFLQx9EkodGy+PBFtpH2g
	 zTxZERDHYKcUcu/h0uomK01YAu1Tg5SFX0Z8T4HDy3WjrRW0awlAQc2lFsEPE7n5+u
	 N+TawuTomJMnA==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2025-08-18
Date: Fri, 15 Aug 2025 14:44:40 -0700
Message-Id: <20250815214440.89592-1-sj@kernel.org>
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
for the week of 2025-08-04.

We have two time slots for meetings in the week, as usual.

I will skip those for weeks of 2025-09-01 and 2025-09-15 since I will have a
travel during the time.  Feel free to reach out in any way as usual, though!

Next six time slots are as below.

2025-08-18 (Mon) 18:00 PT (reserved)
2025-08-20 (Wed) 09:30 PT (not yet reserved)
2025-09-29 (Mon) 18:00 PT (not yet reserved)
2025-10-01 (Wed) 09:30 PT (not yet reserved)
2025-10-13 (Mon) 18:00 PT (not yet reserved)
2025-10-01 (Wed) 09:30 PT (not yet reserved)

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
