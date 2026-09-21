Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FBD1A239A
	for <damon@lists.linux.dev>; Mon, 21 Sep 2026 02:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789956023; cv=none; b=N8W1mOGj9+sIyru5FNZFiQjB1zQnnOU1ozSCj+iioczrQgAec9m5l7HhbC0gsdk4EVjk0F2ogRmCSxHJxfK6a/4rcTWETYhxBwUisT8UN98nixiDvyCCxlMjid00Y4+eYjVr2IMt1EMKJzlJ85tc0KAWqoDZbDNfs5youJPFAiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789956023; c=relaxed/simple;
	bh=A+RJJnYsn8OIpInlPmG+k5uxSqICSok8KjI8Y67ZW7I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dQjAm8k+TtEWO+EQK7rrsxI8WN8JC+ffyLqClMleW7eHmp3gr2BKd/QXC7avbib46hmfk/Zy+jVPyxZi5qCs6dpx3f/hSknPpwRfY6CmuOvhA459QDXQGVKdqu/Ntc7tECOAWWnzby3Ytr7PAkyIi18eOlj/WuYUCOge95UyfJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ali9A4LB; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ali9A4LB"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ccf3ca626so11310675e9.0
        for <damon@lists.linux.dev>; Sun, 20 Sep 2026 19:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789956020; x=1790560820; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dl3X5lIuCDCuxRfR4V0ReBm9Zl+q43AQqD3mJ2yz/dQ=;
        b=Ali9A4LBhVfX2b0Cg7EOYh3GPvbzOpqbetdErFJ9hy1qQYEgWrVnlEnjPWvs1ioAM6
         SZ5gwweQxv6QP+PiPLW61lrW59K81QZ26jEjWtDH/Xs9pppHM7Guo8sRm0V8Pi+SfVSc
         0kvP2ImmIAQw2dSNiKF7gWwcWy1qsE5grqmfD7n8YN4yqlaFdmoog3l8fVWusFFibVRR
         nebSLM6KF2bMSfZALACCt3kvWxn7RNSXudGMBvKBuXXW457b0XR/5vMNHTcmanNQjq0s
         yrruCSkIEO4SLRw6hO4L+3dm/cvaz754z7oFmnYhzpwvkzWdsC20wt3tCVv4whEBfHSt
         k8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789956020; x=1790560820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dl3X5lIuCDCuxRfR4V0ReBm9Zl+q43AQqD3mJ2yz/dQ=;
        b=f4jA4MehRqHXPPYbFrGwe9QcRKMF3l3s5Tkc+fbtJEMnksyOoM/SscYLbd0A72GnPL
         MbQJaBlCTo7YcivKuM9oQI8i87CSwVkz+orMj/mv2ept+vffn2xBn9ldxbzhMPTzXpD4
         JiKYaaTg9oEqIsQHNjoPL+TN05Ir5hW2chE7fWxvJtFEyTqkJWwFZgjHWGoEwGtE8hXo
         DlJSrI2VSwAU0Evkgkpd7Tux0POme3uzUs62mIqerErbQqk9T/Tj3hv2nP9ix6vv2qFe
         172fzAzQFG1YJOzksNQy738wioVEnoRIZG+OltF3/B1wRPEtVoQ4Z6rPF797pCWP+J3x
         jpUA==
X-Forwarded-Encrypted: i=1; AKwUvBxqmM3s+TTY12kKEmtVunQUsJGu5Iso2AuiMmluXtlsYx469+N0j1r4pmBJpCDyVVHc3MWDdw==@lists.linux.dev
X-Gm-Message-State: AFuF++lHQG0B2BdxdixGlIFO1YQISPO5LqeloXP5lJUjOKHyNClqVXrf
	oqpOYmQjd29TTH3rv7pAQVo9JoveOY3tLgp7P6+9gnwRw3OcXZ7WDYNg
