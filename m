Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CCF225A38
	for <damon@lists.linux.dev>; Sat,  2 Aug 2025 11:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754135586; cv=none; b=VL936Y4HQ77FlDJcxuTYC64SAPPX/35GAyROvJl3DOuto7h3UI3CLfVwT4icsRKTaPGljbVYxaVU+a32v9DVfpmXMREHBMDKgMVPth6cPjDJBFXJPeJA/DEyzOLJDF4EUNh6fb2PXmwLDXJO1NbrS+wQKNlMr0iU8lcZtAURCgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754135586; c=relaxed/simple;
	bh=kOvxzrWDC5K18/smBEMWYXLhT/zDo1nWowIrW1n8plA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SyDVeUIuo5UHmOAelCc8p/8SEGp3vfxAS7bAYOfYlhCr57MOCm9Ky1N8h0eDPcGNsP8SHwvE+zyDm8xsnA/fdsENelyoZ6CXyL6XQhhQPWahA//hhhGt8NNqHsTw/cGgQAIF+UYYiVCcuYcF87BinIMq9kqWLY0CD5WoTB0oWN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3rNVccC; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3rNVccC"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-af913d9d2a1so516303366b.3
        for <damon@lists.linux.dev>; Sat, 02 Aug 2025 04:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754135583; x=1754740383; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1uRbOaPx516qagC6F0FtjjMT3s1w0dSsaUvr5gAnQo=;
        b=h3rNVccCau9HU7gbyZjUoVgIi7auOVlYKH0dJ+LplN55xNmnUFP2DvpALKpvcufffD
         BSMnZG5aLE28MWRNBu7iTSW9dYgfgvG+/bUkmMnuPzo/4dIAhR/h2N1hZGgKjM79QuI5
         xQyXpToI5nGgvR8hqplG1iJ6do8BXFXZNcs7MGEn2+7L9ljQyd/glkp7+SRNx/wHD9uR
         UfMcYElZ+1I3dfayvvAepQZ2VCgZspnPKO/Y36ooqRMXyE/Dws6U11KSG/H4MblJMmTN
         YF77rbIuo6f77vMwT12yNBmyvbOHBoUbTKERK5ZTyDC1Nnv7d7vZ8yzgE4L3aXzbZqta
         8rVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754135583; x=1754740383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1uRbOaPx516qagC6F0FtjjMT3s1w0dSsaUvr5gAnQo=;
        b=hHUxmQ2M/ryh3j6Zo1ycwIKE7DEsqPG1HppTG/zE7VXZ7ZZiZ4g+9pnD2Z9Wky7/qf
         xNGqOuyi2eb65KiV0oHnanxij1rUUoXzMCjctVXwl224wBI6XMh/C2QFwQE2YfQnVedH
         WUA0DS7bshYIDBnDzt8FNOm7cNFelXsQRU6t8kBUDyjTAEtVZPLGq7TXNM7RQNGTTiCH
         saiNh3GlWFa4o7eJ7/NIWd+4hMZSiUN7V8OX3RwJcJu63AZkcKvvrsQCL6aMGmqod6fE
         xB5eCjQHpVq/x2ujm1F0GiUMjZ+6jXi0hVg/+z73bxwed6wt7yGdsDOpWSdkwtdi6bhK
         /l6A==
X-Gm-Message-State: AOJu0YyXBx0s3I+u7NjbNuupAHXRC/FpK4kD3Au+OGQMii5VMMfrdWUC
	fHfFVq/sr7QDpK4+Gv/9mvYAon0GslSmo6ZG01KUtukzvMnT921rHUo+26nCRbkeBQLaeg==
X-Gm-Gg: ASbGncvjqRH4Qci44LdCND0gklmqwtq1CHeQPG7Pne0MZzFiGW25FEthCQ3/QtGZjzi
	fi2KoaDqOs8S0mMIN5y2XZ0TVCywJI6T03lggoTZcYNSkrn1WaZZ/GMq6cNV5sFikbx3+TLO/mq
	svvKAY4QeTsAJiKjNMTGNOdJ8FCIYgMTiyETwHwIwVnYwFsAEE5/6SIc8OD6wQVt41rhkAyDY4f
	bcThAXKe9zTrd5iKz9wgf4+rJ7SobVXeGlDCs0mG/gRl8gRqGLt1ov64Fk3mtt2M9NIBvhsnVDe
	cNzZHdHLksKz28iF9L7iP146rviLvibfGjdnT76Ko+R7osUoG1Z9QOYOQiXM9LqH7Nd7qAnEKnO
	B69xPM4OYCDcmj2fOn6IjgVAN54xIS7nUJT82d5V8Y88Z7uyGb5tiWLuBLH8mtuHW5GLuwU1pjq
	ZFWFzo0Q==
X-Google-Smtp-Source: AGHT+IEeolrbK8Ju/4UkPkf+Jnhr2B2vqnQWZUQZZTD5vJyKAaB8n/76N2YQeS6F2uTGQIcJUUPDEg==
X-Received: by 2002:a17:907:86ac:b0:ae0:ac28:ec21 with SMTP id a640c23a62f3a-af94001468bmr267338866b.13.1754135582908;
        Sat, 02 Aug 2025 04:53:02 -0700 (PDT)
Received: from rs3labsrv8.iccluster.epfl.ch (nat-icclus-192-26-29-9.epfl.ch. [192.26.29.9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0753f9sm425028166b.20.2025.08.02.04.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 04:53:02 -0700 (PDT)
From: Yueyang Pan <pyyjason@gmail.com>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Yueyang Pan <pyyjason@gmail.com>
Subject: [PATCH v4 1/2] mm/damon/paddr: move filters existence check function to ops-common
Date: Sat,  2 Aug 2025 11:52:45 +0000
Message-ID: <cbe01740f7ac5ac7c9fd1ca367d297c3d7f2a69d.1754135312.git.pyyjason@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1754135312.git.pyyjason@gmail.com>
References: <cover.1754135312.git.pyyjason@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch moves damon_pa_scheme_has_filter to ops-common. renaming
to damos_ops_has_filter.
Doing so allows us to reuse its logic in the vaddr version
of DAMOS_STAT

Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
---
 mm/damon/ops-common.c |  9 +++++++++
 mm/damon/ops-common.h |  2 ++
 mm/damon/paddr.c      | 11 +----------
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 99321ff5cb92..2e3409a6c8a4 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -412,3 +412,12 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
 
 	return nr_migrated;
 }
+
+bool damos_ops_has_filter(struct damos *s)
+{
+	struct damos_filter *f;
+
+	damos_for_each_ops_filter(f, s)
+		return true;
+	return false;
+}
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index 61ad54aaf256..5efa5b5970de 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -21,3 +21,5 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 
 bool damos_folio_filter_match(struct damos_filter *filter, struct folio *folio);
 unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid);
+
+bool damos_ops_has_filter(struct damos *s);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 53a55c5114fb..0b67d9321460 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -262,22 +262,13 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 	return applied * PAGE_SIZE;
 }
 
-static bool damon_pa_scheme_has_filter(struct damos *s)
-{
-	struct damos_filter *f;
-
-	damos_for_each_ops_filter(f, s)
-		return true;
-	return false;
-}
-
 static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
 		unsigned long *sz_filter_passed)
 {
 	unsigned long addr;
 	struct folio *folio;
 
-	if (!damon_pa_scheme_has_filter(s))
+	if (!damos_ops_has_filter(s))
 		return 0;
 
 	addr = r->ar.start;
-- 
2.43.0

