Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A49470EB2
	for <damon@lists.linux.dev>; Tue, 28 Jul 2026 19:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268047; cv=none; b=kEJRnzRTlwiibGwjpgZham2KXSjyKmbObFO/sLXENUmcdYQs2fOHBwpant/t7yu0Bo14wwj99KllRGqUMI4PH/I9bKUWRzoHYqrymqdTEVRuqJBgkDT+QJpES91/YKlW/SAKutN1np3An3nIuAx8zp5NdwFRNLEq+26niX6xr4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268047; c=relaxed/simple;
	bh=QMZ7J7lKfDME8A5FG6nzVSk2RlwEU5lJAgsrB/UXl7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oknqFRd5VHICfSy8g1cdI02bTvp57wlc8HIOftXY8+1ZvJ5YpfyDm6MA0Mt1iL7DiS8T9YWbF2mxQbRlfF0NOLOx7kDc51urX1jCtNCSwY+Y3Rkla4zO2Vids9Gs0+zNgjJccPAUTsEe974K730tKtgOKf5Rf7OYGw2d01IAv1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CMvdw3+2; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CMvdw3+2"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-517dc520840so1690981cf.3
        for <damon@lists.linux.dev>; Tue, 28 Jul 2026 12:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785268044; x=1785872844; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pqmZmonnGKuyrTzlO9IdYf4JadmrLNGgv2eh0Lztbm8=;
        b=CMvdw3+2BHtjlEM5SfxfRdZ6Vo5p5kppP9Ov6CZgB3MqcDOf8cxgQBIguAoSAY75S+
         zO9DtkgJQUPr9hjTJnyxfP/gazZh1+TL8KdlviuCP7BvfGLcf5Ydf3AaDoplRF5CY7RW
         eW19AtpADSuuv66pyVb+UW4rW6Czar+IniDr+hzdjsONX6MKLzECtv4mlK3Xoyx6sTm1
         cu8KbLNsfYXe0IAvXi8XrkF/XIK7Exq8f9S/2OHXroXaLd4Hg/w+wNpzeWcajzvQlNxn
         5/NBCQU/rScm3qUA4Dkz/6zM31zwtySL0g+7+RGwbhWzm07cDrf3VUpd0Zb8xkiwpOV/
         hY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785268044; x=1785872844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pqmZmonnGKuyrTzlO9IdYf4JadmrLNGgv2eh0Lztbm8=;
        b=Nq0gpW37ieEKscFMPoqG0ZtG70PIIyUzYgdn5M/aT1RAZXxGdFxJOn+yT3xXnE+sXS
         ILuFdH1UkktLTGLFJFHM1epCvP88y5Vy37qyXhy+8vt2ZWnrEBnUqPZdc5C4gVjEzR98
         WRXOYU89NL4Hu/NzuRmgo4j2XZ/jSxQxT26onEwpccgyk04lCByxHuFHJmAHoPEhoPGK
         8BWApkALRnB50PvahtUObJtjxFBpsSm7+eqj0T6awILXMecmZmbh1C0II05PdhdFOAXg
         ROz/t/3c1lCpw7V6Okq7820D+4yiHrw9idrIKCFLaE3/xEr3GDqMY39o0llWrwQw9tBc
         /4Pw==
X-Gm-Message-State: AOJu0Yw+koS8hWxqPH+2CrlfhdcjNiZ+JakCJV/qudknU/T5AXwVkwrb
	kSLh6FAUUfcohw0ToqlilG8qWVeCG1xsYm7A1gz1K1WdPpd6aPGzy5B2Q5xFMkgwBLk=
X-Gm-Gg: AR+sD12r0CV0zQUaL2CP/AWh+4AOsAMpdo9qRNzKXhEN3ec/kntFAM16lNSlsMwn3qL
	8bb48PwbCuXJIT+58OrnATVpE9a2L1YLsW+ZB6A7479oL5DgmnLOWXVKK6ZwqT5fAMitWB8q90Q
	BzPmYOqvf9VJJGZndyML4pfbc9XjEgra7oicrbur61zGphCd0Ukq3lDVjK2i5LcrxkhHhqv0d+w
	xzHwzy1h7tgnhNQrhrzedZdpKozRuMCLhz1zxwVzIOO4lVc9unVvKhJGY3W9CAC3hb2lGd6U2Na
	s9lrflW6JhUuM7wAbpuyNaHJ6/LmkwExLImzOz/8dgPu1biGSn/kf2yYj4ZmfaEeBMoIHF8/MVS
	Hxm0DNdVAYt6uxf5j3nEGbN06Szl0hF6s3vaBWx5X/TR/bgpndxx9g3cF28hG3nvrhbAxd7KoEt
	L9t1qF//OC0MUrUVbDij60/AqFR1MglJ0QwPWWYXlc0dLtxwHdd/sNDSxNYl9D3o5JgeEHgY+Ul
	g==
X-Received: by 2002:a05:622a:2c6:b0:528:3b83:3483 with SMTP id d75a77b69052e-529d70fc0aemr38942701cf.23.1785268044243;
        Tue, 28 Jul 2026 12:47:24 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dd6b539sm6700176d6.41.2026.07.28.12.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:47:23 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	sj@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	vbabka@kernel.org,
	jannh@google.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	stable@vger.kernel.org
Subject: [PATCH 2/4] mm/huge_memory: skip zone device folios in madvise_free_huge_pmd()
Date: Tue, 28 Jul 2026 15:47:12 -0400
Message-ID: <20260728194714.3713735-3-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728194714.3713735-1-gourry@gourry.net>
References: <20260728194714.3713735-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

madvise_free_huge_pmd() resolves the folio backing a PMD via pmd_folio()
and marks it lazyfree without checking for zone device memory.

The surrounding guards do not cover every zone device case:
 - MADV_FREE only operates on anonymous VMAs (DAX mappings are excluded)

 - !pmd_present() branch rejects device-private and migration entries

 - present zone device PMD (device coherent THP) is not filtered.
   Unlike vm_normal_page_pmd(), it performs no special/pfnmap check,
   and would be marked lazyfree here.

Bail out when the folio is a zone device folio.

Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to PMD operations")
Cc: <stable@vger.kernel.org>
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/huge_memory.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5bd8d4f59a7b..e0ffdeeb3077 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2338,6 +2338,10 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	}
 
 	folio = pmd_folio(orig_pmd);
+
+	if (folio_is_zone_device(folio))
+		goto out;
+
 	/*
 	 * If other processes are mapping this folio, we couldn't discard
 	 * the folio unless they all do MADV_FREE so let's skip the folio.
-- 
2.55.0

