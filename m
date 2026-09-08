Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66803568FCD
	for <damon@lists.linux.dev>; Tue,  8 Sep 2026 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788889954; cv=none; b=q4gyPGdiMgwR2/pw4BjtSrl21fKRfshrMQ3EgwZUecTqzeP3L+yHNoudpt6BggqS+Clensv2qSgAPz4w+89sqXZSkP5DfGIkAph7/lz2fPJP0Lb+Z8s+PeqLaWjpP7AuO/rDm8DxKs5Y4neE+VYEy1xVctwUvbVL2hLHXfrbk7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788889954; c=relaxed/simple;
	bh=KLjeMvdxyqc6SnotIiFUKvLtc/Zy+nfps2KNDr3g1+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d9QVsNOuPQpzhE0KeEIAXqddzai1LaimjlJ6xi6Z4RvfmK4i+nYvN8HkofmBYmNHCscqeScbIKAHNEbtr9rKzK043Kxg/dSBFRvE3EVp22e8OrCEc9rUtDf+4ghi4P+wEFnA/OkO8WlVURJsWnN8LvBb4yojH7H+FxN8Y9pEMwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBmGvKO4; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBmGvKO4"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc1c3c90074so4185403a12.2
        for <damon@lists.linux.dev>; Tue, 08 Sep 2026 10:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788889951; x=1789494751; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yuf7kW9a8gMm8dZPCPYh7BVn/yZWMPnrvgi9MavGUdA=;
        b=mBmGvKO4C6rvkGfUrSbi/G0FuHRLQMD8sFG7WILxKnv3KosodntLfkDG44qrJXLh5o
         BMLd7RwvZzjborbLpwQYTfYiIWB0/d6dm+59kTMbHcwMClKKQjUWPOiuMRszGPUxwihF
         UulKZKYH+Kru9m/slJa/6zgYjzHN8JcsuUSgIne1gti6wNEWRm5/uMPMkq1J6W5Il1cK
         A4aPNxrfU7j96ZdyhDkRtroJNkdanRP/lgUObpj51N/xE4CIKwsSNzu34S3sZrawjGRT
         u0sYTInPt1l9BfRU3aZaZRkioUb5y3WpagfCaqslnctxTaxCUT4Rz8rUiiLXEhdFSPwh
         t6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788889951; x=1789494751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yuf7kW9a8gMm8dZPCPYh7BVn/yZWMPnrvgi9MavGUdA=;
        b=RMh8RbNXE+YGOF6PLhsHqMN2AVHaAsZPgvqfWynTnYoS2ngl4245IdW0P5fnsmM33r
         so+e7OnAliCbpq5wworkoxk7zCShX7Qw5/IuAQUdL2zs2uS8YlYf185Mtk2EU0cJPd9L
         Iv8wYorDobjvMaTa5BtF9v6h9e8vWu6oIOTTvwE3N9Pks4bW+FrP7KbAWhyTA4EXeSWL
         vGP1OSu/YtFyfbdDO3cAQFlPZxK9k+marJUVf4hcvE5kG5VTjIK32OryaRwltCbkpQIg
         idZLRFVzNJgN8Y70l59tvEmMGD6HIHOT92iZ/qGQxq7x9+zg5BhFCXMwLi6Y280mGgMM
         jqUg==
X-Forwarded-Encrypted: i=1; AKwUvBxYsj+xekO1BCs9F8OAMtuDY18cfEbN8wHob+llOg46xyZdVrF/TnPxwIvVF6tFJCRjWM5drA==@lists.linux.dev
X-Gm-Message-State: AFuF++kNjtLbYeqKh6wd85fqshZ+5z+5Uhz7qPv5lsuXPiu3b0nIkA+A
	q2Vg4PVQK4m87nqJhwhFQRB790e7LTFuEs9ITLgVOkgM39/cNwm7rwaK
