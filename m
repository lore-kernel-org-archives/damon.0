Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793239054;
	b=1UsctjNtjNTqZsXTVDjDI0s6mkW169QvpaKwVv/cPh4qspnkb3+BCsWr0yG3HFejRaLA
	 u6RO6rWnJ2PLRMa9LeEjYo5dalXxxxizeScDgl7Eix+3hd9pRWQHCXDVc8wtsEFqgFoCM
	 SSeE4+RVWCoINb+eglNPtsayr+dHJRA/+kIO7yPgwk5uEOUTPlPQyQc/+5DHaYPTIknOA
	 lZKF+xsd2UHXFPbqHF0/x7wEUMXoSaOKplmNmsdkDsvTV867dzw9JlXkQVivtVnS4x98i
	 2W6pJanMh5sZ/hvzFTntP1+ugP21CnjraC7VULxbzzJnaKcWq8hSHiaHnDbeWjqPaxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793239054;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=BjcCXH94r7SdjUIQrzA7CN3lEGDn7+Oy+/jo/lJEHMY=;
	b=ogJsWRjvUiOE2DiFGl7yAu5xHkvCL8HeW0Y1XgpFhRe29JYs4971bbWv5bDPtEsCuaXn
	 8AP6Ou+TyQMo9GAe83I4htZIkklSEJkm3wejSha61mq2wRU6aOjRw2KlGIK+/gqTwlixI
	 lA9vw9sEPnJd+OzqzuD5M9VbOB1GDS9nX9zLIVDr28yAbCl4F7X6b8oVWhcLse0zwomTi
	 zNBPGhPbOY7+Z7XIJAugLnRbkh9qSA1GqJIA7Y5i0wZnK9SXtcBUxJCzNeEflv4dokCcj
	 lvRr4dYalntKyFPOF7d+UB9kl9VvyYl6UnEk0eA6pFnQW8QkbK59NuB2bxOKJwHtJwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h5DPSUAx;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4A7606A31C
	for <damon@lists.linux.dev>; Thu, 29 Oct 2026 01:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F4A7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h5DPSUAx
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a064fac8cbso1183480b3a.1
        for <damon@lists.linux.dev>; Wed, 28 Oct 2026 18:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793239054; x=1793843854; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BjcCXH94r7SdjUIQrzA7CN3lEGDn7+Oy+/jo/lJEHMY=;
        b=h5DPSUAxVfWKnn5pR3RKWng8k2xm5Uo8P45XJm7TLb9HYwm9Q4vwNA3ekcQsou1Ugf
         u8Y+XZNJN1BoI496RYeShPkSEILF7TReWqSIqpgUGQitZNGmH2+13WFhj3RHrSdEYdHP
         pFIcLYxZkXT/L3zdJQx14v1s5tTbOmLJ7Os6ODJGLHsBxO15MAwoKg6nKQythcykm2Uv
         73aq4qUtmI9PSueGUMYqHrQ+JG3aSFOqVTUWkPcJJDrP8q/JmScLjJH3oBJCf08cIQRB
         kYcV9i2S98+bU7/ok5PvOFOfOsoOlHuy6M/IukH30Uwnod4EA0poRrE3SSh61HGDr5jr
         hsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793239054; x=1793843854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BjcCXH94r7SdjUIQrzA7CN3lEGDn7+Oy+/jo/lJEHMY=;
        b=UhW1ojgwpKDh3bzQBy6oQNVdtM07wiOb2qBHHMjZMeTqRfdXCNVErbLJA8vvqBad/v
         sKtcy5Jtd8OHiWtVydT8U0Pd+JfoJZKeFqyf5kGJv8361BpytenUn64FhbqN6HdXPlba
         ud4oX/apyX8jswdqVeNGcJErmZu/n5H4eSYj91wc3VR91oXGdFPy74FHaOI6LjzkjcBF
         uwEnHCs3i8qXz8TkeMLwlMF8sEJKxLlSypTREuHNuSop+yprDPQjTL96fwuMKSJB+dk7
         QKJx4ruf2buK4vfUtfhF2Y38rRrucRv/YNDzy2fp0UoUVtoW7BaDxRjbc+KhiprKFVO/
         /29g==
X-Gm-Message-State: AFq9FYLJcR710IGiF30kNrMLosiaScC9n1FnWNEhgVn+NUx6oxMGK8fs
	tfzQwPPVfpL+M1iaUao/7wzCClv0hqO0h07B2lzGcqbhu5eO8N4WLfMr
