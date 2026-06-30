Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4453240E8CA
	for <damon@lists.linux.dev>; Tue, 30 Jun 2026 13:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782824593; cv=none; b=kQrC9OTS3yrHUcJVb3So8vc5DPkwEQrBdBgjbwgiiHifgEYzuovzgAURCz4DvKx7QgfvfCGbkjejeOUxyFATxAHUTYt3iCZO6l+j3tn9OWMvqbmomoTzHDuMbTLwJAzkcKccsmOwH2IvmVkAI8nSPndzWAvaKHAxTICHKnyNDwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782824593; c=relaxed/simple;
	bh=zbZj1eTFQ2tN5Ip1rRIEeGbq1zUUXEHG4wyGOjl2ldE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cb+Tvw3KfxcpTxYztlyEB0rV/fZU+ZNCN9Gq/41TCA4T0kZYA/I/vhGozJ2rVirFjO4vJ64o5XPUA6EjQCZBAlOrjB9odBqq//6dTWQ+IlLD6UwFjVzQqjOd6K0X8OmIUOxRc/5PWeDOw2rE4ECjiDt8YbhKO/Q5IlhRgn1dVqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJGvWrTa; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJGvWrTa"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39b293079d1so1383491fa.3
        for <damon@lists.linux.dev>; Tue, 30 Jun 2026 06:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782824591; x=1783429391; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gdtD0uSCiAIlNZn+1RTzu5l2zkwsL/Gs7YEvXjMsVg=;
        b=eJGvWrTaue2+f78ut0PwYIi/y2FWLv4owQKq0UNtW4K7Zww9GvjX6P2OJNk13BeEWA
         vWvewnA7VXJ5RnLsmhegJkDlzWXbFTPFQGDJMVfuHCln41HPP+L2FPnb+4GutJ2ilnlC
         XHEtBYpkzc56QWBIxsFfqxUz/+LD0A6/PhYPIlJ8AuaLsrJ6GQqoMOzY7WgO8Fna/4a5
         33TFe0M3iPckjIpIOuCalnkaYkTY0MAC5oYDAvyYfvMNPygf4Pk/ivRRHfM7mgP7AVvw
         oVZBatFc73LYK/i3IeK1pfNKO4NWJUcJr7n3cjHIel+LAsIQPsDjs0/Rk1vc2EbAqks6
         3feQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782824591; x=1783429391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3gdtD0uSCiAIlNZn+1RTzu5l2zkwsL/Gs7YEvXjMsVg=;
        b=jf6f1iis/l5PSbAnPEGAdf/t1bTM9wdmVq5al9885thrIBtG2JamvEZ/UWP1zA897d
         7cpFHAoGvoi54Eek6ifKclnpW9GvurbK8L5KdMKtDOvlHHHGr/Z6ggx4fdvFWORO0C54
         p2l2ImDRsczj6TxZkFPHt+1WV4jmUISb6byrNnCnDUXfaWi9V1BTMOPlc/RT57sn99cP
         0RvizEs5GYGId4izbdHGqGZWP80LQJORoG7Q2u8biqiSVUlESr4RRTxmFdXcTe5117dK
         1jbcntsyJlW3BzhC73Z3w0wrYQOvC0QzBcTnzBQ0MCWIAmXRAywcq+MG9SvYCrp4S5de
         JKDA==
X-Gm-Message-State: AOJu0YzYzVSZi14MbdSN+RRBvHYQ7qSoG04kNw8/SY3lzYiAy7bQX1IQ
	00YN25ZKvZZSjizW9astVHMhukGNU5fiig5WbGPx5kmvX08kBBiY7Hb+
X-Gm-Gg: AfdE7ckmuaBB4/aobLCMCj/s5F51B5oA81abwzixSIKlKkQZgjocKt18i7xnWaVF6SG
	msWU0AIjxE2mM8Vs+2sSgLgnlPextuQzgMp6CCwlTg4tI0idfIdB3r9DSVrdNj/gm/+Igs7rn06
	sW57rmBXwh6qEhwZmvvT/IM/EmVdR45z9bUj8zCUJXJ2meEWXDNcJ2Ex3lDXpYg/ezeMNTt3eRV
	IhMAflNKq1HR8LQqv5xrDgm2ltMJLp+CdczUaHD5bMVsLp9fX6PQ6PXgL0z74sXao0pG12xRLSr
	O/ZRXxbRddFOYEP9izvIMyjW4X1chdivf/QCbo4+n+Oq8uqX3BOGoIE7847gf/r+UO6kQiLFCE8
	z+kUisOUGK3OeaYHnLS7DFKIr5zyCORdVeTUTn5YchxN87uBoDtN/IuHkJ2xRH0eFrxGrFk+CH8
	eBlg8bCx4O2b8W/rbIdKuYCuiZFNbzqbqjFUicL7Cn85Q7DI9esS9Y3ameSMYhcgmx8VRR9CLX9
	PrVHvM=
X-Received: by 2002:a2e:bd83:0:b0:39a:e29b:790d with SMTP id 38308e7fff4ca-39b1dffbb41mr8707321fa.36.1782824590328;
        Tue, 30 Jun 2026 06:03:10 -0700 (PDT)
Received: from debian.localdomain (95-25-158-125.broadband.corbina.ru. [95.25.158.125])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39b1da4d241sm5301431fa.32.2026.06.30.06.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 06:03:07 -0700 (PDT)
From: Igor Putko <igorpetindev@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Igor Putko <igorpetindev@gmail.com>
Subject: [PATCH v2] mm/damon/vaddr: remove redundant RCU lock
Date: Tue, 30 Jun 2026 16:02:53 +0300
Message-ID: <20260630130253.3843-1-igorpetindev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260629165349.4260-1-igorpetindev@gmail.com>
References: <20260629165349.4260-1-igorpetindev@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__damon_va_three_regions() is called only by damon_va_three_regions(),
which already holds mmap_read_lock(). Since mmap_read_lock() is held,
the maple tree and VMA list are protected from concurrent changes.
Remove the unnecessary rcu_read_lock() and rcu_read_unlock() calls.

Signed-off-by: Igor Putko <igorpetindev@gmail.com>
---
 mm/damon/tests/vaddr-kunit.h | 2 ++
 mm/damon/vaddr.c             | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index 563fbc7e3..70cb7825e 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -81,7 +81,9 @@ static void damon_test_three_regions_in_vmas(struct kunit *test)
 	if (__link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas)))
 		kunit_skip(test, "Failed to create VMA tree");
 
+	rcu_read_lock();
 	__damon_va_three_regions(&mm, regions);
+	rcu_read_unlock();
 
 	KUNIT_EXPECT_EQ(test, 10ul, regions[0].start);
 	KUNIT_EXPECT_EQ(test, 25ul, regions[0].end);
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index d27147603..345b89b5d 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -84,7 +84,6 @@ static int __damon_va_three_regions(struct mm_struct *mm,
 	 * If this is too slow, it can be optimised to examine the maple
 	 * tree gaps.
 	 */
-	rcu_read_lock();
 	for_each_vma(vmi, vma) {
 		unsigned long gap;
 
@@ -105,7 +104,6 @@ static int __damon_va_three_regions(struct mm_struct *mm,
 next:
 		prev = vma;
 	}
-	rcu_read_unlock();
 
 	if (!sz_range(&second_gap) || !sz_range(&first_gap))
 		return -EINVAL;
-- 
2.47.3

