Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C4247276B
	for <damon@lists.linux.dev>; Tue, 28 Jul 2026 19:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268046; cv=none; b=DKXIaSYHXCD5bjJs6gLoGyO4l1kMsj4RXfGnxTeFdstGUpWYbHxrLbQSSV3EUKT3WxolUHTi29BEAWD4EB20i22T8XIh1jsD4yy3KqT3TbpiOC/Nba05cUcGztM3tYDkfGzftNBlrG4/vY3qb0Tw0qT2JhJH9o1nf+LiTh7+Gis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268046; c=relaxed/simple;
	bh=53Ch3mlN8Z1SIL7GE9UYSm9RybDWpSkaOiwvLUXPRDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiTnGwnKNe3Ko71Lj24CYtdkUhAs4AMQbYsYmkLDV/o86sxCK7wrcE6pmWRRHcWJHi6R2tbLQHjwgLO/cI86FOf2HvQbCC9HORexiyqoU1DtlEmd4IsQoHaUfIdxqGpAkCTy2Nr+mhzbsem3fxsBnoOSmtPjiOFsxUc1emmV1Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=K5wZtCVX; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="K5wZtCVX"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8edda5d56a5so1735346d6.3
        for <damon@lists.linux.dev>; Tue, 28 Jul 2026 12:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785268043; x=1785872843; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VJ+l350a6OlsWiNiaSEE/Z8jsj56ru6jIVfVE/WM2fo=;
        b=K5wZtCVXsNLgGdCe3EEr8EcaVOoQioCbufG3q/95EIh2Ih8+cON3Jb/aNFSmEfQ8sS
         cGKQT72pm7KWil3oosHIKorGdGiSGSkJT+aGJ3o8TCfFhoND8trnKlPIbkOwPxTozH2K
         mrE6PRZrUj2zASR+Q3hhhSapiOfDtk1Nv0fj9E2VZ/oRV1E5VPkOD993F3FaC3rstpmh
         A8j2xM7N7/8c4fm6/OREsLITrqMQeSDIA4VOHq7Ei48vaBBmOs/LEEpJC2Q+SBuUMDq1
         dbBIRBDSep8MfQW9DloMJMDXCBUB/98OiJgabQSiVlDkpmEw2acN4SzKc32Ww7k3G51C
         v+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785268043; x=1785872843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VJ+l350a6OlsWiNiaSEE/Z8jsj56ru6jIVfVE/WM2fo=;
        b=Q5WW/7THiMwo5lMGf3YwJ6NtNxeF3/JE2SrnA0Ef1Jw6/bdbBlshKejF9GqJnKgfsj
         HjQuAVGsJzAJJj6RZ/ln8RK1hELvCw7OOL7CCQFwwF/5dED7wouH0nA6FBIWWjwMTXuX
         HksLUDa68JwSCO31F2OkSLPOqfbeSDbpNQFG7wSbsfxV3/BDEwipktiKq7KVzI2LF55C
         QaP7nkcfIdXiavSAX1fYkXNdf0QyN1zFn01ECbIJyCvssepTVPahPoIn3Rh5TJGo7nTW
         mtVDt2CKFQbzBMeSKpvI4lcp8t1nglLzHrB1q9QC7hqKuNOMw5onji3CmZ+hnsSvCZ+4
         MpfA==
X-Gm-Message-State: AOJu0Yya1TrM6YrnXERJnWWuTZM4uSp+NQbDtiyHEdt2cbc3IIakJAeW
	6Bvbq+xwqriUg7xThJmmz6ciQMT3HpqN/wRjxzjKAhLWPcgm5kdTkt6ZTGdmRaXy3UI=
X-Gm-Gg: AR+sD12MwHpO0T/SSQI7HMqhxgDwCI5ajldyOGWtbHwNIE3eiExRebXGcsWILSwyX0M
	qRQCO0lJPzUn9TNxGMGDnWT3Z5bndTdgVLqKs+tOyo0UpCpw5mCt5Ghc+Unkw344v+gdsO79+XZ
	bMo2zZGxdvrsHvb9LUbCLbYgej4oatFCiCXWJfdnkP9g63FLfFdyTdeOLbsGGQEns31chmYf+kX
	fCGMLNDlTo8aW+lJ1mtfSiA83p90ZtT6WmOI6MLdTmwp0JZ+Z2xJnbid0ZYvESj3vA4yK/KLTRR
	9n7HsMv0pnwT3LWaBWydGOAykdOgiw7DiWFnrwaaz+hCSH9+O7xTUBV5fgkInuTjmeNm54EpWG5
	FRiUWR2F7yDA3QEefitmnkAgwAR41qbZau4WtUzUwqIPGqlHsT7r84XykzzAgDJ7yGiziH858D8
	jfzWR9no6dlM5iXIkldEMJ18xSzzTTZnu6vBgKVocsd1rwaE9E02gBSWV7DBOv/ZqzbcG15cNPv
	qDpqRCEQvesnmhkoL8ZVIqwJewTs+nckJmaCbdsuizh4GGEY2Sc3SDUoswCnQ==
X-Received: by 2002:a05:6214:21ee:b0:8f4:821d:95f7 with SMTP id 6a1803df08f44-908170026e8mr41209526d6.18.1785268042709;
        Tue, 28 Jul 2026 12:47:22 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dd6b539sm6700176d6.41.2026.07.28.12.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:47:22 -0700 (PDT)
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
	apopple@nvidia.com
Subject: [PATCH 1/4] mm/damon: defensively skip zone device folios in damon_get_folio()
Date: Tue, 28 Jul 2026 15:47:11 -0400
Message-ID: <20260728194714.3713735-2-gourry@gourry.net>
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

All DAMON physical- and virtual-address operations obtain their folios
through damon_get_folio(). That helper already excludes ZONE_DEVICE
memory implicitly via pfn_to_online_page() and folio_test_lru(), but
this is inconsistent with other callers in mm/ which test explicitly.

Add an explicit folio_is_zone_device() rejection in damon_get_folio()
so the guarantee lives in one place and covers every caller uniformly,
consistent with other mm walkers that reject zone device folios.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/damon/ops-common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index d7d7f100389b..d8bca7355b4f 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -32,7 +32,8 @@ struct folio *damon_get_folio(unsigned long pfn)
 	folio = page_folio(page);
 	if (!folio_try_get(folio))
 		return NULL;
-	if (unlikely(page_folio(page) != folio) || !folio_test_lru(folio)) {
+	if (unlikely(page_folio(page) != folio) || !folio_test_lru(folio) ||
+	    folio_is_zone_device(folio)) {
 		folio_put(folio);
 		folio = NULL;
 	}
-- 
2.55.0

