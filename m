Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7429842F6F1
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 19:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576107; cv=none; b=XMudtySF3Mq4tkcwWw2YWXWeeXa0TBj3gN57Bv6UqMEX4jW1OQVsY/eHRL/9+/aXiFUs9Yz1tmkfeRUJ5ZDvgBMKTgUYJdHAv+Wr5NqZyqBqbttl2wXAztxdFrPV2cUSKirnZRehOVHdlZzkNhyIHYXbYJ5yK1j6Ns27fssbF9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576107; c=relaxed/simple;
	bh=IH9XmY5lZ74Lh/qC51Vmj6nJ/SlEkb5m+xVKm1fBETo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPNeZGzHWPNU3nylpNriLpuIKRnYfbi65rwN3KrinTGHcT5erJWSldF8tj36SRTfkRkWTCzlZ923Gnsi4tqgkpMQU62NoYY66SikNCUGMkQ1lTeZdU5zsTUEybGu4xOcFgayEBjGMabXe5lRFcCR5V5XcA6xoZ34QhcQZfo2gwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=EB3VPVpV; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="EB3VPVpV"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e5c9211d2so926767985a.1
        for <damon@lists.linux.dev>; Mon, 20 Jul 2026 12:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784576102; x=1785180902; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pZmCSk3Ktta7GM7YUNaW3uB9vhWdsptSIGrgvbOB7hc=;
        b=EB3VPVpVsyldxvIvI/GoxdDFIRN9RqH3xpt8kTaBGPg6unjbudExvO59VQiZZnzVxd
         MTw6jMK18THmDTgS/aV0Rb3WdomID3ggUdFtuCytgHjb9Mb09U4AmAm6w/MsWJgqYU+A
         RYoQKExzDCpMFU0MrmhqhdT7lmndO49o/cK+/OHrDejXifin4GMdWnr2YVfhLiwa0LBs
         lg18QuNPY6F8Ekxn576QGRiJZH9I/M0wp6/Kxwlap7yTta7rTDaHHxpKe+U5Grps8LGx
         R7pdC8pMfZHtuLa+sAS65tc2NJg7rXSOr79/AZ+PQCaQRio0yDT2xPkP0PnA24pAVj6t
         uFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576102; x=1785180902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pZmCSk3Ktta7GM7YUNaW3uB9vhWdsptSIGrgvbOB7hc=;
        b=R6MYhNQ9nEGYi/V+AEoRhrs9nbNmi6UWR7kr/V/hyiEQYDxQx1OFa93faYr8iJ9yC3
         4n5sAXy0ZtuSpxzEhARuAB0nCch/p7o2t3NctrY5ulAUjw2RM5qfxpulbSGWG0Tu+dwL
         cso4b2BHGidzjSkDk55y4BAfBONqCIY+5d347U6k4fpPDhD8RJ0Ht4NnGP7uB2qGpnvF
         PAPR33uZO4WR8dZ7R2t7smsu8eVgE0zc9nBSplVJ8ea1H4vb4FvC/Mevy4qwp2IOswJP
         CnbfvGQe8ujIaTxF1+qCDJTFo2VbalPJ+5odzHcxCmWfutz5FfZiZEdFEichSggqLnad
         TQYg==
X-Forwarded-Encrypted: i=1; AHgh+RrgH4hKhvsDHVg/I/z0aLUQ48flwM6/YJHhWGAmnRR1Qgr2M2Pd11nRaQVR/81feb9foEi7/w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQtqA6z3+SLMdYZZausPqysHDvoZ6jAkpdp8HZV4LnRDqTYTOk
	WeVQOwU+ftwL8fsZjgdxJas/BUSzBeNEevH/YLFn2U16TYAVVArnTAvgIKrpAwDZezE=
X-Gm-Gg: AfdE7cnGAXpRjhjaP3/qPObFlY7HJs2AqcDaVAcVaFAa6+uS1Tgq4WHFc6Mw1c06TXc
	XKNXxii4vprZmKTIrb9eShk88btDosIP5Yy0MV85hiEXLz94fEOT2WR+QRyR6LXzOogDp7ZGBFd
	VF9wEnmd3bHVjnP5v6idSmnFElDZQ0rG8SvV70vqeV58++r2hM/EkcIuZP5f6AAoTp/eq3rJ4Dv
	A3UxqJ8dl0allNbhFtbVU1tN0Zu8KSe1hDzYaFU6qDusYrzkIu4hAF/5orzQCP391S6cS5Rk0IP
	oJ9RJKoxHaXGSO7nbx6uCf9A9Sh+YH3VprXMkUjIzORJMVVd7iyDEn9fG5SADrcURrdpB2N95H3
	dreRPQRX9J3m3pdPoXr78AH3SH+4AeyHJLzxyIA+uTC2e+n7aCfLlAJzMJMX29mgIOP763zSV7r
	leC0lS4HPeJF1AZOT1n7Lzhi6ZS4sZ68qTC1j3eMQEX9hIZY+Ae7IhOaPRcYCV5y+MQDcZnpIIy
	x95AWxst/Pk
X-Received: by 2002:a05:620a:a481:b0:92e:cac7:9706 with SMTP id af79cd13be357-930b431c958mr1298084185a.52.1784576101920;
        Mon, 20 Jul 2026 12:35:01 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm957792285a.35.2026.07.20.12.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:35:01 -0700 (PDT)
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
Subject: [PATCH v5 09/36] mm/migrate: disallow userland driven migration for private nodes
Date: Mon, 20 Jul 2026 15:34:03 -0400
Message-ID: <20260720193431.3841992-10-gourry@gourry.net>
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

Use the same filter locations as zone_device folios to disallow
userland driven migration requests for private node memory.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/migrate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index a8a86141dbb54..d20674c07b947 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2268,7 +2268,7 @@ static int __add_folio_for_migration(struct folio *folio, int node,
 	if (is_zero_folio(folio) || is_huge_zero_folio(folio))
 		return -EFAULT;
 
-	if (folio_is_zone_device(folio))
+	if (folio_is_private_managed(folio))
 		return -ENOENT;
 
 	if (folio_nid(folio) == node)
@@ -2477,7 +2477,7 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
 		if (folio) {
 			if (is_zero_folio(folio) || is_huge_zero_folio(folio))
 				err = -EFAULT;
-			else if (folio_is_zone_device(folio))
+			else if (folio_is_private_managed(folio))
 				err = -ENOENT;
 			else
 				err = folio_nid(folio);
-- 
2.53.0-Meta

