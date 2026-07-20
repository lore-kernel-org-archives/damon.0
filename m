Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD6D47DF85
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576123; cv=none; b=cu4+/JzUuAq5/awPdvtWzGHmPF0DMcLpN7hwTG22E0zgBQuOPo/pDmdhrfFoejmjI3JDuFDekVMHZDqgWSgXd7ROqIhIjGw7cq6QKY3Wwm0cDNVrHCYDtzb9LKBwfwoVIz4UbdCXn9moxoHHJAKB7awk4AM1rFIm4NIp5kkcR38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576123; c=relaxed/simple;
	bh=wTYQxiwnnNn1fQlaf49KQEuG8RjOnNBI3U36p9hX2rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qddpJe/ppTHyEBI+LqFiPLl3JatvTS8hLCTV8t6tY9N1L3WJFE/Mo+J5//INbdEnpTZhTkYcjIQbZC/UEti/JBOAfin6UR0hyQow1VpVI30BFCinbKfZILTWsfAIEtpQbzZuspgM4kkTE0bf6UrMPvchZE1M/CByA2L7lw6fJXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=AgriYbaH; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="AgriYbaH"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92edb12cdf2so447570385a.3
        for <damon@lists.linux.dev>; Mon, 20 Jul 2026 12:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784576118; x=1785180918; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HgkUnnQve0Rn/Pvs0Z/0q3yFfFJ0c7Ckz6K5pdtr6eU=;
        b=AgriYbaHBnCKuKppil46GYl+AEDW15Y3oDny/PSbzPTETLcNv9XA3/FOl8geHSe3lG
         PeYJ/zO1ukox5PlUydcwRbCPCSPoxUIKKo6hoGwqpmsLw8MBY/BAic7BVPBPtui0MT5S
         EVprFCMiCTHNTxy3xHudUmTyKr88qAsmT/gGhD0+lo0Jb5WMGKJGZoYtLjU2vfjETdc9
         U86fJmkGZGOSgSYNLlN+sjAYvNyJoMczDPwOfboKh0nkoO2ZvGJVqssilM0Ht9bO+4WE
         z+A/kmDet35M4HhS76XNp/4LfvI4LBUti2fbN9DOGnWgfPPPZZJy96hG85uG3oSOzNrl
         cdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576118; x=1785180918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HgkUnnQve0Rn/Pvs0Z/0q3yFfFJ0c7Ckz6K5pdtr6eU=;
        b=Bn6vVsP46RMBy6zapW5hDrrty2aQ/dxVKFxWDucAFAUqfAH2C+rLEBBSWczlD8kgq0
         F8rJ0jXDYabZQz5B1Vvd80C4JLKc7kurQQkdRcK3jVcvNwaBoh6jk0ZAh2pgyFou99fW
         jI9VSerMhufocIOvit06Kbz8LYrgsEt44VnINOg9dwsDwr2oaZuJZFM3cp2+wfuMxMlZ
         J+EYXe2oD/6a2tIiQQYnHDkAw+CZJcoMVRmnUgLvlazIH77RR5bEsaCvqF/4KiXcGhbp
         nDxuvgWkPFWw38WJHkFh8mGNcHoK8pa2jP9kpNW3N72CDzBGc+wq9b/JKrpEwFyqWksg
         TbKg==
X-Forwarded-Encrypted: i=1; AHgh+RoSg1kMXGgNG4nvfFuYn9KlMGMoVQtH5D0+iO4ZJh9bsbrsHs2IkBg8grCDEvBFbvD2HRE5zQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJU+wguN6U7LoTfXikW5s5T7QgU2ZRtSqEN5om/+Cy4majFa5/
	iGci7EyiTGKHN0z+3mBMmdEbUU/kPAJaOG4ed1m0Lyue++qdTgnCNJzRasN6M41qGGw=
