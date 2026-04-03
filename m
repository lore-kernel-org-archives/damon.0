Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92A234C12B
	for <damon@lists.linux.dev>; Fri,  3 Apr 2026 05:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775194163; cv=none; b=gqVRawuETnQYJV/Xym7pmqP23Y1vMUZzZg+jxEGII5qb2Vpt1NIpvBdsUjHw7N+Ecv42KjvT3VVti82gOfwHlZjZNI63wgQU9tODkGKkWWctEg6RNItSfZQkMcbCAJdeUOq0duwKEFi8T6AvVtH0w8F7jyWV+u4UVuTjoAH2+EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775194163; c=relaxed/simple;
	bh=nnz7rfBh4E/7qdvu4h6qKKfTn2Jhn2jRQqSVmtYrHV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCmf/t1hj4GCAwg0SU/x6D6hi7O/szy9WTLbrw2tlgiROp4pQ/Wk44HCw+RQhQYrnzDc7E287ysb1L2XzbgOVBuubBCD9WDJGGmQ7NqRcPwVplPuG7t5Ra9FTZtMLDrZJfA15C1MH3UJC5ymtuNRj84Xq/lBJkuokKU5qfTQHCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnldMja7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnldMja7"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82c28f0a4ecso1204902b3a.3
        for <damon@lists.linux.dev>; Thu, 02 Apr 2026 22:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775194161; x=1775798961; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DhGk7ekX3JpECpQ0RXFDeILDJMOxG359GUgFUbcyx0=;
        b=fnldMja7Z4OBSgRvyVR5KJFI+Upmfkb8caUbjQJxfZ9ItntGGEhxpaoDMBDuysWKUD
         /UOmyJqFkhptfVk2wbyhhUThWGD11Lh8zjJJBLJ+F7rJIXTaSZd+TVs8Zb+DMmJtaEZn
         FNUyIjIvz/sUIQw0lg+LKzqsVO7TL57w/7Fe9HtVm9qav+bA28tpzD99Fee5xACs6EZw
         a5V16phe/lZwYuNnrCxNFzc1hlx23QphNUYRwo68o/wscKCZihzM4L12D+geWm+YHr5G
         8bXMbr3efoyRBnDcZiRDX1yC/vhELmzqm9kTmxojccpt6dHPy27X/p5JhrnnqW6MoHZN
         IyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775194161; x=1775798961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7DhGk7ekX3JpECpQ0RXFDeILDJMOxG359GUgFUbcyx0=;
        b=msnCOFIRXDQEQogf46SmA3b4+C3x223xcnyuwIHEHA+BfTa7+WmWyNyrWGt94ceyBU
         x6fG46mc3oZ2jZPfYiwbH6yu0EQnjWElqZ5GIDuxOUXeygJMr5Aw/GCazwxle7XBozPh
         FUatVJbbpv1Yvu/yOR5MchefajEBG2vxw0QqpbUOcHfb4zh45J2jAvmNttzokduIOKGE
         iwSLtm0Z1xSlPsXVhibN7lBaFujqg5ZAY0zBwagQnf7Qo69yqlgbtRMHk7W5ncPe/EbZ
         s4hipkb0bTP4riBWjsEyOc/3s0R/C55DKRJamGPs0ozhwSHWHF6RfSNaWczfg1zVala9
         ngSA==
X-Forwarded-Encrypted: i=1; AJvYcCXc99j/q51+qKblyTt8hO9qGAnCDlPlRNPyAJNODRU6g3cKE0i8dzBwV06IFnQAekaqB/m9PA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMs7qENZrZq34HdIHROncaiJslxJnr+cRfqCpMGFDqiGt+dU/J
	KvbBghMfZVA6QuHLZtWB+uUYGWXdVdxzD7VU7/QEKGnrHgJzBHJJg67c
X-Gm-Gg: ATEYQzxRA01qyaT+AFr19vOlm/UMHfq85gKyTHt3gcXHZz1XCmRvGtyoPxUC0LYGiXx
	Lxy+YDc6nw1SLm+eigVdgV9EnJrHFva0t94qYsuWmcfvfDLxJ8IKriMVPlWl8IEbYSRaVgoOWmj
	tNWfq52WIIEANywLWNBBbB8+lrc3XBuoFFuafPEibr/ViU0qwC745dKPU1Dv+hsgtWdQ5cQKQto
	5mOs2cNvR00UVzmEA7KrFRfKrFX9AJy61w2kLP0bhhtxVZydY5HXoaFyzrJ1Ilv7zu9HAHeEde1
	oKwFeqjK9YDe6J6ZjinDFfBSksq2dJpi2zW1OTYeqoK/dx2zWR6Gcs9BoLwU4tPimr/EvYMaUKb
	LWu38Bl9yDgoL6EGEkKkgSBgdGG4tUvcHlp1KOAO6cAHFjQiMjp7WphmWjCQm/ZWUbN8SkYBVuK
	Sg7OEW0nhruaQ57yZKZlsLYpqgfNmxH1VptrymMQ==
X-Received: by 2002:a05:6a00:6ca8:b0:82c:28e8:a009 with SMTP id d2e1a72fcca58-82d0dbc7a68mr1847464b3a.51.1775194161239;
        Thu, 02 Apr 2026 22:29:21 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82d11cd2ce2sm782120b3a.6.2026.04.02.22.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 22:29:20 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: yanquanmin1@huawei.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] mm/damon/reclaim: validate min_region_size to be power of 2
Date: Fri,  3 Apr 2026 13:23:50 +0800
Message-ID: <20260403052837.58063-3-aethernet65535@gmail.com>
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
However, if an invalid input is provided via the DAMON_RECLAIM interface,
the validation failure occurs too late, causing kdamond to terminate
unexpectedly.

To reproduce:
1. Enable DAMON_RECLAIM.
2. Set an invalid 'addr_unit' (e.g., addr_unit=3) so that
   'min_region_sz = DAMON_MIN_REGION_SZ / addr_unit' becomes
   non-power-of-2.
3. Commit parameters, and observe kdamond termination.

This patch adds an early check in damon_reclaim_apply_parameters() to
validate 'min_region_sz' and return -EINVAL immediately if it is not a
power-of-2, preventing unexpected kdamond termination.

Fixes: 7db551fcfb2a ("mm/damon/reclaim: support addr_unit for DAMON_RECLAIM")
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 mm/damon/reclaim.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 86da14778658..2747eef5919d 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -204,6 +204,11 @@ static int damon_reclaim_apply_parameters(void)
 	param_ctx->addr_unit = addr_unit;
 	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
+	if (!is_power_of_2(param_ctx->min_region_sz)) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	if (!damon_reclaim_mon_attrs.aggr_interval) {
 		err = -EINVAL;
 		goto out;
-- 
2.53.0

