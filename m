Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC34C312821
	for <damon@lists.linux.dev>; Thu, 29 Jan 2026 21:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769723903; cv=none; b=gnWnQGMFq/WCzQ+pbuGN/JQ2qG9JfhtFcM3XDYXgOW7L6b9Ri6Blw+2Yu1moqHMDwYwlcRrw0IKaGDj/YWwh1R5e9rlYeCG+GUhtEo5j19CujoIi1eXq+r0tx/41O90COhTJEIHgVr27iagHmgK3MyVIqNk07BU5Ete0iEIhdD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769723903; c=relaxed/simple;
	bh=E2PzmQBsrkUQlUCjGwf4xR0qYrrxe/5JAZuNmStoFY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mF6+XqH3hy3ewaEHFxAij4BIqtQR8RQat0LasgeOXCKE80hzVLyr3DTd16bzKDjVPK4sNI+OometsdoyBikx4u7yGae2AvD+nQK1f2QuXvU3ibwymvKaFa25BKajCG4CvpLDG3Ero6D5vfu8AXx/nk0RxRRPvNeoPFGJsY6lK/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzjhVZGs; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzjhVZGs"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b7c5db431cso790044eec.1
        for <damon@lists.linux.dev>; Thu, 29 Jan 2026 13:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769723901; x=1770328701; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuNybkTlqvH+9m8T0FgwqGQF2N52zzKrzPQ6MtpsUMY=;
        b=OzjhVZGsrdeS7z6EyI+Q4azSOUjXtDFV/NshG2GWDLOreWJ1Qqz/j41lVENl6GziLU
         9WCLBYd5cqUDZmQp/gwrQELp8egXZDYq62PPFlUhjUNLKeO0NeoFaiTCb9Fy8Oo1AuLI
         rId+WL3JkEmfPIE3b0LAuCnxjsBMeVkWIA6ydlOWIxmazXgYKvg920vIoROjBpBrxQeU
         neuXAEofPOG7kzOKKHApUVMC5q04VfVhIbI1m9YxBWAQdGQvRdhiOFCbA4PxTG1xQkwZ
         iNsJNoGBm7QWa4miCiHBGrC9P22WteGwltUx6P/ta+WP2cVNsSh7IQWJNN0m8Fv+wHKz
         +L7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769723901; x=1770328701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JuNybkTlqvH+9m8T0FgwqGQF2N52zzKrzPQ6MtpsUMY=;
        b=pEaaQoWIVLSuqdHNOR4AHHAMWRP797iCO7dJSethPnmm810rnMVFnwW0p+h5YFpbG+
         eiKj7dMEDQeQq+3PI07bPvdTYrBboPZzE+NeFMgMLQehSYL/+vc4M9P5kO1JWgF5OEvv
         hGZL/CqMxe9+0mWUj+u1cRe7iutCvvExWH2O0fnP0FVqjviqgoCaNB5Arw4PjgYaQOCc
         dNg74NS0lTSYTLBYqKaMZcZShbbBe/uHIjdg3LjYeMD1VdwfYfF1DAf9N793QqsHN1NM
         qlZU1Qcod7S8ZcTmkzl+EHKC5WHylT/br/5oCHLTAf1dZl1FDKrlhhbMs8hP8VAF0Qye
         +3Qw==
X-Forwarded-Encrypted: i=1; AJvYcCXjxfUqlzvV4m9JzparghGFciMdx7Iya8yaFt3FXC45ZY0rMX2mqpNGUloWTxrEvaHl9PKG9w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFxxmbo/fF2SpaTKmLpOKC2wHYGeM7thC9tlW6HaS6uYkE8bqp
	bmEAsZeFPS0CWxoWstN9hZn40EHMYl68gqskPKLuKPkVDoHQ1xbHjQ0=
