Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1B1352C29
	for <damon@lists.linux.dev>; Mon, 23 Feb 2026 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849974; cv=none; b=jYAELwQjl1wRx93/d2YsJioPbppfTTtWMywZdgrE7Q2ouz1VBrQO+OZ96thBxNMNCyageHRTp2vgFezDvW8+n78gsJf7I5EQ/Y9m+fQ9uMziXfNgGjcWQuL1fZGDtCMnbbEuAU26IX8GU9Dj/8xzqpeYuIcARCHDMFH1ycChYYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849974; c=relaxed/simple;
	bh=+Gb05PxvumN+Pl9XaeCIZFLytIRa9gHhOeCrXLllhEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFQRS/urhjYLXC6dd8CVcXS65mcXhmM0swpiZMrYwwhsWQTQfDHoVVS0cFJvz64EzkxOCrnG5pEwUxA9wq2YUhP0sar3zsPcIHXwBzvbvuaJ8tBVGvGzWHfj3yedA4TTPOGLK85uvjom0WJ+MR8ZKha+/4m3rBd5a6la9BoE2X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqYmANcD; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqYmANcD"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-824adc96ad2so4280688b3a.3
        for <damon@lists.linux.dev>; Mon, 23 Feb 2026 04:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771849973; x=1772454773; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRjDZcOUW3p8fFG0+tNWgPy65ed/dP2/X89AKu5rG9U=;
        b=hqYmANcD/8vwbzUzKSGIF0egjZk8hMhFp7d6s3eoEGTBML7PAHncpV1+FxvJQC/4mx
         kZE4tE9s2HChy6+DIb4yJQSPJ74rWyDbCkupxIEzZ3CZcSCfXrKr/iFDFAEy/iL8t0Q1
         0+DbtcoUu27r3K/kYf6zkADU+Gl09ieXUs6Wqn3i6g6mmOJ9sUFw9WTiHc+1TxisZ12Q
         lKhkKOoT4Qpj+XgBzazwoQn/zvC1RBS17TjgBYQo5rbJVT/zQpB4mGrl8GYESj/Ag75i
         c5i1vD9I8yOB29cmnneTjLP92/4TF2m7DRg/J9UrfnBbySDo7MEVXXrPOueg527CASjU
         AGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771849973; x=1772454773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yRjDZcOUW3p8fFG0+tNWgPy65ed/dP2/X89AKu5rG9U=;
        b=sBL6IF0fxHrhMkA1U+GZEB84sGsx52bZpp8YKUiAubPYynsH5oyeim4kkqeZUpzp0x
         Jy3n6d2EZWp8Ok4jMqHWXjw94tgX9RT5SVXvhHF4mt0NJRc2/B+MpSEqhqv80WdRB//t
         nLRnxHlNmXcqmlKw9ZVbecczXI1Iw6Z6KrylIWgwL/TIkp8mAm4GjyKmFVDfP1C6Yu/K
         WXSqQ7koTpwolYqhanOyFgptb0YHvvv2qY/YCA5SQwlWKyKEDRqT0lAdI1tLs4oS8pp1
         hDEkxakLS/iae+imX8W9/w7B+Qpr8vcRA3REufTIKIBNm9zalbJzAY8QtpnCusGnjp4d
         EpLA==
X-Forwarded-Encrypted: i=1; AJvYcCXPQeupypfY/zdecc82RfKUnBx9IN4IIHPXRW4kdhIDG9+gvfcwLmcL8Oeegmlg8J7y0WbR7w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0Y7pr1JgtDoX555n/qbJLdM9mpK/yMRzlLL9PjZ1nKmqJubRy
	u/78ufirYZ+HZeNPwrPAfKi/sggwscNQHDEZeImIe/Qh/Ftq9+prtw8=
X-Gm-Gg: AZuq6aKfuZTERF7Y51ySoBGWFFhG+ZcqI47G+OVYo2hOizhPXn1VAuY3fwKl1NBxB0U
	QU+4mwcKudv2v0L1kryy2RDjvtHE4U5RVFtW4xPApqdi9cRIdMJVOjoJlf4x7JhhqFuhwNVp0XH
	u6C7UVD3MOpQXAyblXpaarx7RP8LPQREyg3XCo96jujZAu3b88MSP4VJrOKGRCiyz58WaD2K1nL
	Z8fQCFebBRH6boOrSclWO2LQvPa6iBsNTBQWCvAhCKh1SXcHRPVTlUI8+bxQIeSkIhESMKYKxw5
	czD+q0W4azssiVwX00xUProD+IORWO5Z52Ku5fQ1U87pHaFIwOO/8EyOUKQT3yFWcxPo0+dMWvF
	wfxBkdgvb24kCC84MWZti6oPFa8M5jFaTYOAp4U1TBkyUnpRbN30ExOM/L2t13TEwJcMKGRF/+9
	jf66gnEZOWzjDd5AfKxFvmiBhoLN5HZX2knLFrTUyze/vj
X-Received: by 2002:a05:6a20:d80f:b0:395:291b:f555 with SMTP id adf61e73a8af0-395460224e4mr6425517637.69.1771849973278;
        Mon, 23 Feb 2026 04:32:53 -0800 (PST)
Received: from LAPTOP-FDBL0TVI.localdomain ([49.37.157.71])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b71a73e1sm7454739a12.13.2026.02.23.04.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 04:32:52 -0800 (PST)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
To: sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Subject: [RFC PATCH v3 1/4] mm/damon/sysfs: set goal_tuner after scheme creation
Date: Mon, 23 Feb 2026 12:32:29 +0000
Message-ID: <20260223123232.12851-2-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223123232.12851-1-ravis.opensrc@gmail.com>
References: <20260223123232.12851-1-ravis.opensrc@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_new_scheme() always sets quota.goal_tuner to CONSIST (the default)
regardless of what was passed in the quota struct. This caused the sysfs
goal_tuner setting to be ignored.

The comment in damon_new_scheme() says "quota.goals and .goal_tuner
should be separately set by caller", but the sysfs code wasn't doing
this. Add explicit assignment of goal_tuner after damon_new_scheme()
returns to properly apply the user's setting.

Without this fix, setting goal_tuner to "temporal" via sysfs has no
effect - the scheme always uses the CONSIST (feed loop) tuner, causing
overshoot when the goal is reached instead of immediate stop.

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 mm/damon/sysfs-schemes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index bbea908074bb..fe2e3b2db9e1 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2809,6 +2809,9 @@ static struct damos *damon_sysfs_mk_scheme(
 	if (!scheme)
 		return NULL;
 
+	/* Set goal_tuner after damon_new_scheme() as it defaults to CONSIST */
+	scheme->quota.goal_tuner = sysfs_quotas->goal_tuner;
+
 	err = damos_sysfs_add_quota_score(sysfs_quotas->goals, &scheme->quota);
 	if (err) {
 		damon_destroy_scheme(scheme);
-- 
2.43.0