X-Gm-Gg: AYBFou1w94eguYlp/51rx4olucbioaJNZMQkxlFUJM89l0eNV8SfTIKr+79P7TC51ua
	ALuM2NyA18Qhyrrv+tQ6r8Rbk4RrUlHnzyaHMxeNgFwYdZ5pGTQQPYFj/94TDTMBe3d3ENryd+I
	Bp1o3HJeJgkDxri38NDb+t9l7dNQUI4ALwUcCMqYYf9dxhajI05UsahmBGYafbamz2ZomSyVKJ0
	ma9RY9Ml2NcklUyQ5xc/vMbJ5mHllS2M09PioHQyoO7D4S6JZZRazaVdOM4P/44ClKbyiF8N8jP
	2LQZfdn5+vHVQOZTr0zIjBAuwMOD1cEbPiEpE01isobn2JLGTzeOzFPRt4K5lzwmlNAXtYQJN9w
	D5m2VWIh2OMrrLhc+riQggDNHPE1op5wsLRq/pJFLKMlt3hnWJsrjkw7kk/5VNDJvTIyjgdR5Ag
	ii1QLaJlO9/eAFjR6yU/z1ftIa9GwuMRVlXCIrHpd/Ktk5mbMOLBgjORLMAuaD3eF+mC2sInoDm
	NbSIE6jXb0RcpUGgA==
X-Received: by 2002:a05:6a21:d82:b0:3d3:af86:fb94 with SMTP id adf61e73a8af0-3da3a246eb2mr48825562637.26.1788889951323;
        Tue, 08 Sep 2026 10:52:31 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:885b:4183:b098:c1b9:7033:be8a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc45a6abaa2sm5384356a12.23.2026.09.08.10.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:52:30 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: 
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] Docs/mm/damon/design: clarify when qt_exceeds increases
Date: Wed,  9 Sep 2026 01:50:23 +0800
Message-ID: <20260908175105.42558-2-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qt_exceeds counts how many times the quota of a scheme has exceeded.

The value can confuse users when the effective size quota is zero,
because a zero effective size quota does not always mean the quotas are
unset.

If the quotas are unset, that is, both ms and bytes are zero and no
quota goal is set, qt_exceeds never increases.  But if the user uses
the temporal auto-tuning algorithm, the effective size quota becomes
zero once the goal is [over-]achieved.  In that case the quotas are
still set, so qt_exceeds keeps increasing once per quota reset
interval while the goal stays achieved.

Clarify this on the design document.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---

By the way, I found a thing in the design document that confused me.

    temporal: More straightforward algorithm. Tries to achieve the goal
    as fast as possible, using maximum allowed quota, but only for a
    temporal short time. ---> When the quota is under-achieved, this
    algorithm keeps tuning quota to a maximum allowed one. Once the
    quota is [over]-achieved <---, this sets the quota zero. Useful for
    deterministic control required environments.

I'm not sure if "goal" was accidentally written as "quota" here.  Would
this be better?

    When the goal is under-achieved, this algorithm keeps tuning quota
    to a maximum allowed one. Once the goal is [over-]achieved, [...]

---
 Documentation/mm/damon/design.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index d036340dae8a..e083b74d618b 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -863,6 +863,16 @@ scheme's execution.
   completely tried to be applied.
 - ``max_nr_snapshots``: Upper limit of ``nr_snapshots``.
 
+``qt_exceeds`` is increased for schemes with set quotas when the quota is found
+full at a quota reset interval boundary.  While the quotas are unset,
+``qt_exceeds`` never increased.  However, a zero effective size quota does not
+always mean the quotas are unset, if the ``temporal`` :ref:`auto-tuning
+algorithm <damon_design_damos_quotas_auto_tuning>` is used, the effective size
+quota is set to zero once the goal is [over-]achieved.  Since a set quota of
+zero effective size is always considered full, ``qt_exceeds`` keeps being
+increased once per quota reset interval in that case, until the goal is
+under-achieved again.
+
 "A scheme is tried to be applied to a region" means DAMOS core logic determined
 the region is eligible to apply the scheme's :ref:`action
 <damon_design_damos_action>`.  The :ref:`access pattern
-- 
2.55.0