X-Gm-Gg: AZuq6aIjADuZakp0N/E2zPiNST6IvSKaQdRv7do+kVh+3gM924LC5T/smDnWDpdUcJp
	uv/RcLFxIiKqHlIDLAFize3nGyVd98kw54RluerA5iH/5SSrVxYYiQ5DlSXkoPfGJCv6Bbrp5Df
	Vb+yqlI2scG+gC9YE0iG8vD9LO4GDT0pr2LKzlRAGgYIgnY0dRsuuwHOWRCzfXS8AdiDz8xzSdt
	yzD8BlFT5j0SsPoBCXCkWjOq8+YsiFOwLinBtey6jYDmS7HeKzP59E/MWacmbe0+JE0fJmY7hCE
	Owy+pucaMp4hZ+AMxGYJ1frTSlgrxGyW9mUYTeH66V2Lot0fH4OYOTLKtsUJfKEZotJ0ZQKSm8Z
	la3h9i45k4n2zesEnCJaDoBzvraPNuPMryUJiI2wyjuczAbh1GhasGWDGcJxRlbbBVk31vEogXK
	TY+NVxdccBGw==
X-Received: by 2002:a05:7300:6404:b0:2b0:4c12:d74d with SMTP id 5a478bee46e88-2b7c865541fmr553751eec.15.1769723900641;
        Thu, 29 Jan 2026 13:58:20 -0800 (PST)
Received: from localhost ([137.201.204.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16cf8d6sm8585570eec.3.2026.01.29.13.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 13:58:20 -0800 (PST)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
To: sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Subject: [PATCH 1/3] mm/damon/core: add DAMOS_QUOTA_NODE_TARGET_MEM_BP metric
Date: Thu, 29 Jan 2026 13:58:12 -0800
Message-ID: <20260129215814.1618-2-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129215814.1618-1-ravis.opensrc@gmail.com>
References: <20260129215814.1618-1-ravis.opensrc@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new quota goal metric DAMOS_QUOTA_NODE_TARGET_MEM_BP for
physical address space-based DAMON operation schemes. This metric
represents the ratio of scheme-eligible memory on a specific NUMA node
to that node's total capacity, expressed in basis points (1/10000).

The metric enables auto-tuning of DAMOS quotas based on how much
memory on a node matches the scheme's access pattern criteria, which
is essential for controlling memory migration in heterogeneous memory
systems (e.g., DRAM and CXL memory tiering).

Suggested-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 include/linux/damon.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 3813373a9200..5eebb8aaab85 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -155,6 +155,7 @@ enum damos_action {
  * @DAMOS_QUOTA_NODE_MEM_FREE_BP:	MemFree ratio of a node.
  * @DAMOS_QUOTA_NODE_MEMCG_USED_BP:	MemUsed ratio of a node for a cgroup.
  * @DAMOS_QUOTA_NODE_MEMCG_FREE_BP:	MemFree ratio of a node for a cgroup.
+ * @DAMOS_QUOTA_NODE_TARGET_MEM_BP:	Scheme-eligible memory ratio of a node.
  * @NR_DAMOS_QUOTA_GOAL_METRICS:	Number of DAMOS quota goal metrics.
  *
  * Metrics equal to larger than @NR_DAMOS_QUOTA_GOAL_METRICS are unsupported.
@@ -166,6 +167,7 @@ enum damos_quota_goal_metric {
 	DAMOS_QUOTA_NODE_MEM_FREE_BP,
 	DAMOS_QUOTA_NODE_MEMCG_USED_BP,
 	DAMOS_QUOTA_NODE_MEMCG_FREE_BP,
+	DAMOS_QUOTA_NODE_TARGET_MEM_BP,
 	NR_DAMOS_QUOTA_GOAL_METRICS,
 };
 
@@ -193,6 +195,9 @@ enum damos_quota_goal_metric {
  *
  * If @metric is DAMOS_QUOTA_NODE_MEMCG_{USED,FREE}_BP, @nid and @memcg_id
  * represents the node id and the cgroup to account the used memory for.
+ *
+ * If @metric is DAMOS_QUOTA_NODE_TARGET_MEM_BP, @nid represents the node
+ * to measure scheme-eligible memory ratio against its capacity.
  */
 struct damos_quota_goal {
 	enum damos_quota_goal_metric metric;
-- 
2.43.0

