Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0922D7DDC
	for <damon@lists.linux.dev>; Wed, 18 Mar 2026 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773848258; cv=none; b=JPPZhTIF6jOKc060Ir0b6Pl6BqGBsJHb5LtxtZgohYEgfC8gvVrQ0XnfdeDbWrq6rkHroj0tVZkoWDwW8sBbLZajA/LkG9CbKIm3wtv7Q8LeBMni3CLx9szHQ/4TGbhR3Z36957Fe+73B2NAxDSmMSY5ZYeGMZZ0001lC4o5c9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773848258; c=relaxed/simple;
	bh=VN95ODXSgCxty+f7OkOfGM9DDrHTk6ukQz1XNYN3i6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OSpBFvfCYvgI7zsvpEadyNLqptLOkkIWkDVh5rBuJlSwujDIQ8LIsWa5YHP+K8WXfr0SecbJxJxW7eIK4UiDCnQkKzx/aMcrayHiZhc1q14ZA0FJR9HEHuIpkExg+4XtZgzCud91OVVhAsGFZm2Ac8vslFd+A8RpxI2Dd7hpl28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggPv7tCq; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggPv7tCq"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c73e9e4cdf7so2453598a12.2
        for <damon@lists.linux.dev>; Wed, 18 Mar 2026 08:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773848254; x=1774453054; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tflDPbUGjZZhe/6e51jUzBoNjciN30vErFCN5iuJYMw=;
        b=ggPv7tCqvSYFPxQbRtQOpMcD2gQxjnKwFj+uprq9L6Kl9WaUfaEgULPLsutohh4QWg
         kDO58VmqS+YpfrUmcbppPxSHycRH7Pjjxw9OAckMZ6a2LCksXOqxuKKBjRaUdQkljbRA
         OLcNFvcGI41lmYeVWuZ9UCHi7t3/SfvwxtPz6tYPRTsbiMys+bWcKlTXV7cL5m4riwhZ
         8hDQ3OKwW4N5FdQdi8if/KaApTyWewUweBYCLxFPIDIb8LK7R2dLFtbTq6wp7XCveFR+
         BJm/mZQZfpSfYtAh8qYsQZwLX8QTKS181EwdOCx4qGe/191e8Xw9AAmpq/ciTEPpumg9
         JhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773848254; x=1774453054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tflDPbUGjZZhe/6e51jUzBoNjciN30vErFCN5iuJYMw=;
        b=nYkapLVoXObyFyy8wzMm/lcLb+nLfflARzpa4WNRe93prH19oWydD3KyqJrSeO1JY6
         Thw6Y1sBWG81OQiBwkoD5rvlLFMcTHF306TROsarlZ2KPcFqjgg8/1mNG2577jK7hnLT
         xFoOH1L1gxNBP/b809rDZx05+uqAw1M3XmvN1KUSEqR1PKvFO0WAf46So2uFH3+y8HXE
         S1DmeI7d5i7bQmIJPMPaLZkKpFpifAh/xKtJfS41UCWkcSNODnjO3WLKzrPH2sahb2BF
         /ryfSEQiRDaklW6h9A5c+0B5LMuD5i81VSQutOCvjNyRNfdsZ0AuO0bILMZ2jx9KlT3r
         NAeA==
X-Gm-Message-State: AOJu0YxyaoKpjuEZ96SdFs3+GCQ4UNNaf3oAjWvV7N5a+tiDndhmd7g9
	NbkzCZXk0h8aUYZN/oBnWwMyHubTicTc9Y6nKzd+sxjqRdH/5vkuXqLE
