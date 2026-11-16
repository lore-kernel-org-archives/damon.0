Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827208;
	b=jmVb+f3oPROW6D+0IVYQes71emjhbPZgDiP6pIYQd3C8/moMLLoWda/xrzmlyz2SDPBI
	 ttu+3X32s0LmcohOxqWurUG8YbV+tO4EMjLl2zqQf/nS/uwcMHKPshHzC1ocDigLSX40B
	 zPY+9yXwlPzT8x5mwRl5hzV3QBvjiNAfsj0nwDtKeMTpOJfrQg4Z+DYMV21IlQ11/gqdg
	 sL0x1JlNYvRnI35Ca1hy2jU1CiLJq/gKmdyh0+ix0aScJbL7m+6R+ylb3vYvgt8i1SPZ0
	 dyCaTxyHg8O9PpTAoPQ1iHc/2bmyIHmbyoNbJ7u8OCa7GccARiZOzASxjmEP1fFjMHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827208;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=0PD2Hoi/mUsCD35EYP/4JLQ1DrGCC56gn3UV4l4u8Yo=;
	b=MiRaSUq2zGsAobn7E1KqyoQRdZGRfk3j4yLKrF0pJKr5DbUJ1VC1J33K6HwMsVVBREll
	 KlHRSYq3XVrmJhb934XIafcXlH7800ZDCZzoKNmKNmmrcCEYLSyOPsZwM08aI+9wQkvL8
	 erygByXm7DpjOMkD87LokgmGs88PLPOFgRGSn+Zgfcgvjngh1Fcmxu38MBjt3Zuqm27lN
	 St2pcyYLdk7+/aIGMwZ56N7kAsw0ahYTIFmB/aKmS4YOn40YJw6rV8vlZMuhAITxwfNZu
	 tDnjViccpnPMkt4qCKL1VdbbfbL85Rxb7Bf0gkfcJNp3k/B7ZW6CCwNqvuRz93LBLlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ucla.edu;
	spf=pass smtp.mailfrom=g.ucla.edu;
	dkim=pass header.d=g-ucla-edu.20260707.gappssmtp.com header.i=@g-ucla-edu.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=IsE2yq5N;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A19D606D7BE
	for <damon@lists.linux.dev>; Mon, 16 Nov 2026 11:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A19D606D7BE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ucla.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=g-ucla-edu.20260707.gappssmtp.com header.i=@g-ucla-edu.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=IsE2yq5N
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1b3b4944a0eso1340413c88.0
        for <damon@lists.linux.dev>; Mon, 16 Nov 2026 03:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g-ucla-edu.20260707.gappssmtp.com; s=20260707; t=1794827207; x=1795432007; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0PD2Hoi/mUsCD35EYP/4JLQ1DrGCC56gn3UV4l4u8Yo=;
        b=IsE2yq5N1C7YmU3n4gv2T3Tnh5qwHEvdBQWwE7w3GOZ9Grea6L7aVEMSQuU/DUCPid
         OqPC9/b6LcXoIYWgz0qjjwQX1tTtcojWkYmNNptS69ZiLjMScnj8t2RsJkUUIftILIX5
         suXdlhJqI3LoR9hVGi11GbuObrtotM2+dGuQPfSmkFBCsx5euvd55jZDsySPjS8UaEkd
         cTwT2TMa9ZS98QQNK8+T3wgl4SZlchvc5XpH9xwzrnJ++pPkRCFcN0EvMh63mUMfwUX3
         55rn4bD3Fa5+ueeZLvC6u0KhBXXbUFpsxaH8ot0H6DX4YWZM8vxTpcB1BJWGK6f/8A36
         P3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794827207; x=1795432007;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0PD2Hoi/mUsCD35EYP/4JLQ1DrGCC56gn3UV4l4u8Yo=;
        b=kAyknLdiR+i97JZn+sOvJxyKEuiKMhboGkCWogQAXDelwM9cajIoe6WH55s2f3ryE9
         VJfPraWwBgthKgq34t6xLiOMHfwOmqP+RLN4a4znxtvkp22icEECYM4Za0ffmWaVpkFi
         G2G8BFIvowIvVNBlzI8KtZg3bJtBgDNxbEe+V06ZDMfeSDULuj0OfdMuQBJuRPq55L5K
         upnr9nhyQs3fvzeo6sWxF5W0v5FMxYoJ3yIiqaeyFZKoB496r8hom1ql/MlpCM3KD23d
         L3h5lTmqd8kUD1gCC8pXAVDUkS/r9sybxKMA+h+uz7eL/jex16KHeqV29x96+sBMJoBR
         NCYA==