X-Gm-Gg: AYBFou27xahxFrL28YvN0YdynFAl8zTawBaUKXYpBWsfJDc8KrnGkoDJzJtjSgQ5AyN
	oFqrl1WVyMoi1U3aIKOmEIxdoFOvGV4xKXg0bYQGD7vbBUo7CpVbF6JOwJdLpOjxc15b+f+/DeZ
	pl2Imngj7SDpivdZKJAWMbLNc8+v06S8rYfvsuU4BwAmWtE3/OycB50ckA7zBD+0ux0H2tTBEsG
	yebL0ct3ymhMo5iRTW48A/nmXFw9dTjNkWnt0K9+a6O6Ua4MEb+zhws4/btkkul3yEjx9xoCnpO
	+dnxffz4RETLxeSFJdsJHKETvsY4DO7gdyHMWrJts3daIOZki5K2PEpP5v7Hyx23zJeA8KSyJNx
	Mqe/7gnNfqqngeyYw+LhiqYW4CP33Hp0GiBdwLV+5jmlJq+d/r0bxRC7FWGIhSnsIuwipC4Z2Oe
	lcKFoA4IVzMXPLEIkb/gbOdwNYXcGBFYBbUej4xMJmkMj0lbZcAyDNMUx8iXrImpvI63p78Qmj4
	idWszZ8d5nOiCFSrSoP3wmwvY4TDY3ZSXbL5jKPB6HqTKCHm2QsCyuwYwEGtEcAPyxVIpyK3QxU
	o56apEj+EfjwBO9/LRTdaANQ84FkkYFvtY3vL5o+rNbMaxGpaQg1Vu5h3JmTttcSMUCKtj63/GQ
	o1g==
X-Received: by 2002:a05:600c:4e50:b0:49c:ffde:45ff with SMTP id 5b1f17b1804b1-49fc5728f5amr118239615e9.17.1789956020203;
        Sun, 20 Sep 2026 19:00:20 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a8e9-c501-2c36-515f-49b6-c492.310.pool.telefonica.de. [2a02:3100:a8e9:c501:2c36:515f:49b6:c492])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd10273fsm193284995e9.7.2026.09.20.19.00.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Sep 2026 19:00:19 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] mm/damon: preserve temporal quota state for unmeasured PSI goals
Date: Mon, 21 Sep 2026 04:00:11 +0200
Message-Id: <20260921020013.33105-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A PSI quota goal without a previous sample is scored as achieved. This
leaves the consist tuner's input unchanged but sets the temporal quota
to zero. Preserve the temporal tuner's previous goal-achievement state
using its effective quota, as SJ suggested [1], and test the helper with
explicit PSI totals.

All 42 DAMON KUnit tests pass on x86-64 and i386. With the original
scoring retained in the extracted helper, the new test fails on both.
In a live damo test, a goals-only update changes a running 64 KiB quota
to zero for an unmeasured round without the fix. With the fix, the
effective quota stays at 64 KiB. A full damo tune also needs the separate
quota-reset fix [3], so the context update preserves the running quota
used for this decision.

DAMON selftests show no new failures (QEMU TCG guest; the wss_estimation
test misses its accuracy bounds with and without the fix).

Changes since v1 [2]:
 - Use the previous effective quota for the temporal decision, including
   when it is zero. Keep resetting last_psi_total for new and updated
   goals.
 - Move the current-value calculation and last_psi_total update into a
   helper. Test both tuners with explicit samples and check
   last_psi_total after each call.

The series is based on mm-new as of September 20.

[1] https://lore.kernel.org/damon/20260916001311.101024-1-sj@kernel.org/
[2] https://lore.kernel.org/20260915060937.3423-1-kmehltretter@gmail.com/
[3] https://lore.kernel.org/20260921003047.12041-1-kmehltretter@gmail.com/

Karl Mehltretter (2):
  mm/damon/core: keep the temporal tuner quota over an unmeasured PSI
    round
  mm/damon/tests/core-kunit: test PSI goal values with explicit samples

 mm/damon/core.c             | 30 ++++++++++++++++++++------
 mm/damon/tests/core-kunit.h | 43 +++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 7 deletions(-)


base-commit: 185111f116aabf202d12ce440c0f6e9bae073514
-- 
2.53.0