X-Gm-Gg: AfdE7cnQgNN4KM92wN8EEJRk5HZFra2n93QVZH1Z88qJaPk6av4thdO2Bc9N7UhENlf
	nT3D81kZywef/leptAP6DgKLTPKoiN0mra0L2Y7RN+sHS4r5lAr7/Y5EdbCTJnANGUu3VNXl14q
	dwwkvMJ9oO7KlKvDYj5ZAna7iVoekTE1qgXyJFf1wgK7Bi8BncjMAI04KCNRk/2WjaZRQYQ9ZPf
	GMKvtpxvHgV/wwO6tRqIynR2vGoLKllWgQCKj2HfDbEQ2ebDCg1vJ1pZnpDL6I8/91pvAPUi8Qd
	0SMvILEavbaFQmtLnP4H5zsXbhVUnoutyKpXAkcMz2WkmYWBzHKVNTYmXnUha6bMmqeVHiRCc9C
	+Ivwz6saXrZN79b5878eGZfXsEkDTByKq577ohK2xJAHTl+2v9EhRC+KCFGwgnvs/Pb0uhmgqYB
	jB5SdK9RFWSK64UYeBAPnSfmFhPdl0cN6EVvTs86toh7+48rUSp+04wgamuN9/7VM=
X-Received: by 2002:a05:620a:4007:b0:92e:c116:bef9 with SMTP id af79cd13be357-930b4315599mr1572701485a.86.1784576117793;
        Mon, 20 Jul 2026 12:35:17 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm957792285a.35.2026.07.20.12.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:35:17 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: Zhigang.Luo@amd.com,
	arun.george@samsung.com,
	balbirs@nvidia.com,
	brendan.jackman@linux.dev,
	yuzenghui@huawei.com,
	apopple@nvidia.com,
	alucerop@amd.com,
	matthew.brost@intel.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	osandov@osandov.com,
	jannh@google.com,
	pfalcato@suse.de,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	pbonzini@redhat.com,
	osalvador@suse.de,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	longman@redhat.com,
	ridong.chen@linux.dev,
	tj@kernel.org,
	mkoutny@suse.com,
	sj@kernel.org,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-debuggers@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kvm@vger.kernel.org,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v5 15/36] mm/ksm: skip KSM for managed-memory folios
Date: Mon, 20 Jul 2026 15:34:09 -0400
Message-ID: <20260720193431.3841992-16-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720193431.3841992-1-gourry@gourry.net>
References: <20260720193431.3841992-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since private memory is intended for explicit placement, allowing
KSM to operate on it by default would completely defeat the purpose.

Skip KSM merge and scan operations for private node folios using
the same filter location as zone_device folios.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/ksm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 47006f494fcb1..dcc5c46a29eac 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -827,7 +827,7 @@ static struct page *get_mergeable_page(struct ksm_rmap_item *rmap_item)
 
 	folio = folio_walk_start(&fw, vma, addr, 0);
 	if (folio) {
-		if (!folio_is_zone_device(folio) &&
+		if (!folio_is_private_managed(folio) &&
 		    folio_test_anon(folio)) {
 			folio_get(folio);
 			page = fw.page;
@@ -2558,7 +2558,8 @@ static int ksm_next_page_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned lon
 				goto not_found_unlock;
 			folio = page_folio(page);
 
-			if (folio_is_zone_device(folio) || !folio_test_anon(folio))
+			if (unlikely(folio_is_private_managed(folio)) ||
+			    !folio_test_anon(folio))
 				goto not_found_unlock;
 
 			page += ((addr & (PMD_SIZE - 1)) >> PAGE_SHIFT);
@@ -2582,7 +2583,8 @@ static int ksm_next_page_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned lon
 			continue;
 		folio = page_folio(page);
 
-		if (folio_is_zone_device(folio) || !folio_test_anon(folio))
+		if (unlikely(folio_is_private_managed(folio)) ||
+		    !folio_test_anon(folio))
 			continue;
 		goto found_unlock;
 	}
-- 
2.53.0-Meta

