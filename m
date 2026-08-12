Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE84400978
	for <damon@lists.linux.dev>; Wed, 12 Aug 2026 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529100; cv=none; b=OQ9hUFEO0Q+/Y5GXzcAkceAurNtUCLBDkT/dwWVPCWiayq5A7oktYiOgC4kpscYu85Q8IJzhAUz290SiETfCg3l9vbATLbaciEArVfwd36IwHGWfYKeQeEQue2+1R6tWk0U2zor9sNgxA1qY4fJ/qRTduwh+6Rg8sZtgOGEx1HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529100; c=relaxed/simple;
	bh=EHmNb5OrnnC4mKZ2Bjz94rRJJr1n/ZIhoUobvZIv6hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2vCsMQCazPVhhj7UwOVRebFM91NBAn8JTmxVnbW9ndghpou6OOujcUl8T08oGbTptN67WXjmzGYfMoJre/Gm7anuQsVcD1ozhMdUIYJa7JlQXcxXGerFCnSlKKxNv+js1fZQEf5juYBCOt2lMVgbHTwdBihlrVHADN/fg5V4wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nvB/TPUJ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvB/TPUJ"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e08baf860so922035a91.2
        for <damon@lists.linux.dev>; Wed, 12 Aug 2026 03:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786529098; x=1787133898; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5rY136w+JpL/ylEjfYfCsqSvAnSrsJPi+k0wPlzk9EU=;
        b=nvB/TPUJhKsjjWlX0/1BRnGC01K7itDELDL6EaubKJbawlk7sL+NtX3gxOx5pbBGSC
         4HETglBU89WhKzQJQZl1MJvnfy0TeqibvUrJFly0qD+8l7bLqnhYjeWT8bARnkdePi4i
         giNYVQOkfopxUXcT6f3QH0BKpiJZnbihjeiTwIkf5gYjnvfOJPDwLb1x/uwQiU0Ywouu
         mHJEeAvP9ee68vS1J/Qw5RUXWaL2WTLnFoZyLR9QDnWRG4xFAm/eWslTx1aJm57hkKb1
         zxmddp5yyMw+dckvlsxrKa4KYd40ylwuvg1TxRyJME+toI98/KpvpkKD7CxxDKqoQqUv
         qVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786529098; x=1787133898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5rY136w+JpL/ylEjfYfCsqSvAnSrsJPi+k0wPlzk9EU=;
        b=XMX5Ys+ykyFHyiuhwk047OU0TW/NK/PBehMQVA27jjux+cpT1VnlZjAHXaeat+m2vk
         z5Xs7TaPJbYlnwhOA/uRRpG0Rbs3kWEMuKteuaIaVrOfetQfaEh3DBsmu7QfozsfUx2K
         3ceaz7TRAnayybxp6tydH/c2R7Z7KHJhsOEMDq4vy4YsdC2Fd+ZkCSg/XHf4lJLIDNTA
         19zpcySx2MeZ33UvCmgEXvtduuWVdZxIQ7dNOix6w6R2bGy7Kgf55NfVsf9sHpqGasVg
         fP6B178X10KD6GOJ7r/bHZel17//rZ1AeOLPU9c3mdjbpysSl6v38GfRMy0RfOlEmp85
         pBSg==
X-Forwarded-Encrypted: i=1; AHgh+RpLXxHw6sTyGQHUl42YMU9BQzM6hF4gkwuXwHO0lIQeGYQKRNp7/ftwfZxX8p7HM2HX8mXpvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy56czDLxTHdsWBLaVdrxRgYuTjuZWBxKuvGTIHD0b0qmwfq9SR
	uHp0fMr+pxBPjejbK4WPpcexkhdZCyOgYctoL+FAwOtgFOk+0X/gj24T
X-Gm-Gg: AR+sD13fmqnokVk9sQZ4Nj5dBOyLi7nuMyHb9QK8aolG9FTuFbf/z2vBsz954cGXSFi
	5N18RWcDUC6rJpzjKXdrkkhtOI3gUk8CXUwxBCCurQ6LOMo42Ehb6PfblKRowIEzFnttR6TNlpY
	uKz41cO3sTaPpYnPESEXip2OrtpekEe0kZEN5yxU8oRYjcznPrxh+a8q0e8uwfBgqngFxh3ffW1
	TA0pkW5YyjP47xY/ymmZfjcFSkSPVoboBgzLqB2CsG6YkIEkNni0ecHG/0f6jlgKcX4hWmnWDv2
	nJ5XkBPnvPVMp9gpy9n5piVh5TWzyC3kEQkkhHAm8tbSSnOl85NIbfbQlD5sIf/ecbAAXfDnZiB
	WHkBC8HWq2Vvb5bi+NnqAl/X5GJn3Z69x3b0ffL4xFkn72WNhjZdplrxQgvJ/HLtHpy3fesaeTf
	E4uqqd6oKD5yop3Nse0RRJ7HOs5FajVL/Pmh1dktsgkVnayuc098VL5Jp0tgIxBdV764NKNeV9x
	MXN5RsziZiK/ZU=
X-Received: by 2002:a17:90b:1a8b:b0:38e:fea2:df53 with SMTP id 98e67ed59e1d1-39301253b3bmr3943475a91.4.1786529098246;
        Wed, 12 Aug 2026 03:04:58 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:85a:5c46:85a5:ec7:8aa8:72be])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14124454d3csm8821247c88.2.2026.08.12.03.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 03:04:57 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [PATCH 3/3] docs/mm/damon/design: fix typo of max_nr_snapshots
Date: Wed, 12 Aug 2026 18:04:33 +0800
Message-ID: <20260812100433.6288-4-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812100433.6288-1-aethernet65535@gmail.com>
References: <20260812100433.6288-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes a typo (nr_snapshots -> max_nr_snapshots) and corrects a grammar
error.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 4 ++--
 include/linux/damon.h             | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 1fcf0b8c044b..62ba6cc2e999 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -871,8 +871,8 @@ action is ``pageout`` while all pages of the region are unreclaimable, applying
 the action to the region will fail.
 
 Unlike normal stats, ``max_nr_snapshots`` is set by users.  If it is set as
-non-zero and ``nr_snapshots`` be same to or greater than ``nr_snapshots``, the
-scheme is deactivated. Note that, unlike watermarks, even if a scheme's
+non-zero and ``nr_snapshots`` equals or is greater than ``max_nr_snapshots``,
+the scheme is deactivated. Note that, unlike watermarks, even if a scheme's
 ``nr_snapshots`` reaches ``max_nr_snapshots``, monitoring will not stop.
 
 To know how user-space can read the stats via :ref:`DAMON sysfs interface
diff --git a/include/linux/damon.h b/include/linux/damon.h
index d642ce4fc83c..75ece3d03be2 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -549,7 +549,7 @@ struct damos_migrate_dests {
  *
  * After applying the &action to each region, &stat is updated.
  *
- * If &max_nr_snapshots is set as non-zero and &stat.nr_snapshots be same to or
+ * If &max_nr_snapshots is set as non-zero and &stat.nr_snapshots equals or is
  * greater than it, the scheme is deactivated.
  */
 struct damos {
-- 
2.55.0

