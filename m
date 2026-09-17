Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB054B7A3C
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657626; cv=none; b=Ux0ECUHAcqyZjugXcy14rTDAk5TGRJ5spR4PzMa7hYrboQmdZ78CH13Ws4GfdHLvHEoeSjHajeLF+lxvjcU89upHL267Zj5PPpzSVJoDS+sj0bDEHoO8MFdBuxsEh8woGwY6XvkHICREpF5/Rw27y0msEjV0rFFDEeaf5dRCL7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657626; c=relaxed/simple;
	bh=mQAoM0VPcy2oVkQZSz5EAfz/VbLzU1q/KtRiLhP3gXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jVlDE6YzsjCDruBJx6XD2u5cc/evxLrMxBJy8pJtRrMyrRCOzFAGyflI/V/DD6r6UzQPVLhagVCayeQ+BBShQyI8ECTQF+QAGFgEkXGBnUWg/lsCABcKKgZOspDoNxtynpwFcP7YDYtvtSAmtJOh8ww1a2sCyyGTe+GyB/KbOr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhyEyC35; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhyEyC35"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4bf948737e1so648826b6e.2
        for <damon@lists.linux.dev>; Thu, 17 Sep 2026 08:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789657603; x=1790262403; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1zHs5HAyUucVjtHvZt4rt64j5+dwbb1H5FeS2taXPLw=;
        b=nhyEyC35p73W84JTJjtKcJV92wFiO5AsG+/9RnKKFS49FsjZiuF9uDBHD5P3Er8P82
         4QSEPFnu2pPbm6U5S9dfSif6ANggsmEXu8m/C6TQUvaKgxOjiI7f9uMNH9iW1Ir3FpQs
         KzKAOdCvq7/rYRDYUD34no2RzX9YlS17Qle4wUTJALVSRorAk0Flde2aA9VWbK8TLoVO
         xoMVYW2cFjvIuLs1/LhwbLzTR/owd1AjaPqAe/9hdpAxSB8B8aJy0A+XH8XrZ+xxCIZ3
         vRlOAhgHNDY5jH/m8VTp7MiBBjVoGhKVyqwthzlKLzTK4gttihQoHvNBt59ZhFjDznrO
         VIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789657603; x=1790262403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1zHs5HAyUucVjtHvZt4rt64j5+dwbb1H5FeS2taXPLw=;
        b=IW+ftovEu+nKfIqbilKqnCZ9rl8TD6yd3QBBQ7hjhLsRTk+sQrVTxeuR6lAb86redb
         Hea5J3APJRbcL+FTBkoSGcW0oaKGuz4apzeInan5SX9+b2Xj1HXTgT48QGlcPIZtNna6
         3VjubFgGvCYshw6cFIHDKOXfBpqrp7nYPO4fTubDMux27q2VNY0XXIqZGhEOadRDaYt9
         Hrq3PHDump8YTXjtCsdd9X853zS5CaKXyZO5EXnsrFVuNQHg98HSrVvI4OIW/J5AlLGT
         I+NgVQKQVLuKQizVGyUavuteQ7XyfZU3lLb2pLtoGyg/oIt/7JBDQVBnG26kDmh92xBk
         0PuQ==
X-Forwarded-Encrypted: i=1; AKwUvBw35dKHEPggCo82C1lkXc/hnMb5N9e7AEmMbMTcWub+wJKnsC3J8YxyUiUEXEzZq+y26S3VqA==@lists.linux.dev
X-Gm-Message-State: AFuF++lU8HKeJ8jktCTmIQP8JofjYd9B0Jnx40meOuEdVvwKw4uxcAqS
	eAcOoMVTOUtFrJKhw7TQEjxr3df261RP8o0OgMmxFccs9lI0+nt56hc+
