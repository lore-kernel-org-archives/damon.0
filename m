Received: from mail-yx2-f10.google.com (mail-yx2-f10.google.com [74.125.224.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96294534451
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060630; cv=none; b=qQM7BgHUbMDIKOCNoS/IHRvTlTMKB7he3n+fTa94532Veknon7oVc8/bwGMJfEHy8qSlUjkwL4jfEPBKpveeuguN9ZvjLBrssxUmp57h6kJOwDaQ1r5tG8t7xcYQuDIPnU63Mv7Fa89J5sC7IVYrYerP1HTkERSvtK4vZbjGK7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060630; c=relaxed/simple;
	bh=1oqaa9bELSRKW3Ogntg3bC/zWki6imZPjxfFvD10X4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBOR510bXe7blDenTdU+u7XNGppLsE+sz4n5vWYJ63mw2fe2GzJXLueWdTRBHO8ySSmDvZZxbvRehTViYpgRvKyn8IHgZjilsyeoEaSsPJbd1BP1foXJDnPXn3WjIJNmhDIcW8ey08wFbQjFv6wFM+WkO+6ybjJptuY3vstdVjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lANbuMl1; arc=none smtp.client-ip=74.125.224.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lANbuMl1"
Received: by mail-yx2-f10.google.com with SMTP id 956f58d0204a3-66e56a1fe8aso2093837d50.0
        for <damon@lists.linux.dev>; Thu, 10 Sep 2026 10:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789060594; x=1789665394; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G/4KB/W5umJ2NwhZ9AnF6tdCnGIfxiKJfL3QRGzZeTE=;
        b=lANbuMl19B+6GgcGWP85+nfMNSXdppJgBaCNXHQ1ldqDaXVrToK0EMdfG4YqlhNmZG
         9tpBt0e+kZRFrgHRmsxvVlRjrEeWYyqqjd5VpkkhNW8Fb0vecz1L9gGzzHfcbDwxjl4H
         sIpfOxoX02ZHjx3zXz3NaOV70C7U14JEGM85KcOjDYN0DEgrmXd0yvw0NVX4726lW+Gi
         QAP29fqXDLtOBaqQHCYm+spcWl1jSmrZ9xiPcjm+beTh0l9iVPwFVpKQAznMZ2Dgau6q
         7O81nTLmqypcf7ZF2VBXy2hbaCVYKXiqUA/5lmSKtOTFFl+4WxhH4fPF85MpGFk+Kvma
         uriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789060594; x=1789665394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G/4KB/W5umJ2NwhZ9AnF6tdCnGIfxiKJfL3QRGzZeTE=;
        b=EQbr6TWzLGGMn0KSEPzo+HpCHmO8y/Jka0Ska5tKUHy81rzPHY7I0WZHWjUfzBtZYO
         pp4uxzRoGWuNQxXXmYaQPqKWWDWXeUuYxj9LpmLpfJQ6otB9OqNQIczM1boQergvEHwS
         Hae5QR2P71jNh2xqYpjm4kZnbjC8fPhR+/hjHPt6e8u4AzhLimemPRuWas2YW7CaCyEo
         LXNcrp+tNCWl/w6e9V3GW+id7qgknDhE3UXvFvrY42mSiX6TtKTxpbK/3qxhD4mpGuxw
         LKUx683adeHqCU96df4F7LX6OsfMbrUAvkYHke5Bnr/B+qZP4tygJeoceg2dF0bRUj1w
         axng==
X-Forwarded-Encrypted: i=1; AKwUvBzbOy2byY7rkTYZ8VjBXuq7dyJq800ROmv5Cd5B9OWg7tfDaduz8XJzrwoASAWHvBa5SYh2uw==@lists.linux.dev
X-Gm-Message-State: AFuF++njhxtPI+VB+LGipo0R4NRbvM1/c+Fo8uUX38pJ4cdYgUwy+ADZ
	4RDNIuVz8YKGYakZnpU2rw0AGWFcbXEuE9sS2FpMrZ7BQ55WaCxtB3NV89W8HSs=
X-Gm-Gg: AYBFou3mk0NYs5Di0tEmNXgOdyPyihb5yFl+DNsSKf1sr5lsazQxQogqQiZDOMGJOBG
	H7jCI/8xcYtKC3UteTT2ISvWN4eZ4UCUr48BTGXH1zS7EYMOWfrWP6p8MLa6MNVy/TEgBH+Z0d4
	dPvmlOX4na1CT0FhgoowFhL65us0F6uzj2s+aiUO/vb9up6ol/lZbPkJleWozNDXVCIUVQSakFN
	IlzRw9e/ZWtivV4EtV/A3UlEzIMDNLYvr/d84QipJeKpcujDkhJAUBH0b/syxMTO2DAzBkb/c10
	WXTlsArkCJ5T4UC7CeTGvvm2lTcd9qRbUHJlP7RQ8yGvshvQm42i4erBN0tgzOCojeSBmnvLt6j
	HJUv6nUKe27Vx/g2xLPLOHvR7+Dr5PG7TwIK7gvC16/qoP9awug0SuxWY8TD9q8FSKtXWXThNb+
	fcOZ0dfcJTuoAn9lmpzLMMGQGzSQAKkcoFIfqzsPWkfTQdSEVpgS1PHWGOi+/86YDA8/JeOp7/I
	DE0rb5lJxx85lsA9X2BKauTko0rmvX6u5Xe55YAiZYNI1ZkrG1YVTi4R4mU
X-Received: by 2002:a05:690e:4503:10b0:66f:c1be:84c6 with SMTP id 956f58d0204a3-6712473ff01mr113462d50.52.1789060593948;
        Thu, 10 Sep 2026 10:16:33 -0700 (PDT)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb48f1646sm14291862d50.9.2026.09.10.10.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:16:33 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
To: sj@kernel.org,
	akinobu.mita@gmail.com,
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
	ravis.opensrc@gmail.com,
	rientjes@google.com,
	weixugc@google.com,
	jic23@kernel.org,
	gourry@gourry.net
Subject: [RFC PATCH v2 3/9] mm/damon/paddr: lock the folio for the page fault primitive rmap walk
Date: Thu, 10 Sep 2026 10:16:17 -0700
Message-ID: <20260910171623.6638-4-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910171623.6638-1-ravis.opensrc@gmail.com>
References: <20260910171623.6638-1-ravis.opensrc@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rmap_walk() requires the folio to be locked for every mapping type it
walks, and the page fault access check primitive takes the lock only for
file-backed and KSM folios, so a plain anonymous folio reaches the walk
unlocked and the walk does not install the marker.

Take the lock unconditionally, as the other reverse mapping walks in DAMON
do, and release the folio reference the lookup took on every exit path.

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 mm/damon/paddr.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index f4fa7c231e551..5fcef3005c536 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -91,21 +91,25 @@ static void damon_pa_change_protection(unsigned long paddr)
 		.rmap_one = damon_pa_change_protection_one,
 		.anon_lock = folio_lock_anon_vma_read,
 	};
-	bool need_lock;
 
 	if (!folio)
 		return;
 	if (!folio_mapped(folio) || !folio_raw_mapping(folio))
-		return;
+		goto put;
 
-	need_lock = !folio_test_anon(folio) || folio_test_ksm(folio);
-	if (need_lock && !folio_trylock(folio))
-		return;
+	/*
+	 * rmap_walk() requires a locked folio for every mapping type, so the
+	 * lock is taken unconditionally, as the other reverse mapping walks in
+	 * DAMON do.
+	 */
+	if (!folio_trylock(folio))
+		goto put;
 
 	rmap_walk(folio, &rwc);
 
-	if (need_lock)
-		folio_unlock(folio);
+	folio_unlock(folio);
+put:
+	folio_put(folio);
 }
 
 static void damon_pa_prepare_access_checks_faults(struct damon_ctx *ctx)
-- 
2.43.0