X-Gm-Gg: AYBFou3phLM1eAMw629JI8bSJMCw1rZjUTirMT6hN4BrvLU9jWGPAbTR+XyGn+X6JRz
	Tb27lgVEfagGxcbuzSjSOZD1iBwnQ0NXqcVPHK9lKSyu2JX1ZeNpqKZxZ4iWs8Uv9ohk/HVzlL4
	5Pm6oIFE8iMyd4jM4c3/5D6FzSJwhAtbnJXtfjvz8xFOHpwQ0owEBr/tJSAb5FBzQA4p3pVfjmN
	Yzsm7ajPGkDqcHXdtvAzeUEHvsa5NVcW+j2UAU1rtsWbJhvAiNNscwxTwMqUxdP8Dw3k7IFeaHK
	7chvYnV6x7WyjRRY+L0LLConHEdj05ysX1w5V/QKI5hsjQOHqfg0TQ1VmnOxz9HalzJ2dp1KgdE
	KxoTDh2ekcSzdcLHyVl/bxFU8PMC3BKQdJndSdedRdSdqj2n0kNwM/aZvDObKEYGsyeEsL2vvfW
	+UG0/SCAWXj+K3E7vwE7uzUZevjQKyJDfTuu7r3LwYLW2ED+5mPfGxxl58Y2jhMcC9wGaHqls/w
	aTJ3+80PORjv43I7fjrwMpSV9sqI7dL6FFvrle80+rZaPplpSye5l9e+ODRiXHTIX+SKPOTGXI/
	nVok22orcgFJlr275LN99E4/Qq2TWHmAyFt2Mu/id44USJ284MLuvKDMM0asOrA=
X-Received: by 2002:a05:6a21:39a:b0:3e2:8f64:e4ff with SMTP id adf61e73a8af0-3e9023c11b2mr3442531637.31.1793239053550;
        Wed, 28 Oct 2026 18:57:33 -0700 (PDT)
Received: from xiaolei-VMware-Virtual-Platform ([219.142.21.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8cccbaaa9sm4534694a12.23.2026.10.28.18.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 18:57:32 -0700 (PDT)
From: Xiaolei Wang <xiaoleiwangxiaolei@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	error27@gmail.com,
	xiaoleiwangxiaolei@gmail.com,
	yanquanmin1@huawei.com,
	wangkefeng.wang@huawei.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Liam R. Howlett" <liam@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>
Subject: [PATCH] mm/damon/tests/sysfs-kunit: fix leaked pid reference in add_targets test
Date: Thu, 29 Oct 2026 09:57:25 +0800
Message-ID: <20261029015725.17378-1-xiaoleiwangxiaolei@gmail.com>
X-Mailer: git-send-email 2.53.0
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

From: Wang Xiaolei <xiaoleiwangxiaolei@gmail.com>

damon_sysfs_test_add_targets() creates its monitoring context with
damon_new_ctx(), which leaves ctx->ops zero-initialized.  Since
DAMON_OPS_VADDR is zero, damon_target_has_pid() returns true for the
context, and damon_sysfs_add_targets() therefore calls
damon_set_target_pid() for each target it adds.  That function grabs a
reference to the target's struct pid via find_get_pid().

The test then tears the context down with damon_destroy_ctx(), which
releases such a reference from ctx->ops.cleanup_target().  For the vaddr
operations set that callback is damon_va_cleanup_target(), and it is the
only place where the reference is put.  The test never selects an
operations set, though, so cleanup_target is NULL and both references --
one for each of the two damon_sysfs_add_targets() calls -- are leaked on
every run of the test.  Running the test with CONFIG_DEBUG_KMEMLEAK
enabled reports the leaked struct pid objects as unreferenced.

Fix this by selecting the vaddr operations set for the context before
adding the targets, as the real usage path (kdamond_init_ctx()) does.
damon_select_ops() fails if the vaddr operations set is not registered,
in which case the test cannot exercise the pid handling and skips
itself.

Fixes: b8ee5575f763 ("mm/damon/sysfs-test: add a unit test for damon_sysfs_set_targets()")
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Signed-off-by: Wang Xiaolei <xiaoleiwangxiaolei@gmail.com>
---
 mm/damon/tests/sysfs-kunit.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/damon/tests/sysfs-kunit.h b/mm/damon/tests/sysfs-kunit.h
index 138a4b8d14e7..634387c6178b 100644
--- a/mm/damon/tests/sysfs-kunit.h
+++ b/mm/damon/tests/sysfs-kunit.h
@@ -79,6 +79,14 @@ static void damon_sysfs_test_add_targets(struct kunit *test)
 		kunit_skip(test, "ctx alloc fail");
 	}
 
+	if (damon_select_ops(ctx, DAMON_OPS_VADDR)) {
+		kfree(sysfs_targets->targets_arr);
+		kfree(sysfs_targets);
+		kfree(sysfs_target->regions);
+		kfree(sysfs_target);
+		kunit_skip(test, "vaddr ops not registered");
+	}
+
 	damon_sysfs_add_targets(ctx, sysfs_targets);
 	KUNIT_EXPECT_EQ(test, 1u, nr_damon_targets(ctx));
 
-- 
2.53.0

