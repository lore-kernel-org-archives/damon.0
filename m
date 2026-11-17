Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.201
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794935798;
	b=Cn+5mIjl3dPySlM/nCjkbAHpAwSxPbZ7S+rA726f9A7IFZZy49ID6C+uGNgrBEFVO4Ov
	 mhRpSBmZo5kO4d39MXHpht5aMzgy7MppIOJS1oEyo6//V2eitg3bJG1Z/9y0LjglFCgGN
	 O0dUvtKWKUw0xA7pCfIKtfviUADZgNou7a7uUbgS1JicZ0g1UOtNBmv0Y3yh/Zjy2KPI3
	 WPUJmNk/xpelM8uAgC8p1pzE+wbwcOHpk3bmGSL115wuanBxUQYPMq7alG4iavPqyvydW
	 35Uwf+x6GaRIavsdU7hI0cZFIduxsTMb/VCAR3+DhA0R24wQYeN/+gg2Awgr52IOWtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794935798;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=ROucTsPnyYTVcMujmRdSC63nWVbZidpBxQo25fxVF2Q=;
	b=ktN3ZFShQj32BL6IFlggba8vAaNllxWgw46XKnaaG4dr8aUQv1vbw0dDZq/yVyYsXCw4
	 aoFXLhtaExZjTyOn4cFW2vxiRUrgk4Zd5Nj0n55dxaeq6Ujf5hNUNJ6PDUlIiYbkXfGeM
	 0VXDe/DDL4+AHUC6scQ1OAYdHgTGtTFGVFQbT/UEbxS66N5aw7kSQ0wm+jlc9YluN8ey0
	 QUQp/YtgeXEOqiP7giNl4i35ig4Dmxa0rZO0sihb0deD+mJX5EJ869HAsH3XaZUB2gWgk
	 y8WFTMkQt2nKoZ1uoXOs4GGVsHKtDVcSYeCnVE31OfHwDODpwjD1+a8dAzSMtBK8VmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vBj2l2Xq;
	arc=none smtp.remote-ip=74.125.227.201