X-Gm-Gg: ATEYQzwJR/SH0jKU12/OFmIfdqaieZpKGa1btcTjp7pEFdIbFVwpEq6YQMHiTgCoguj
	jsPtR3oRvCRYwJi5r724N2Hj1p3g6OVfnTTAniWhl4XbkToHDxMvyqR7U8mM+lnOz5oV597qt8C
	v0IFvS1rhK7XkhEZU6alsoYFXf8fxKorqDG/V47i6+4FBS/uaAlADpXlz+gq4a1xc4EV+0x2P7l
	x3tGRzY94G2DfC8fYrM9awdbykbWywKZHDNEikGmW5tY7U7AFPiP6BN+UhKj135e+cyqVRRDJoA
	CGJM+Ibec9J29+J9pWTEOeM28SjxXvLWQ7M7dGCewNIk7faWUDQk7LvObt3TEFjkFdW6AqMTC+t
	6HhJdg+QF5po60wGVHeieVEd8jEJK0/3EHponMxCVYzqsklp+MgZ7OHSAygJcupafGFCZuqvzVR
	0Fki7kKCNluCA+NRvopK4PtfeTNq0=
X-Received: by 2002:a17:903:18b:b0:2ae:504c:ae8a with SMTP id d9443c01a7336-2b06e3262bamr37279345ad.16.1773848253777;
        Wed, 18 Mar 2026 08:37:33 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e60493asm30693865ad.59.2026.03.18.08.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:37:33 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [Question] mm/damon: min_nr_regions constraint and inconsistent error handling
Date: Wed, 18 Mar 2026 23:37:31 +0800
Message-ID: <20260318153731.97470-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SeongJae,

TL;DR
=====
1. Why does DAMON require min_nr_regions >= 3? Is there a technical
   rationale?
2. Could we improve error reporting when sysfs parameter validation
   fails? Or document it?
3. [Bug?] DAMON_LRU_SORT doesn't disable itself when commit_inputs fails,
   contrary to documentation.

Details below. Happy to help with patches if helpful.

Details
=======

1. Error feedback for min_nr_regions validation
-----------------------------------------------

While configuring DAMON_LRU_SORT via sysfs, I noticed that setting
'min_nr_regions' to a value < 3 (e.g., 1) succeeds at write time, but
the error only appears later when writing 'Y' to the 'enabled' file,
which returns -EINVAL.

Since multiple parameters (intervals, watermarks, etc.) are often
configured together, a generic -EINVAL at enablement makes it difficult
to identify which specific parameter violated constraints.

Code reference: mm/damon/core.c:damon_set_attrs()

    if (attrs->min_nr_regions < 3)
        return -EINVAL;

Question:
1. What is the design rationale for requiring min_nr_regions >= 3? (eg.,
   algorithmic requirements, sampling accuracy, etc.)
2. Would it be acceptable to improve user feedback? For example:
   - Document this lower bound explicitly in
     Documentation/admin-guide/mm/damon/lru_sort.rst
   - Add pr_warn()/pr_debug() in damon_set_attrs() to log which
     parameter failed validation and why

I believe clearer errors or document would make DAMON tuning more
intuitive for sysadmins and developers.

---

2. Potential inconsistency in DAMON_LRU_SORT error handling
-----------------------------------------------------------

The documentation [1] states:
> "If invalid parameters are found while the re-reading, DAMON_LRU_SORT
 will be disabled."

However, testing on v7.0-rc4 shows that when commit_inputs fails (e.g.,
due to min_nr_regions < 3):
- The 'enabled' parameter remains 'Y'
- The kdamond thread continues running

This behavior may confuse users who expect the module to safely disable
itself upon configuration errors. Should commit_inputs failures trigger
an explicit disable (enabled=N)?

Reproduction steps:
-------------------
VM: virtme-ng 1.40 (x86_64)
Kernel: v7.0-rc4

    cd /sys/module/damon_lru_sort/parameters
    cat enabled 
    N

    # Initial setup - works fine
    echo 65535 > max_nr_regions 
    echo 3 > min_nr_regions 
    echo Y > enabled 
    cat kdamond_pid 
    91

    # Observed behavior:
    echo 1 > min_nr_regions 
    echo Y > commit_inputs 
    cat kdamond_pid 
    91
    cat enabled 
    Y

    # [kdamond.0] still alive
    ps aux | rg "kdamond"
    root        91  0.0  0.0      0     0 ?        I    22:03   0:00 [kdamond.0]

If this is confirmed as unintended behavior, I'd be glad to help
investigate and submit a fix.

---

Thanks for your time reviewing this!

Best regards,
Rui Yan

[1] https://docs.kernel.org/admin-guide/mm/damon/lru_sort.html

[...]
