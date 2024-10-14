Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC530155A5D
	for <damon@lists.linux.dev>; Mon, 14 Oct 2024 08:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894170; cv=none; b=end8j0fiTQo9WqNbOPYkysHdbYadry0VwFwHblAaPDov6LSJcVM6JgUJ5jGkrpY7iBZKWBVqGra7XR9eALMttTsJD72KvYk5D14q8eoY21at5IzAv1/UFy75NxGQB5oIYdwwdK1LBgmoQNALtljadZnDvZoqfRrCCglR3ditS/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894170; c=relaxed/simple;
	bh=Bf62MSjNCcOsUnnQm2kzh16d6CLGiUEI3eiVV9t9Owc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lahOfdGA4SuyCKOGfrSGR6dttDoxh3TIlyNE/V0YAx+70SQW/85o/jxJVMvLq59KpWZSEHx8AfVz1owzn0hrwVmwup6A550vXT3pp9diY4R3UIJvliZSjkoVa9mu67GALKnWuSRChS9g2h8lP0eg3jiPpIpUrEjvlnPULlckeIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B/aSrdnG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S6JiLyI3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B/aSrdnG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S6JiLyI3"
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728894167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qOaH71wwpXdQZek5RpUCzVvDQCRluMekHdCjKOEhMjY=;
	b=B/aSrdnG1hdrhqCf9Doxt53XdUEPd/DsqfCqfEtXm+sXaR4YxaOBvD/4G4k6gEJsLkPqNI
	vHi/uKunKriXr18pR5F29McrnstoIfhveWZg3Q9z3Lafph8GjeECPp6qWNwz+orsvPcojr
	Snx7csQhHtS1I/k/YSb+dPc2+vClJeJ/Z/M94B8lycT7WPEvSY3DnwB5ND44BUhPWtm7fc
	5SbflHJua9/3ny+8zX2+wvL8ioeRogGZNozMCMjJDw9WJfWDlsKzeLlmGzBXOqcHiuQjDw
	Sh4zc4d6RRhGSRWRewxwX+yWhSDZeoxCFlye9hXYxSs2XZskPwA3I1nondd8+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728894167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qOaH71wwpXdQZek5RpUCzVvDQCRluMekHdCjKOEhMjY=;
	b=S6JiLyI3D4+gyIiCjKrWzIAm4jv71/fdJjVfoPCojjq13xGDDrzi/OlrF6cyHiZaMmx4Mf
	8Fn1cpiVDmJEzqBQ==
Date: Mon, 14 Oct 2024 10:22:25 +0200
Subject: [PATCH v3 08/16] mm/damon/core: Use generic upper bound
 recommondation for usleep_range()
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-devel-anna-maria-b4-timers-flseep-v3-8-dc8b907cb62f@linutronix.de>
References: <20241014-devel-anna-maria-b4-timers-flseep-v3-0-dc8b907cb62f@linutronix.de>
In-Reply-To: <20241014-devel-anna-maria-b4-timers-flseep-v3-0-dc8b907cb62f@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, rust-for-linux@vger.kernel.org, 
 Alice Ryhl <aliceryhl@google.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Miguel Ojeda <ojeda@kernel.org>, SeongJae Park <sj@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
 linux-mm@kvack.org

The upper bound for usleep_range_idle() was taken from the outdated
documentation. As a recommondation for the upper bound of usleep_range()
depends on HZ configuration it is not possible to hard code it.

Use the define "USLEEP_RANGE_UPPER_BOUND" instead.

Cc: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev
Cc: linux-mm@kvack.org
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 mm/damon/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index c725c78b43f0..79efd8089d6c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1892,8 +1892,7 @@ static unsigned long damos_wmark_wait_us(struct damos *scheme)
 
 static void kdamond_usleep(unsigned long usecs)
 {
-	/* See Documentation/timers/timers-howto.rst for the thresholds */
-	if (usecs > 20 * USEC_PER_MSEC)
+	if (usecs >= USLEEP_RANGE_UPPER_BOUND)
 		schedule_timeout_idle(usecs_to_jiffies(usecs));
 	else
 		usleep_range_idle(usecs, usecs + 1);

-- 
2.39.5