X-Gm-Gg: AYBFou28crgLpsPBbPDfbOBoC+na+70sB5+tjbdOhgOu1cXhfkN3JtM4wozJNkjuISc
	RIaL/P/H0klXgV80RCj/IQbw5aA2OpBP6JgnCvIrZ6IR0NPgo+X+kZY7/uOUnIFURknZLNx2S9H
	GkSbM/j5awXECBd6Q6duM55oC4pbmlSAVyVXMqZhz+UNgzYG0YzcMQ8xi6RX/35L98WU9ustIgr
	ZOuKlxr13XsyDCwisDSpIBodc2Wj7TCTYcWgZR2gUIuSKPrVxw/AAYCsyJ0disnndJwukII2pJq
	Wv6EkojJaNrWQoqYtPjqewRVj/Jb06x8FAvVFZvfv1t5VkozjjK+0/z9wYQ0HWBIec3vuGoJsCl
	c0NXn6IIEieT9xZ9IxIjRLUSZpwqkavQGVLjeQ7fZK+kExmQWGnxSZ08FSielWfM2uh0W2gsfXb
	EqoXIPQChP8Spt6EVEOlz8ZqV51J789DkdzJfxDYZdRZru1JtMOwQlpUHQuxDePL0SmkW7vbQej
	jHHkTFSARr7e7otI+e2oHx2m0Qr3Qeijtxvsd7MfM7XTS/CXG71O/UgSnCvHQeXdBVsplQU2/h/
	6Xjv8z+TjwvqCsEtXR60eheBGMaolcX7CxAP768EDsHYgQ==
X-Received: by 2002:a05:6808:1b9b:b0:4c3:e608:ade6 with SMTP id 5614622812f47-4ca4cbd4551mr9330216b6e.18.1789657602989;
        Thu, 17 Sep 2026 08:06:42 -0700 (PDT)
Received: from LAPTOP-97G9G880.domain.name ([106.222.202.182])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4cb6a3d7a4fsm2741322b6e.2.2026.09.17.08.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 08:06:42 -0700 (PDT)
From: Karthikeyan KS <karthiproffesional@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Karthikeyan KS <karthiproffesional@gmail.com>
Subject: [PATCH] mm/damon: reject zero sampling interval
Date: Thu, 17 Sep 2026 15:06:31 +0000
Message-ID: <20260917150631.1138698-1-karthiproffesional@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_set_attrs() already rejects inverted intervals (sample_interval >
aggr_interval) and invalid region counts, but it accepts
sample_interval == 0.

A zero sampling interval is not a valid monitoring period.  Sysfs "on"
and "commit" both install attrs via damon_set_attrs(), so kdamond then
calls kdamond_usleep(0) and busy-spins.

Return -EINVAL if sample_interval is zero.

Signed-off-by: Karthikeyan KS <karthiproffesional@gmail.com>
---

Hello,

I recently started reading DAMON and just found this one.  This
change only tightens damon_set_attrs() validation, in the same place
as the existing sample > aggr and min_nr_regions checks.  It is not a
crash, UAF, or race.

sample_us=0 is accepted today, so kdamond_usleep(0) busy-spins (about
one core).  Sysfs "on" and "commit" both go through damon_set_attrs();
one check covers both.

Checked on v7.3-rc3 (238650ef6c7c):

  unpatched: echo on with sample_us=0 succeeds; kdamond uses ~97% of
             one core.  echo commit of 0 onto a running kdamond also
             succeeds and it starts spinning.

  patched:   both on and commit return -EINVAL.  Valid sample_us=5000
             still starts.  After a rejected commit the same pid stays
             on and does not spin.

aggr_us=0 with a positive sample_us is already -EINVAL from the
ordering check.

Thanks,

 mm/damon/core.c             |  2 ++
 mm/damon/tests/core-kunit.h | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 644daf5a1656..376c3e2cbe00 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1060,6 +1060,8 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
 		return -EINVAL;
 	if (attrs->min_nr_regions > attrs->max_nr_regions)
 		return -EINVAL;
+	if (!attrs->sample_interval)
+		return -EINVAL;
 	if (attrs->sample_interval > attrs->aggr_interval)
 		return -EINVAL;
 
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 4a536d41cdb2..ec8ef71956c8 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -658,6 +658,19 @@ static void damon_test_set_attrs(struct kunit *test)
 	invalid_attrs.aggr_interval = 4999;
 	KUNIT_EXPECT_EQ(test, damon_set_attrs(c, &invalid_attrs), -EINVAL);
 
+	invalid_attrs = valid_attrs;
+	invalid_attrs.sample_interval = 0;
+	KUNIT_EXPECT_EQ(test, damon_set_attrs(c, &invalid_attrs), -EINVAL);
+
+	invalid_attrs = valid_attrs;
+	invalid_attrs.aggr_interval = 0;
+	KUNIT_EXPECT_EQ(test, damon_set_attrs(c, &invalid_attrs), -EINVAL);
+
+	invalid_attrs = valid_attrs;
+	invalid_attrs.sample_interval = 0;
+	invalid_attrs.aggr_interval = 0;
+	KUNIT_EXPECT_EQ(test, damon_set_attrs(c, &invalid_attrs), -EINVAL);
+
 	damon_destroy_ctx(c);
 }

-- 
2.34.1
