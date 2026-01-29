Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66921367F4D
	for <damon@lists.linux.dev>; Thu, 29 Jan 2026 21:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769723905; cv=none; b=dfaN5WpvdNYsjOcZLQhIIG3QBkEC2ZIhY5mqpqxE47mvSRkU9T85IzLttEfM0ZQCu+OSMEF08XfXskbbHjb1X4FLK7e2KJROaqIxCSUJm2NELQR/+xj4Y2bxspQWaVdevXSV1X5mDYkcmrrQf41fuf88Kui2mi7NuccoD43j6ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769723905; c=relaxed/simple;
	bh=MmVKleijncFNV3VTWlVTPh9Yt+NHsjAHFsJeZAvuy5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbLjauOLbt/7vP22msLY6bb5n/4FAo0XuZ4dd6mmxmBeKy5fBMt9+1WFh/Z6vus3A4vKRDxoN5v/+7tOhAoDDXMOGA/1mkjH+/OZlvy3chkMfZY0CsVG52DJ6bBCSjD08teJFDqZx8g0usx0l9FSoPLRbEjp+df1uHGNMeO7sZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgUsq/88; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgUsq/88"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-12460a7caa2so2213325c88.1
        for <damon@lists.linux.dev>; Thu, 29 Jan 2026 13:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769723904; x=1770328704; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmNgqwiRPaM50yoR4bSwou2vHJzKZmxQW0OFYL7FLjQ=;
        b=AgUsq/884GDF3BwQuH4ukwO4EYaRehMqDHcb3rdGafiKsp+Nlc8ljhKM9LEiKQ1UVU
         /dzIa7SaBsj3xieiO3QwCMb+UvqjOsH4xCnqzTuae+/4fXHdg9Ex3Xql+Jl6qatXVbnq
         0faYlGAmUJWZfIEaYqtcTvnX56KqSiWLzqWrUb4w7+hSIHLPpYZNzTk24dmiCGWiSk2k
         BhUvhKcPa6xHYdsigwx/b19+EQaVTPO74jsUHAGX6INKwiS8iR/YTP0p6NblLlueYCFS
         43ZYtUWL5iP2r5q/YWdC+f7MqaItxa5ol+m98/oFNOPutnfMKoy2yMWbSDGdyr8EfX1G
         leew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769723904; x=1770328704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nmNgqwiRPaM50yoR4bSwou2vHJzKZmxQW0OFYL7FLjQ=;
        b=O+elZeBlNoOvfhDQXTOySdAFEClm2yC7BxZlEDDbVlOs2Zh2rMhWAKZw9cw6eZ3D5x
         NhJJyebOEbNqKkKkhwjtnbC8KXhPKcyL1wT+/IG8G2ob7kSgS9sbl7zYhDLW2uv86i+h
         UJOnUOvTRxdbwxgPFeqB5dqiZkNQgrcAig7oryuTTrG07NXez3QfGm8tZW9Vth+JHEfj
         ioW6Av+5+AUCk6n8z6kVZ1RnyaHyBz0LhS03WBoamoYR6WuCUrs4BU4s2mM4cFLh/tMI
         +FyGaCaXnXjiVRCSDlsIRIyaHyt60gNOfSB3l3y2ao1x4csNDSJWGF6J/5NWvf8wYdq3
         ylHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFf3dwykhY20jLSv03DUI2m63DMI7D4Vy9xaUsmH2b45IUJ/G+FeKmNZcodPDx/GwrGspeAA==@lists.linux.dev
X-Gm-Message-State: AOJu0YymRfj73SHtyikPfrejmWSnfCWLEiBARaiZgzMGYOK+JRDVUhp2
	k63pfv/zkHRPqF8bfQvEsiPpBc7ZBBNfhVU1BqkkKKzrjJuvcv8keNY=
X-Gm-Gg: AZuq6aKkIehaiIAomsmMxMMid/J4YU14jtAh5ll2VugCC1BdYNn3yL6rzDCsyP0LqvN
	911pc5+a2A+0P+TuWZYnwLmjUlQ8kvqczdMPY8tYE2ZYFzTe7wDWU+IPI1LzCfgWCHsS75dSYGg
	FUhQ3xOSywMjUhwahMCr47kFtsoZl9/hOwuy3ahOCKKI4an92p+FpkG07wLrpWr2PGdtRJU1v9U
	G73fnlAvSNdECkow29jcaAhohaC9shu/9gAVrm6M0uPtp0b1/WVE+xVksG6zSCnzhlcnru/I/GT
	hnex411jJXjEiGNifcvIZOPfZRq8Qu/vW6988Haohfz/GsbtK+rP1GVMiFYXf9/oSmiOlSfOIuh
	QoOzwmhVuS4MMDYT+ckP1yMnx+wnvzZfOvGgTzAD2YSh/nL5HL7S/prYzX7xSbFaxc/GOXZf2oO
	DEXvaU/3FHYw==
X-Received: by 2002:a05:7300:a984:b0:2ac:21b5:f43c with SMTP id 5a478bee46e88-2b7c86db7e2mr415692eec.20.1769723903529;
        Thu, 29 Jan 2026 13:58:23 -0800 (PST)
Received: from localhost ([137.201.204.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16cf8f2sm9659960eec.7.2026.01.29.13.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 13:58:23 -0800 (PST)
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
Subject: [PATCH 3/3] mm/damon/sysfs-schemes: expose NODE_TARGET_MEM_BP metric
Date: Thu, 29 Jan 2026 13:58:14 -0800
Message-ID: <20260129215814.1618-4-ravis.opensrc@gmail.com>
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

Add sysfs support for the new NODE_TARGET_MEM_BP quota goal metric.
This exposes the metric as 'node_target_mem_bp' under the quota goal's
target_metric attribute.

The metric measures the ratio of scheme-eligible memory (regions matching
the scheme's access pattern) on a specified NUMA node to the node's total
capacity, expressed in basis points (bp, 1/10000).

Users can configure this metric by:
1. Setting target_metric to 'node_target_mem_bp'
2. Setting nid to the target NUMA node
3. Setting target_value to the desired ratio in basis points

The current_value attribute shows the measured ratio, which can be used
by userspace to compute the actual bytes of scheme-eligible memory on
the node: bytes = current_value * node_capacity / 10000.

This is particularly useful for tiered memory systems to monitor and
control the distribution of hot pages across NUMA nodes.

Suggested-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 mm/damon/sysfs-schemes.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 3a699dcd5a7f..50133263c592 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1038,6 +1038,10 @@ struct damos_sysfs_qgoal_metric_name damos_sysfs_qgoal_metric_names[] = {
 		.metric = DAMOS_QUOTA_NODE_MEMCG_FREE_BP,
 		.name = "node_memcg_free_bp",
 	},
+	{
+		.metric = DAMOS_QUOTA_NODE_TARGET_MEM_BP,
+		.name = "node_target_mem_bp",
+	},
 };
 
 static ssize_t target_metric_show(struct kobject *kobj,
@@ -2554,6 +2558,7 @@ static int damos_sysfs_add_quota_score(
 			break;
 		case DAMOS_QUOTA_NODE_MEM_USED_BP:
 		case DAMOS_QUOTA_NODE_MEM_FREE_BP:
+		case DAMOS_QUOTA_NODE_TARGET_MEM_BP:
 			goal->nid = sysfs_goal->nid;
 			break;
 		case DAMOS_QUOTA_NODE_MEMCG_USED_BP:
-- 
2.43.0