X-Gm-Message-State: APuU4Z/pmCcRiN/ezrDI+eLAdIkolLWAHdJQ/uOI9KJV4fvJfpGkXyPB
	CgR9dsx00yQzDCmAONjSm+AL/x6vWpc/k6S85g8mMCKtrZSVEU9yC/x/v5mlSEg7Qz0=
X-Gm-Gg: AYBFou2sVRPOLE6xAF0Xd05xhEs5FBA6PsQkUIAvwKUdrg5uYJz00TzEnQ2mYgGlAex
	pp+YXfo06Y7GeCSPthFA8Q7Xm3/ufABMvoO+5vfcO7HsE7GqMDNE8c9wFdARHEJ9FBheJ9b+FPO
	+aD/9tH0oegTJMhlt4at6XfyqIaBM1IRRcd7AiJZlabEiJBGf+2Pyy74MiJhbT7TT0N+y9SVSsI
	ppHKPO8p8ps3CnKsfPazan2pXe/qQkV0bwmKC4ix1TU449+mCCmZ5d0T+XpjQwml7utdwDjdz/t
	rWVz901mWVizAX6U0WeuEx078DST6zmSISBCqy/qdAgk+kl8rfxuddTHMP4vCOZ6YL8aVEhozCD
	vCO5gYlGCzsoYkZ2KSTO21zUQKkA9WvyIBlXAUOZysFSIy8MfAjugawVrAR3B4rna9we439HJ5N
	TXWGiIexhaoyFz11iVPZ/p4YJUOrKJmKikSmpK2PNBOCuaju/icIr5Gov9EHYpDniR7UKXnV0ge
	g97PCQAe1E8jEhIpS6XoaDuLvA6zk5MiqYV+TchXP38c1act+iJOgIr00H2kXaYQ+erZb3CWbtu
	5RmCeuQX+cMN7F0lB2cQHZEB4Ga/p719oold8B1qP2Y6xA8xD7M=
X-Received: by 2002:a05:701b:4648:b0:144:fb31:a597 with SMTP id a92af1059eb24-1b5031695c8mr10468807c88.47.1794827206938;
        Mon, 16 Nov 2026 03:06:46 -0800 (PST)
Received: from [127.0.1.1] ([131.179.95.34])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b524049e0asm12522103c88.4.2026.11.16.03.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 03:06:45 -0800 (PST)
From: Jason Angelov <jasonangelov@ucla.edu>
Subject: [PATCH v2 0/3] mm/damon/tests: add KUnit coverage for age_ms
 filters
Date: Mon, 16 Nov 2026 03:06:20 -0800
Message-Id: <20261116-test-age-ms-filter-v2-0-3b265d59ec98@ucla.edu>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBBFr0Jm7RjaolhX3sOwaGEqkyCQthAN6
 d2tJO5cvpf89zcI5JkCXIsNPK0ceBozyEMBbW/GByF3mUGW8iyEkBgpRDTZPwM6HiJ51PqkLpW
 iWpYV5OHsyfFrj96bzD2HOPn3/rGKr/3l1L/cKrBEqzUZK10trL0t7WCO1C3QpJQ+MX4QerMAA
 AA=
X-Change-ID: 20261112-test-age-ms-filter-9953843e7204
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Jason Angelov <jasonangelov@ucla.edu>
X-Mailer: b4 0.14.3

The DAMON core tests do not cover DAMOS_FILTER_TYPE_AGE_MS. Add tests for
committing valid and invalid age ranges, identifying the filter as
core-handled, and matching ages at and outside the range boundaries.

Region age is counted in aggregation intervals, but age_ms filter bounds
are in milliseconds. The interval-change test checks filter matching
after both increasing and decreasing the aggregation interval.

Signed-off-by: Jason Angelov <jasonangelov@ucla.edu>
---
Changes in v2:
- Fix commit-message formatting, line wrapping, and comments.
- Set age and interval inputs directly in patch 3.
- Add SJ's Reviewed-by tags to patches 1 and 2.
- Link to v1: https://lore.kernel.org/r/20261113-test-age-ms-filter-v1-0-b99eab2f71bb@ucla.edu

---
Jason Angelov (3):
      mm/damon/tests/core-kunit: test DAMOS_FILTER_TYPE_AGE_MS in damos_test_commit_filter()
      mm/damon/tests/core-kunit: test DAMOS_FILTER_TYPE_AGE_MS in damos_filter_for_ops()
      mm/damon/tests/core-kunit: test DAMOS_FILTER_TYPE_AGE_MS interval changes

 mm/damon/tests/core-kunit.h | 93 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)
---
base-commit: daed51c9105158768a3949395135aa6e0a04bb7e
change-id: 20261112-test-age-ms-filter-9953843e7204

Best regards,
-- 
Jason Angelov <jasonangelov@ucla.edu>

