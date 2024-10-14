Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED1115383F
	for <damon@lists.linux.dev>; Mon, 14 Oct 2024 08:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894168; cv=none; b=NN+KgQ3usse/xsP1v2zUurcsF2WOT7i3HOkJVdyP755qsnlp3wmEWawnwkNKOGO+ZCZGmBt8n8jwKsG6VCGxnvAZWx6WgIRbgWP+mTuHsmLF6ALj2cCeCd1Dlzmw/APPbJtu6fDM5WMY++m1AJlNUD5IFYUJBqNC60To7f250m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894168; c=relaxed/simple;
	bh=QMpDIDl8umoJdqVbBTfGy0XUBiUV/xPCM1ODVJW+QEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AK9VVUKl33j/sNJpWm+HydDjCU0fKjcTWnpNT+njl+yx2nLXk5PUNsDp1zRx6MNhI+PIKYrJuLF8Svl6d4v7N5dBSmQFfWuuSkSrvx3TQT/Dv9nC3SpXrHr4gHtG3JPIoW/jE6wlX+cggntdmAEqtNO969L4pPZ8corfjnwTkis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tdiau+xY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2py3lShc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tdiau+xY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2py3lShc"
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728894165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hzqGiPKzKOr/Twl2K0C7DsL38YQ5/v1OOfZz3SGMgIo=;
	b=Tdiau+xYkkTqIlZOuU7QbocyN3mWZ5cMg+9z7mvzIBXeJf7/egZmEdNUT4osS0wH+O9TwP
	NYrJ1281gIYm8V8xkpg3g+dd4Ye8HQ0xzLYVpkZ6LwqqpAfDM/WjqjtQhDVDxedtfETgVM
	O4tLZOCTFe1nf0EkS7Cv6Wha8snd6oQKk30YpOYTfJf5s4B22LOoFxlstGJUDZS2jwigFm
	VQGXw177tW1TOaGNEU18C9l3fkbc8iaXerdNhqNCbtfqurbpLyVS4ZaRRR5+k3izPPEjKW
	W8Ezpsyc8MuLlSgGao+CIXHSTK3p00J579HFm818pMrAV90NUAv5GQERFvFV8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728894165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hzqGiPKzKOr/Twl2K0C7DsL38YQ5/v1OOfZz3SGMgIo=;
	b=2py3lShcqxXqMh3SmT3Lr2IIWwIdLZub4OBrE1vPJUwleB5lhSTj/03xbr/IsU35J0MH0+
	e5/NuwaJhnQn7zBw==
Date: Mon, 14 Oct 2024 10:22:21 +0200
Subject: [PATCH v3 04/16] timers: Rename usleep_idle_range() to
 usleep_range_idle()
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-devel-anna-maria-b4-timers-flseep-v3-4-dc8b907cb62f@linutronix.de>
References: <20241014-devel-anna-maria-b4-timers-flseep-v3-0-dc8b907cb62f@linutronix.de>
In-Reply-To: <20241014-devel-anna-maria-b4-timers-flseep-v3-0-dc8b907cb62f@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, rust-for-linux@vger.kernel.org, 
 Alice Ryhl <aliceryhl@google.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 damon@lists.linux.dev, linux-mm@kvack.org, SeongJae Park <sj@kernel.org>

usleep_idle_range() is a variant of usleep_range(). Both are using
usleep_range_state() as a base. To be able to find all the related
functions in one go, rename it usleep_idle_range() to usleep_range_idle().

No functional change.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev
Cc: linux-mm@kvack.org
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
v2: Fix typos in commit message
---
 include/linux/delay.h | 2 +-
 mm/damon/core.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/delay.h b/include/linux/delay.h
index ff9cda975e30..2bc586aa2068 100644
--- a/include/linux/delay.h
+++ b/include/linux/delay.h
@@ -68,7 +68,7 @@ static inline void usleep_range(unsigned long min, unsigned long max)
 	usleep_range_state(min, max, TASK_UNINTERRUPTIBLE);
 }
 
-static inline void usleep_idle_range(unsigned long min, unsigned long max)
+static inline void usleep_range_idle(unsigned long min, unsigned long max)
 {
 	usleep_range_state(min, max, TASK_IDLE);
 }
diff --git a/mm/damon/core.c b/mm/damon/core.c
index a83f3b736d51..c725c78b43f0 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1896,7 +1896,7 @@ static void kdamond_usleep(unsigned long usecs)
 	if (usecs > 20 * USEC_PER_MSEC)
 		schedule_timeout_idle(usecs_to_jiffies(usecs));
 	else
-		usleep_idle_range(usecs, usecs + 1);
+		usleep_range_idle(usecs, usecs + 1);
 }
 
 /* Returns negative error code if it's not activated but should return */

-- 
2.39.5

