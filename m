Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261E378C9D
	for <damon@lists.linux.dev>; Wed, 11 Sep 2024 05:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726031636; cv=none; b=rr1IaykINwyQTGTtXQeKqQJAhzIwYqtow0cNmUtHix8ixVa5LnEX9BzfIuRA2NoQlUyXGGESehnqExCixlpBUoE/TDAKXOtKv46V+EbOOu7Tlj7EzJStGBBjxez3xu8zY8I1j+8Oov6huyhQLKs1tZzE9xZu5UOg/ba8qyHFcF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726031636; c=relaxed/simple;
	bh=slPR/XUl9n4yCnGskGvmFLbw4vNgR0nqofOb59d+i2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C1WXMBs0YbCMCtcDSk7DRnIJZWadL+RK4bmL/sG6neCUDMNS5rl6U30fr2Z/oIwIuQHcNKik7E2jD1k0swrxqUKe7NLVyg1cGdBKC3LlcOyA90Go0Fyzh2dqhCSvFb0Z17wJcrrxr7Y0xcy7l0EITxSXYeuaRi2HDkPi74zP9oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tZ7Jo8+P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FLfAgtOq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tZ7Jo8+P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FLfAgtOq"
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726031633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z6vDQ8OrtE5tfTIWOA9AkJWnV/XdCc+NosMWCRhCJCs=;
	b=tZ7Jo8+P/9B40FBGihKmE6n5MfupBcXrXJ0RzEgsKoQ+IY09Fnp4IHAMQeJD2A2EPG0Dh8
	ixHIMvr2nMXTiuFzRYuKAnyaF+mDTFQYcWZej6x2al+8hQwT701UWn+yk/G3vU9+G0038T
	NlfHzHhMaraRZgoNjRFbrByExUEdzjy72WHp61JD6tC4Tcnr+VtcLldy+czOmrvCeDRW7n
	L+yClvg23Cq3DUrsYlyzfqsA4OEQ2xu56oRfqp58gHzklFVBzm5n8o0Wj/hq/zNrheE2ZA
	GUFDMgUtZbGWsMpCiYhK0ODGPi2zpiTiRPWjNuXPWE//3hT7YQP2If0jtZmSMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726031633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z6vDQ8OrtE5tfTIWOA9AkJWnV/XdCc+NosMWCRhCJCs=;
	b=FLfAgtOqurk66aa8g8iQTkdDuocQxfo8snrO0+LncEvZ+h8IjnLSVutdhxUA1cZoWccM7y
	sgFxwKMnEsrBA3Cw==
Date: Wed, 11 Sep 2024 07:13:34 +0200
Subject: [PATCH v2 08/15] mm/damon/core: Use generic upper bound
 recommondation for usleep_range()
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-flseep-v2-8-b0d3f33ccfe0@linutronix.de>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 damon@lists.linux.dev, linux-mm@kvack.org

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
---
 mm/damon/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 94fe2f1f9b0e..4b971871da75 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1883,8 +1883,7 @@ static unsigned long damos_wmark_wait_us(struct damos *scheme)
 
 static void kdamond_usleep(unsigned long usecs)
 {
-	/* See Documentation/timers/timers-howto.rst for the thresholds */
-	if (usecs > 20 * USEC_PER_MSEC)
+	if (usecs >= USLEEP_RANGE_UPPER_BOUND)
 		schedule_timeout_idle(usecs_to_jiffies(usecs));
 	else
 		usleep_range_idle(usecs, usecs + 1);

-- 
2.39.2

