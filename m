Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEF830B50D
	for <damon@lists.linux.dev>; Fri,  3 Apr 2026 05:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775194159; cv=none; b=ZTejBURXjdH2cdLpsUnuHVboiEE/ce4ObEDihYjVp3HNGU9E0FRCN5rx9V0XkBi9EdAxs+lvTE5YTbY249I1NMT2ztsw+KFxVTeqdEnrdIQpI3NvkKLlZkYTAX1DxbxaIiRGGKGUgOueKIRo3QfPESIQKpRVTuLp3u4jFG2Sznw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775194159; c=relaxed/simple;
	bh=L9P5HPs487AtJ8kBrpPKeljjzTpp/dQMO3aXJB8rDRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okoP2YcIFTu94c6agXq5k7e3PoNAsM4cCIcCO9oX0U7kGOTwUQ8KARuHo173EB+O0qJ78Ga5OMVHaOK++fFQr/0fWACRUyRFDuhFPfuV43RdS5AWfOx0+9YqGOqNWSpPesOfo2p4F1l768VIi1WSvoNdDNmblIbYaZ3QkMckBLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghfRm4o4; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghfRm4o4"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82a7ebc729dso668960b3a.3
        for <damon@lists.linux.dev>; Thu, 02 Apr 2026 22:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775194158; x=1775798958; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mI7v9qZF+UUx3+2SXpVgBfGXsaFsLAnRc4Dei9eFP8E=;
        b=ghfRm4o4uGtpwOc8r1bGadODGsSUFCwAbhsbpgsuektKFYlD3Msao1j955+BDK1cy0
         jS8aA5rdvld7nBsYCvdCMd0GNmaunMEx3pcRw2Zp+fCUxDPj7ymBad72B4JXDF2kpq6E
         OhfsHb1gt6OHI2AujKl9eeLWbSmKh/tlOykEnGoOTIMvljjF0pShujxPJMUEUFXBmwWu
         shdYGq1EqWF7ECh0ICTt/VaGF28Ab6tiw3sEIU2oMu0/eVkr2kXx94ssjB1uNL86xU2q
         fkJ1+Ky3HelYUCq/xLYlMVnV+ZXx1V0wfWP3aq5mcauaV9F3qy9Es/KV9v0PAXALfSvG
         wXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775194158; x=1775798958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mI7v9qZF+UUx3+2SXpVgBfGXsaFsLAnRc4Dei9eFP8E=;
        b=ovXJvd0cvBXU48GgEbOdYCiHAJ5+CIHAja2qxLmV8qUMYtYbQ+IGstYp4xhJhvO9kj
         8QwQJIFAlelevh/ImiViUsAsEadOpmX5a63e/oLrwjDZK7NdNb8WgrCNpqV7IQwm/dry
         HouC11OpV1rTl1vG8yOGaJYVb/vC0IBt0T3ktPfYDXM23xm7k9HBuIG5cW3rRFgOCW0j
         A8kUF8WDh4lpu3YBYIgjdQpyfdIlxNS+tGq34b4qAQ2An1yVMTAIBpe9iY3dazuzkpim
         rp0nKuRIpzJAC68GwDtV91ILj3PBHXN2I5JC9D8tGQ458CHbnqh59a/vStxklzqMuSG3
         QgwA==
X-Forwarded-Encrypted: i=1; AJvYcCVWT385DIlHANFyYAlF6Z2M2nmdshsoNQ7jKHtKt+4HCDtt/HXscXxL6wlPSdfQouszlEpdoQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxdWI/v1548MfOUozmNRp1lrqJYW2G3jZi/klZYPCjLxAJFTZ0u
	BahhepALTRv4RX3dce954vNBDTv/kBWpl0xoM9fsL3vt3vSBCoVOmHqF
X-Gm-Gg: AeBDiesZCRVhKXEo8F10UqScxbDYoMVL7PyTn1c4PCuKrqxiW3yEAnXdggNZL09Xgv1
	1LHfaDLwTUSyAPmREOXPopIcGILu6ptJRWsTIaVHWOSx6RyhsG0xldOOo9MwHVfygkjeJcdDLxZ
	vfMZiM8fOYIyNeihY31egHzjduWwHupcOdN11SWSuJLFyHNivaZphphqukbPE1zQXD6MCVTyrwW
	9VWCFceBUmRg0WiHotCJQ1/l8OiDUoQNWEFco9C1pLo6yQeV0WhHQ80kJxOwc17s2uAWLzD0TM5
	+5BF0q/7FM8vOYv/FvfuQaJ2/NTUFoP7wHALdHBPZuIEE3WGzlfeRoSp74EUdNiclsxZnFie21k
	3F6b7Cp1hefEQJc8jvIc0MZ+apHcNhPEiI6OrN84YmDL44CnP0rGSMS4Fa1dENQFJQwYPBkaqL5
	Ty46Z+LNNKEwlfze5i6GkdVAMmogw=
X-Received: by 2002:a05:6a00:2d02:b0:82c:6cbe:7935 with SMTP id d2e1a72fcca58-82d0db53ea7mr1762098b3a.28.1775194157683;
        Thu, 02 Apr 2026 22:29:17 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82d11cd2ce2sm782120b3a.6.2026.04.02.22.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 22:29:17 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: yanquanmin1@huawei.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] mm/damon/lru_sort: validate min_region_size to be power of 2
Date: Fri,  3 Apr 2026 13:23:49 +0800
Message-ID: <20260403052837.58063-2-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403052837.58063-1-aethernet65535@gmail.com>
References: <20260403052837.58063-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The damon_commit_ctx() checks if 'min_region_sz' is a power-of-2.
However, if an invalid input is provided via the DAMON_LRU_SORT
interface, the validation failure occurs too late, causing kdamond to
terminate unexpectedly.

To reproduce:
1. Enable DAMON_LRU_SORT.
2. Set an invalid 'addr_unit' (e.g., addr_unit=3) so that
   'min_region_sz = DAMON_MIN_REGION_SZ / addr_unit' becomes
   non-power-of-2.
3. Commit parameters, and observe kdamond termination.

This patch adds an early check in damon_lru_sort_apply_parameters() to
validate 'min_region_sz' and return -EINVAL immediately if it is not
a power-of-2, preventing unexpected kdamond termination.

Fixes: 2e0fe9245d6b ("mm/damon/lru_sort: support addr_unit for DAMON_LRU_SORT")
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 mm/damon/lru_sort.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 554559d72976..3fd176ef9d9c 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -294,6 +294,11 @@ static int damon_lru_sort_apply_parameters(void)
 	param_ctx->addr_unit = addr_unit;
 	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
+	if (!is_power_of_2(param_ctx->min_region_sz)) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	if (!damon_lru_sort_mon_attrs.sample_interval) {
 		err = -EINVAL;
 		goto out;
-- 
2.53.0

