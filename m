Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6426D47252B
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 11:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039371; cv=none; b=AQ25KhsTPMuaXvMMnbA1f/2iyYZsAOyA9zV4pamoDA0MQl7zc/0ohhkK2jxZHzuuiKj5WO0Lb+gwvQRDZ03TnaoUlr1aKPoAhX2NrXmXimRTsy7UbX4mFibSGmFs491pNm9OhioxA4rO009B3Ndy++jhxNGoD7Kwkaxj7fj/Y90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039371; c=relaxed/simple;
	bh=M8X+lWYr0x1xt9g0855Z+8t8fxYXiqA6yfULgUlqBcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CpBiMDZjVGCHmQVWJyINPpUb7jJbZqC2DL6SdGwoGtIlbhapHVAvkKfbRlEOf6NaJM2q/SZKtC0qy/xLLAABzuKy4t0av7AAkXkMa1ukP3lNEj2p0OpV5Wi0wwu4cDJVeciZT4hhrtn9Ju0hr2+JBWUE+WCPLgqNQzt7mPO9Anc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arBRk+CA; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arBRk+CA"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8693af0d7c4so1296055b3a.3
        for <damon@lists.linux.dev>; Thu, 10 Sep 2026 04:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789039369; x=1789644169; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2ad0A/Rr65EAuzEvke4bbMmbpC8hQdLLHmef4KcXvFA=;
        b=arBRk+CAbB1bFRLuIMxqjgg+Ty7lpDMMbbdY7tBRGbJoxw+r6h8L6tc4FzAwL9lF0/
         1A1C4RANdoWPTy4aSwrcQgDDgD4EQCfzAJ6l88uULmOXxsQrDxKczX3iq7xA5R9//eGv
         MuQD9B03NhFdsAOCCFi4I/tdqaXaNvObyYVZkQEYIgs8BFddWwO740Sj4S67VIMRkhcB
         y7v1KsMjtlv3jKa6dv8JUuydy4CqZKwVPDYPnm8RllqlWpktSffCEde2smB74QGmL/jD
         RN/F5XlAPm4puBl8Jo3zHGtgaROVZTcOR98b2LZHBsV34K+l9xeFmKWUIBdWtwYTeFjD
         oveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789039369; x=1789644169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2ad0A/Rr65EAuzEvke4bbMmbpC8hQdLLHmef4KcXvFA=;
        b=ZHZePRssdjvFpZsEMKGHrnUcH7fJTAEk8UzFfGaDm5nyRnSvBvJy5KVIlb31RVB8rO
         MHC7J5//Y3gs7HO+A9/DRFqEHfsZm8j0JjuKP9QCAnLA3utM/b4b5cUVzTTs9dB3iqjo
         Oy+TQD5buIFsaU2p1WK1AOJ40J4ZkVUOUjQngnslDacMJ8j+KFFN0Ag79jXrffqKqwhg
         3QBb7FR7fiYtUI1HDvi+HE+oA89fAcE4aeMEuKERQI4RqL9Fxp4dc0Ji0tUE0+ymTam/
         if7XfmhzOmw+HPecjjEKm9YqE60b6NuuQLBDCkS6/NgkMMqyIi8SCLgR3Ay7fjAZVjNo
         5ZBA==
X-Forwarded-Encrypted: i=1; AKwUvBxbiITvKVRM2NwpRgxFeA6fAa6/TEfZ4OgekcpBzygwvKjq4K08XOqTgkXL2DGxCKW2RT3L3Q==@lists.linux.dev
X-Gm-Message-State: AFuF++lV25x6Pj9+Z7eguq/G5OMPWv09fwAabciym4bMZ/5ZqGLJbmJg
	ZAFgvr7ju3d7xXbeXOyfKrALfAlk/n0u/vNuk6+v0TrnaTGUBdpl7+o6
X-Gm-Gg: AYBFou1rU/BwJyCyeohgJKxx4hbm4cjlIOAUUcXeVl0V4eAqm/XCRBRGkcqyXTkWvup
	GJC6q1e34/447LWTt47xOiMUyO1+M73RmQuZdPce1ss9vEXOov7ofL5aqTTotcCItdHFA9IdsGC
	kPo09zCzUEeDZtSIjbs7WZszr5R013LGFdxV1c8JvYMoQrz/mj1tewqaJMnyfRQwC9k6bdOSFCk
	aO6E6n99T3/UKXmO6KZOO+qjjmEqbZZ01booF/GN8wd9Avmz5P991Z9JOPrqtWzct6sRCxLl0hn
	mfJenxYhTeMAUXCS3ka+Y4ROJzfBpY6DcWsUmfJYg+k/C7pTWhxQa8CfT9V4QUoHYA+hXTgC8Bi
	eB8Upyu1OFhN7Pdq/mL1D0fMlILiDlimQoZbiwtfLv1A1fy7lDV7SkAZyluecUYC17NJB2vndLr
	fSrRF6Tn9KoqfkWPHo3aQcooH0KKxumI5b/t/0d045d3hhGK3377QiBOtjaFrWqtgfO5Yl2XSNo
	9ci
X-Received: by 2002:a05:6a00:300f:b0:86a:8e9b:46c8 with SMTP id d2e1a72fcca58-86a8e9b6359mr2124764b3a.0.1789039368714;
        Thu, 10 Sep 2026 04:22:48 -0700 (PDT)
Received: from celestia ([2402:1980:885b:4183:b098:c1b9:7033:be8a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86152045e8dsm7926904b3a.20.2026.09.10.04.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 04:22:47 -0700 (PDT)
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
Subject: [PATCH] Docs/mm/damon/design: clarify when qt_exceeds increases
Date: Thu, 10 Sep 2026 19:22:31 +0800
Message-ID: <20260910112255.157012-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qt_exceeds counts how many times a scheme's quota has been exceeded.

When using the temporal auto-tuning algorithm, the effective size quota
becomes zero once the goal is [over-]achieved.  In this case, the quotas
are still set, so qt_exceeds keeps increasing once per quota reset
interval while the goal stays achieved.

Clarify this behavior in the design document.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---

Changes from RFC v1:
- RFC v1: https://lore.kernel.org/damon/20260908175105.42558-2-aethernet65535@gmail.com
- Simplify the explanation.  Do not provide a complete definition of
  qt_exceeds, but rather explain only the increment condition when using
  temporal auto-tuning algorithm, simply to prevent users from becoming
  confused and being unable to find any explanation.

---
 Documentation/mm/damon/design.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index d036340dae8a..3f38a3cf68e4 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -695,7 +695,9 @@ There are two such tuning algorithms that users can select as they need.
   fast as possible, using maximum allowed quota, but only for a temporal short
   time.  When the quota is under-achieved, this algorithm keeps tuning quota to
   a maximum allowed one.  Once the quota is [over]-achieved, this sets the
-  quota zero.  Useful for deterministic control required environments.
+  quota zero.  Useful for deterministic control required environments.  Note
+  that the zero quota is a valid quota, and therefore ``qt_exceeds`` :ref:`stat
+  <damon_design_damos_stat>` will keep increasing in this case.
 
 The goal can be specified with five parameters, namely ``target_metric``,
 ``target_value``, ``current_value``, ``nid`` and ``path``.  The auto-tuning
-- 
2.55.0

