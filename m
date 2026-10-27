Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109577;
	b=aZqdFleLsh7ccRX/Om9OZjtu3G9G6fMRB+vFuZJqDhAtJNL7ZMCnR6+l/0Xa/YjVKNx2
	 GKhl59J4uUmsW0QW5jRJEsljCvoJoCnk++HdSgAVggd6ny+0ifptPtNHT5H+UEHcOK5pf
	 8gw5eiM1WqrUkdPeA8EIYXo28EFJZHN2aUIalwGdSSJ583LowIz54wP0YNyWw9NYK0emW
	 DplPiE6/6zv43xb2vNo5CQGP3cyD86Cxrf5SuTIoSkT63yeK1MqZCsdIqFRzO86F/PB5Z
	 Pp17NqOVVnDX6KiYlm86FhpvIS3YR6aDFE/C+pd8MzKpg1jehRloWo/qQmvLYUk0G4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109577;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Ze3hDNgAVXxR03vgb3ebN8Im6n2FcLAKEpCxr8ESZ/g=;
	b=aAyNC6IkJALeNda60G+ZqB9OU5MQGoQJJnNHgwV4s0E2edN6nt9HpHupAoP/e2ToOKP2
	 4rMPMS87xoAxYJUnxJAFPSwjz1X9KmOQLs2SNvGOvzLKKcz2sTs9TBhHbte8gjn/vX2T+
	 F3sFN51dXNwboLh1mZKHE6h4w6yag2Ll8kNQkgnV6+Np6Z2+AYLUCAR8BN6up+vrSOXor
	 0b/WtdvarY5TEM51cKf/+lwPMNV0+kScsOHKEh4Fnp9BLE9okE+WJztdRJkm/e4SojojR
	 6KDTNd/mAK7jbMjjiDlzN1t8wFmHqFSbq5yKjxVZBV5+ObhxijIHuTVllPH+jqeXvpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F6qXQ4i9;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660C4606A31A
	for <damon@lists.linux.dev>; Tue, 27 Oct 2026 13:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 660C4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F6qXQ4i9
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ad47c246f8so394272a91.0
        for <damon@lists.linux.dev>; Tue, 27 Oct 2026 06:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793109577; x=1793714377; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ze3hDNgAVXxR03vgb3ebN8Im6n2FcLAKEpCxr8ESZ/g=;
        b=F6qXQ4i9QtYml97dTT858YySPEabJXnFwK1pc0j9fkDlf2WkL2GgNSCDLQ21NB9O0c
         QGIGwZS1Vrj7+uz58GqbmAgOOxIaCJGY+/7KmvHSYIz6CtjAqso6IUiejxNYf/xqjqdc
         XbQBytnU3Kqa/LeOXWJjEKj4ptJc38K8ytsFqdzU1m8ujGOvgVJds81TAE3k7K0pTypO
         ScCc/Lh3jv0bDermPKKsD6kM84WChDCQZPUizZ1AckB7pvXy1W0fbYJ9nTJdM/Q4TYob
         rLxX0CYQyQoP9B5gs4ey6w5lG/8LHOHftN729L78slJtFZ+rYQUp0V5PAktNYRmumfNB
         90iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793109577; x=1793714377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ze3hDNgAVXxR03vgb3ebN8Im6n2FcLAKEpCxr8ESZ/g=;
        b=WtoIuC57kLX9Bmcms9Is50C8+stv7XtDzDmTq7pJ8jH3pmNFyT+sbVM/CdU77ohqcH
         ZrMrk3qNf4hIBmMu6umAyQxP05D3aJY2O9k1/FflDlU3xTdvc97pz5aQWbBWgzWYLnK6
         nMbiC8+VT72l2zEYGmqA7ruP5ERXUHtyHXuLIrA9ptg4SUCG/XaXpS1ferRRIuDVgxdE
         OuuV4PPsYM4iYAUo4bbVX0Sf3Pwac7ZK51+uvLKUv6DCkx3IcJPRg7cMOqbgFzgLinRu
         1MsR1HPgIGgTrHGJdE9w5dCwLvavWgyu97gT3IwFyE7XrJSYELuBghNal80VX8UHvVnM
         s7bA==
X-Gm-Message-State: AFq9FYIRqj6HRT4ACefn6S1imQWQ1MwMK0FhuSubzo0QaIwULkL4I8VZ
	rcOTWCCw/j9eKl0Sf43L8JRYlRzQYz2faSVHbTsrQsy6HD+qroZmZiFd
