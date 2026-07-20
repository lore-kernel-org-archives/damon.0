Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B3847DF8F
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 19:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576118; cv=none; b=QRnBU7OOogiwA64bhs6K28uFmmXpFyToXDvzt9QsF4mvHAu/36BfkQG/SZVsetT+wqHN+KtWHeeZfBftSnuVuaElmg/mZwpWQ4l9S/BB8W06jyQMyJQh94tKSqGqH2vUvuVkaFaSTTeih8Cq9aze+oWcZTwzkoq+F/gURnnn0r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576118; c=relaxed/simple;
	bh=rQ3ZLRwttPY5U7qx79TyOlCHcsHd1SWTIks/cm1EO0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLpbaZEY9CTlsIevuSCIlt5lQNzJZSCMUZju3JvQkpSBiPlF/DX8R1KYl53vfwR271KPihycXy7uS/EyKx2I3nNuYkUewmyq+yD2tJTkYTgUY4BiUMYQzI6mlmIeYYQL8+srRP3AqfDPGoVNArqEgkg6jNXQA9eyTx2RziG+9Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=mhirHceG; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="mhirHceG"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e99ef0902so741349985a.2
        for <damon@lists.linux.dev>; Mon, 20 Jul 2026 12:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784576113; x=1785180913; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dXwJlI/llosQi30lLS1O2+gV7rtKvgDC66cTY4z3y4o=;
        b=mhirHceGDm8cngo62rI0fvr5camhq+mfCWDi3kYtN8gwv0GmXuXMwQQHHDo64wWecm
         JZPXySomncMpJ/sbKB0lRITX0kX5m4JrzYwBdHlfkSJT3ujS86/6+eiyebla6DSLz9gt
         tE/IxR1eypHiGjVrEgJh3ob4hEHzvSL9B6V3KtsjH1kpmQhtaJnYFXzkL8TAbnHvhfvP
         1YDJB9am6qAhDBwzDC2H8dlChxZg3DTuFonICjoq/sKxq+Tfgq/6Ajo4xdjOA3MywQDN
         fv+DSV64QInshIrzYK6RqbD06TC45BH+6R0LaL2lSOPPysfLl3wa7a+NyxIl2XAmeaDi
         /ujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576113; x=1785180913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dXwJlI/llosQi30lLS1O2+gV7rtKvgDC66cTY4z3y4o=;
        b=Q5vqLRij33N3EXivYzKhoVPxOSn4SzEAjEBQoAiEjnm0h7ngHZ+PdXfJJxSK+xPBQc
         NcSr7KixEaRjA6dh9qv3F6Yg9oxAGQCTnyk3l15WjbMQi61HcsInT7LdJ3qmNt3HzG1Q
         K7pU56aJkAJcTX2oYVKCvEmgihJPa+zZWGTlO8g4duUYkPMF5IrxWWvbCNYQyQskT/ua
         6x8LXOgfYJ1eZI6NS693ul1pe0xUZOCZlmMuuhbFbuft+qp6Ultm7tOMuYIyfhBNU7pb
         VPfpVSSod+jByJjqktB8zrlCRjrilMzlssTnfR4hY11AOrNnhlOy722qNLNeEc0Ycc9v
         9CFA==
X-Forwarded-Encrypted: i=1; AHgh+Rr981R7Acu74JBNRN65GJaWKEuL1PdpcVECcqyqX5HnoKg73n8ZG8Ov/Mj7bhq/BVfdcb/Vlw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlH3gAEFJuAVu4v4H+v93Ojr5AjQwE5xXpcUC90H2xgUqrvSA8
	eRXs/hg11arqlQ/I7Zfuw/z3bXWIlqvZkrSQr7vZFQHGnVHZN1ExVzgs8g7VIK1rjrQ=
X-Gm-Gg: AfdE7clOv55oDnDjWwR4vamqCd7I2n/Qrb+W5BjiyRK14Sp3lIc6fLf+e2yXqnfrMEx
	k7oZmk3+SR/ReIYnAm/w0phj/xaYiQLC9aAg4xjYkFDstJgRbRlkZ0YjykHQ6mUQEENpiQmlPXD
	dN6eyesz0AlbNjoUCwFE4wo8zY+QzDVGOHLiljd5IfGYHwQ8qgB8UVK8HE4HjMPEGFOxff1yZCi
	Ahh2Oa7XKIECNBXm8N9MCdkkJlwSL512r0ZfxKbyW9EnM1j+707Ry7L0hI4U5krMQ45C+QFE4BO
	ra9Xg3exF0+O9wR67Zy8rDDADO9DAvj5Ao679QQunJCIELQIjD3a3Hv0YG3/uHYOYvBcJv+Ku6h
	MRT713ELkbfzjcfVV6fdW/AhX1RO6NAf4Bs3P4lXtBP3u+0NK4DyumjnqivUFwxYleSndk3x5/3
	bi/ffg7O38YbfaCpUwN/S36Don33fxZXnyWhPIXCYbjoWkgUIr2gHZ1yeNN6IIDVo=
X-Received: by 2002:a05:620a:45a4:b0:930:af44:c3f6 with SMTP id af79cd13be357-930b416db87mr1543521885a.43.1784576112837;
        Mon, 20 Jul 2026 12:35:12 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm957792285a.35.2026.07.20.12.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:35:12 -0700 (PDT)
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
Subject: [PATCH v5 13/36] mm/mempolicy: disallow NUMA Balancing prot_none on private nodes
Date: Mon, 20 Jul 2026 15:34:07 -0400
Message-ID: <20260720193431.3841992-14-gourry@gourry.net>
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

Skip private node memory the same way zone device memory is
skipped, since private nodes do not presently support migration.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 8e8763f6e5f5b..2b76c57a460c9 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -845,7 +845,7 @@ bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
 {
 	int nid;
 
-	if (!folio || folio_is_zone_device(folio) || folio_test_ksm(folio))
+	if (!folio || folio_is_private_managed(folio) || folio_test_ksm(folio))
 		return false;
 
 	/* Also skip shared copy-on-write folios */
-- 
2.53.0-Meta