Received: from mail-pi2-f9.google.com (mail-pi2-f9.google.com [74.125.227.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B32606A32F
	for <damon@lists.linux.dev>; Tue, 17 Nov 2026 17:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79B32606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vBj2l2Xq
Received: by mail-pi2-f9.google.com with SMTP id 41be03b00d2f7-cdd9d0d40a4so29051a12.0
        for <damon@lists.linux.dev>; Tue, 17 Nov 2026 09:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794935798; x=1795540598; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ROucTsPnyYTVcMujmRdSC63nWVbZidpBxQo25fxVF2Q=;
        b=vBj2l2XqAYfO7wxBHkXYr1CnxoQa0r0tVGyEp3kU8oFex7s1CXXyRIatXfgxXI6O/D
         Q+qSLJR8/1x12VBbMTAFizNXlSOWZZdYhsELdPykvMTCRuOaFcqJti3Q+6bizlpw4nK7
         sUdZ/WSydNgr7yxNlf+g32/988MozIhX7iZkBClotj0uNR/G5gDr17PUUliK6Lmym/Y8
         DjZ3PNW7benJEzrsw86jrpf9PUp4DAeECi4RWZLPtFG9fzb5v9FirNSoLcN/rOrvUq9v
         I/OqzQynFZvKDm6d+HvfEBNyZqEtzCuPVoz67HqeQ4D00qHu56zA1GuvG0OCzJHfm9/b
         oozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794935798; x=1795540598;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ROucTsPnyYTVcMujmRdSC63nWVbZidpBxQo25fxVF2Q=;
        b=k9HC8zvaPkeklyMoPAJNangDMGnSs6V5IofYx5uVMvKI5oBM+cbhDbmzufs5tzCZgx
         FVKc+IbgEgTory790qHXjdGbhAbLBPWarTUmi8JIeMDx6ELUdHD2Agng+EEhwEt01fSF
         cP1Y9QHfDZfL2uskHrUMHxncSQnK4P2fVTQifOhGgUXDARErHi9heMYwoG1mLt+gHnCD
         Lk4gH/6aX6sejg7iRXq1av6Cjd2me7SF+P9/f3CXCa8b8tLyXEYT4Ca+tqYbucUyhidP
         rIym+ocls0FfChVSdcfW6Co+A1CtftmnOKZF6EHDiJ3RKHA7z/Dx5aUev9/lCI6wrYqt
         tq9Q==
X-Gm-Message-State: APuU4Z/t62LWLPNjpTriPbpN8wKpCinkZ7DLZKvUIldF775bPSBLemZn
	vpgn0lECv0JIoWzcDmYpcVV81e5p/J2vysWzdiA+6AfSnr65ByQYWdg8
X-Gm-Gg: AYBFou03YvK2DHg99cjrDsMXngC2V7sNDkGnUtkkQnaCFjlJdE7XszB8Dx1jrwFi2dA
	meF7gKo2i1gUuRw1GoRsZDQu2DRiN1eRnDMWOLRK1ghxvZk9vTIKHxpAG0P58tPI3hUS4kKUhGO
	ix3GO1+z88r6gs7gTPj5weWxuBpOJPp5+HFwZw9+QLGdIkCqnsl5Bbpt4myo1vBbGokq34MSoi5
	+whDnxVjOgVbkHo8iPiXNuOEYFS6y5FXVfytLDnZCdGo5qUJ9mV43iEGJ5r6q+HZItOoElT/HHp
	xwdV0WiNyT9QxjlmkMPNdjE+XBTW0z6UC+NgY9LqarspGqs0ZYmbGyReUwtkGHr9pA9BpYlf3ca
	igP536GwXVhXcdX94xm01iyGUv5wtAmfmVsqjlKGybcvuFFYula+E0IL8vB793tTgMln67eiC7K
	yxK4Zmt219Nfe5nXNvtPMBBawqo0E3NWp2vkKC9JqNF8IeBPMHeGs24bf4vyopmWJCZIlDdKvDy
	SITDNsN0fsL3HXMtq4/QyKIKq4e+Bjfm5ap2TL+QUhml7J9LDXr5kn5a2bebIP5+Y6FwJ7rF2v7
	s95De8+auptMVLWd0w2LCv0ahy/haZPt/JBJ7gfIDZECHm9Z214iAspjIB3cgvT2t2GdwhPywAY
	XMBCXd4Pf/MIIdy2YADRm81+qQ1MolWj2JlUfcvN44WebHZM3VxSBXBhqYWAjlqmG++FtagpkKT
	vGEAi2+90=
X-Received: by 2002:a05:6a00:3008:b0:855:eb7b:5804 with SMTP id d2e1a72fcca58-8beb374dd2cmr12162924b3a.4.1794935797654;
        Tue, 17 Nov 2026 09:16:37 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5b38f2c39sm99770b3a.34.2026.11.17.09.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 09:16:36 -0800 (PST)
From: Aveline Noir <jm5905938@gmail.com>
Date: Wed, 18 Nov 2026 04:04:33 +1100
Subject: [PATCH] mm/damon/paddr: avoid truncation warning in high-address
 KUnit test
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
Message-Id: <20261118-fix-damon-paddr-sparse-20261118-v1-1-3a0e943406d5@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NOw7CMAyGr1J5xiLJ0AaughicxNAgkVZ2QUhV7
 04CAxvj9z9XUJbMCsduBeFn1jyVCnbXQRypXBlzqgzOuN5a6/GSX5joPhWcKSVBnUmU8ecH4w/
 GDb1PA9SVWbhWPg+n85f1EW4clzbbEoFqPwiVODap4f7PA2zbG7eW2xe2AAAA
X-Change-ID: 20261118-fix-damon-paddr-sparse-20261118-fb08902768d7
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, David Hildenbrand <david@kernel.org>, 
 Justin Stitt <justinstitt@google.com>, lienze@kylinos.cn, 
 linux-kernel@vger.kernel.org, 
 Linux Memory Management List <linux-mm@kvack.org>, 
 kernel test robot <lkp@intel.com>, llvm@lists.linux.dev, 
 mm-commits@vger.kernel.org, Bill Wendling <morbo@google.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, oe-kbuild-all@lists.linux.dev, 
 rdunlap@infradead.org, sashiko-bot@kernel.org, 
 sashiko-reviews@lists.linux.dev
X-Mailer: b4 0.16.0

Hi SJ, Andrew,

The kernel test robot caught this issue in my earlier addr_unit KUnit
patch. Feel free to fold this fix into that patch.

Thanks,
Aveline Noir

-- >8 --
When phys_addr_t is 32-bit, Sparse warns about truncating the u64 address
passed to damon_pa_core_addr() in damon_test_pa_addr_over_4g().  The
runtime kunit_skip() does not prevent Sparse from checking that
conversion.

Compile the high-address assertions only with CONFIG_PHYS_ADDR_T_64BIT,
and keep the test skipped otherwise.

Fixes: 7a983cc1b573 ("mm/damon/paddr: add KUnit tests for addr_unit conversion")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/20261117170155.fEdeuuhm-lkp@intel.com/
Signed-off-by: Aveline Noir <jm5905938@gmail.com>
---
The reported warning is gone with the original i386 config, Clang 22.1.8
and Sparse v0.6.5-rc1-21-g84ec0658. All executed DAMON KUnit tests passed
on x86_64 and i386 with and without PAE; the high-address case skips
without PAE.
---
 mm/damon/tests/paddr-kunit.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/damon/tests/paddr-kunit.h b/mm/damon/tests/paddr-kunit.h
index 9839cc233071..2b11f0e67a12 100644
--- a/mm/damon/tests/paddr-kunit.h
+++ b/mm/damon/tests/paddr-kunit.h
@@ -26,15 +26,16 @@ static void damon_test_pa_core_addr(struct kunit *test)
 
 static void damon_test_pa_addr_over_4g(struct kunit *test)
 {
+#ifdef CONFIG_PHYS_ADDR_T_64BIT
 	unsigned long addr = 0xffffffffUL;
 	unsigned long addr_unit = 0x1000;
 	u64 pa = 0xffffffff000ULL;
 
-	if (!IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
-		kunit_skip(test, "phys_addr_t is 32-bit");
-
 	KUNIT_EXPECT_EQ(test, damon_pa_phys_addr(addr, addr_unit), pa);
 	KUNIT_EXPECT_EQ(test, damon_pa_core_addr(pa, addr_unit), addr);
+#else
+	kunit_skip(test, "phys_addr_t is 32-bit");
+#endif
 }
 
 static struct kunit_case damon_paddr_test_cases[] = {

---
base-commit: 7a983cc1b57309a875a9e07a934c9944bf3d088d
change-id: 20261118-fix-damon-paddr-sparse-20261118-fb08902768d7