X-Gm-Gg: AYBFou3BGu6f5b2VcryyMKpOAEsibucnrZqIB41EhcpupfzxKHpFO/Gwrl9YZrGax9J
	tl0mjr04HNJMRRpi3jStKGwXADGyplEFgwQHJVXyslBkffTqjBVJLp6S5Qcbpk4r80uqxThOptT
	njAilHQhZxgD17QqhwO4h/WdMqWVur/ACV5pGxvv/YHZv5tFnL3sjsD2xir7LGimWINyDzH6Nna
	tB3dTr+L6v/oPqwnWXC94lTgYQ/DhqBozLIk8B7Yv3et4VqaG8UpjfwkVIl/eGS/rUMwWjs/F+T
	XjI1YA92jZnzgyOuCtAX6IjBOeyR/TSZSi9Vh6et0eRoHjYZ2G3hYwArInSZimILFxkHE95ZHU/
	YpWWX+enZolRuaHALp1EWJSwXUY0Dr5bmZ820CuSmo7lS46aHy5hNL5ETrOxI+KiQBtBB4QFK0U
	RyUx8r2gH75m8N33+kMXweVRROPyDW8V4TObQ0NJ9FUwsPfrS1Ys2hh0KYr1YiWJvdPPv9c5olN
	j+WicARxLpWnOXiNxCYRMIzZkh7InFr3jHXBcWFMLhxy+cT
X-Received: by 2002:a17:90b:28c4:b0:3a6:f1d2:57fa with SMTP id 98e67ed59e1d1-3adeae5dd2emr12875632a91.4.1793109576511;
        Tue, 27 Oct 2026 06:59:36 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae404432a5sm4243466a91.9.2026.10.27.06.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:59:36 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Asier Gutierrez <gutierrez.asier@huawei-partners.com>,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [RFC PATCH 0/3] mm/damon: fix overflows in score and ratio calculations
Date: Tue, 27 Oct 2026 22:59:29 +0900
Message-ID: <20261027135932.2301646-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko reported several pre-existing overflows in DAMON score and
ratio calculations [1-5].  This series fixes them with wide
intermediates and an overflow-safe mult_frac() variant.

Patch 1 fixes the weighted hotness score, which overflows with large
user supplied quota weights on any architecture.  It accumulates the
weighted sum in u64, preserving scores for non-overflowing inputs.

Patch 2 adds damon_mult_frac().  It returns the same result as
mult_frac() when that does not overflow, computes the remainder product
in full width when needed, and saturates results that do not fit in
unsigned long.  It fixes the region age and sample ratio conversions
for new monitoring intervals, and the moving sums of access counts and
probe hits.  The helper is introduced with its first users so that each
commit builds without an unused function warning.

Patch 3 uses the helper for the page based memory ratio quota goal
metrics, including the hugepage metric, and for the quota goal score.
The node eligible memory metric counts bytes in phys_addr_t and uses
mul_u64_u64_div_u64() directly to avoid truncation on 32-bit PAE.

The remaining mult_frac() users, including the intervals auto-tuning
score that has an ongoing discussion, are not changed.

I am sending this as RFC to ask whether this approach is preferred for
these overflow issues.

The DAMON KUnit suites pass on UML, i386 QEMU, and x86_64 QEMU with
NUMA enabled (54 tests each).  The new regression cases fail on i386
without the fixes.

[1] https://lore.kernel.org/20260623141527.044D11F000E9@smtp.kernel.org
[2] https://lore.kernel.org/20260708140944.F26821F000E9@smtp.kernel.org
[3] https://lore.kernel.org/20260901133650.EF4F71F000E9@smtp.kernel.org
[4] https://lore.kernel.org/20260626002448.975E21F000E9@smtp.kernel.org
[5] https://lore.kernel.org/20260831184956.1DA321F000E9@smtp.kernel.org

DaeMyung Kang (3):
  mm/damon/ops-common: avoid overflow in weighted hotness score
  mm/damon/core: avoid overflows in monitoring results calculations
  mm/damon/core: avoid overflows in quota goal metrics and scores

 mm/damon/core.c                   |  59 ++++++++++++-----
 mm/damon/ops-common.c             |  10 ++-
 mm/damon/tests/core-kunit.h       | 105 ++++++++++++++++++++++++++++++
 mm/damon/tests/ops-common-kunit.h |  47 +++++++++++++
 4 files changed, 203 insertions(+), 18 deletions(-)
 create mode 100644 mm/damon/tests/ops-common-kunit.h


base-commit: bae9a042b03b27924c6fd5bdc00a20d6a44d6041
-- 
2.43.0

