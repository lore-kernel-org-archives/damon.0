Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EE1386C3E
	for <damon@lists.linux.dev>; Sat, 16 May 2026 22:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778970897; cv=none; b=U28n4+V3+VOmsT1RB87OEgzcDbcA+5ieAuowI7bPNV4R3YAS5E/heZmqdInjW0OeBONG0X3n5Fa9WB7N/SlAVY2t56b/w6tLk+r3aaGE25/ug9x/usrAilW50PddR8YdFrWSG12ZhXITRyTPUHYzRFpxzisDXDQ2KHWgrdOULcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778970897; c=relaxed/simple;
	bh=6TWoslMuzMBm6p3WGtEbFUBe97Opnv7r3KdrTyJtUCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFjAMmOB99ihtWxtxmsC20FVLrh9GnMtbeDnB+ePt8cMSfVYciMf0ueSAnIHIh5GQzsYdK041Yabg++mE/8+XQ8yPJQPN9hiPcGU3AuWoKPjQ/fDBMYdgu1AG8XRsroLeNvPdYSIe6SmM890nYbgZAEVYijnaBktZzDl6Z/Y5w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENuHqcyh; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENuHqcyh"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-7bd5dde63dbso5294687b3.3
        for <damon@lists.linux.dev>; Sat, 16 May 2026 15:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778970895; x=1779575695; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJ4eRCsRtGruvU7OzNvMy5LtAnMvACrX8iMrvGPwu/M=;
        b=ENuHqcyh33x6OPHW+ylgJNqy9fCog4emEh0IswNQ2NeXaJCk8TwBOVTQHi24atnycl
         JRjpE5UFIgJtLPhq9/RWOW32+cNCTLcOx/9dUOsLWACaj64NWrjbPA1mI0KQk9FxvZF4
         bXtSd/9sa4UPI0/xEIVDowaL7xWKOmqgX6Q09Do2T0HC2f8MNhCI49+xGrTZWl5nXtia
         3U+K/mlA8sKSGoK1cHPkekgu9/PX+VA3AkQRRi10RBOPpEQScHzN5sVJez8DSAyE7pV9
         RnbaCCZ2vynoSItJZ61utfQXlpoXJ7GgAxbvmFopfJ2VUSIkbHXBHEfTD8grbK/0mx8K
         bXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778970895; x=1779575695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JJ4eRCsRtGruvU7OzNvMy5LtAnMvACrX8iMrvGPwu/M=;
        b=HgKxPph6GW+/CHaYlCHyCSe1A8ZOQUYv/2Dj7XGTw/o48wMFXL/OiCK2HrkSC60JkD
         uhMXoaXnLABLZ9/Pgg/UHJ+bg5rhAp8xQUBupIEe0c/pIxjrHmN6lwbC4lp2t38b+9v4
         tb1nOESefARN734tIdqC/v6qS2a3doqTbDatl0brijpcU/dq7SxZkSjaYhRYp1uzOEpQ
         jjDt2oRTyXSvbbhydpaZHs4zKi9wJg21+vGMcdh+bic2kS5JYyWjvVRus0pMxPwzc+3t
         jbqzjjiNjSXW7nN/XGFo4b3rnFeiv8WSbV0wCS8ES8TAlwSYQz1gEYOGmjNX6joUthB4
         qHjA==
X-Forwarded-Encrypted: i=1; AFNElJ+ES3zhQ++DNUvdcCO9Mjl7K+p7qyUDegHnDaM3U1yBWILdoi3y0EAXKfXBkqQ2B4f1gGy2gw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXFsUubVb4ZhzF2/NQLXKXltp2HA+I0wnBejgz/1DSP0pCL33y
	qMp0QH9sLhEhN7mfVIC7tvBFaXgr+VoWUEo2NEGMRTJl14F1kDX6hgM=
X-Gm-Gg: Acq92OH6+o7IRQTYkC02nckyOtZ1/dN5chmddkGyX6l8yDSW75K9UUl4RWbybmg9fzf
	5cCGAlLMx16ry5/1mQkfaTzzLiVxzmWBIixRsKLZnbuMsZLSNLVyfYBq4qMRXsPYZDqdAqDNzIZ
	Qf7SSTu75RzdXGPegHFyAvFW6bFiHKYJNTQabzxzfZBMInS+CG1fx+ElZiQy64SPNQLbVMQ4lzX
	47GeCdd/QYpGLzMuz5vNM23ovdKHfE6fODNrJeFIMYQDRvmP9VgqAk5oojNxjO2BPWG28YpTYuM
	KmHwQD6iY4HEZxISjvFX3pD0N0m3ZAtB2sqD8tI318UyI2gnkHgbjqV0G3PHwwHdRye7uioPw9v
	XfIkuweIIRV+ZXqmOGim8XSMetnJb+xNedfB1yuRdW2X6gsIj6jI1tK52gAOZNUgRubdYzGUG6d
	WN9N9nkK71jbvlAHt9s9gVuDxOijF19jnCav2K4rPN1qrx/9O/vkORlQ4NabfX3kS6cXEjFK/f8
	/w3Jk/XOdM5
X-Received: by 2002:a05:690c:95:b0:7bd:9ce7:164c with SMTP id 00721157ae682-7c95caea6camr98089637b3.43.1778970894660;
        Sat, 16 May 2026 15:34:54 -0700 (PDT)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9cea0642sm643557b3.45.2026.05.16.15.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 15:34:53 -0700 (PDT)
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
	ravis.opensrc@gmail.com,
	bharata@amd.com
Subject: [RFC PATCH 6/7] mm/damon/core: accept paddr_ibs in node_eligible_mem_bp ops check
Date: Sat, 16 May 2026 15:34:31 -0700
Message-ID: <20260516223439.4033-7-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260516223439.4033-1-ravis.opensrc@gmail.com>
References: <20260516223439.4033-1-ravis.opensrc@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_get_node_eligible_mem_bp() and the damon_commit_ctx() validation
path reject any ops.id != DAMON_OPS_PADDR, which caused paddr_ibs to
always get 0 from the node-eligible helper.  This caused the quota
control loop to run open-loop (esz doubles every tick) when using the
paddr_ibs backend with a node_eligible_mem_bp goal.

Introduce damon_ops_id_is_paddr_family() and use it at both sites so
DAMON_OPS_PADDR_IBS is accepted alongside DAMON_OPS_PADDR.  The helper
also gives any future paddr-family backend a single line to extend.

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 mm/damon/core.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 2aa031cbc70b7..1e52161f4c015 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -83,6 +83,16 @@ static bool damon_ops_is_hw_hotness(enum damon_ops_id id)
 	return id == DAMON_OPS_PADDR_IBS;
 }
 
+/*
+ * Returns true if the ops id treats the monitoring target as a
+ * physical-address region (no per-task PID).  Used by paddr-only
+ * gates such as node_eligible_mem_bp.
+ */
+static bool damon_ops_id_is_paddr_family(enum damon_ops_id id)
+{
+	return id == DAMON_OPS_PADDR || id == DAMON_OPS_PADDR_IBS;
+}
+
 /**
  * damon_is_registered_ops() - Check if a given damon_operations is registered.
  * @id:	Id of the damon_operations to check if registered.
@@ -1787,8 +1797,8 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 	if (!is_power_of_2(src->min_region_sz))
 		return -EINVAL;
 
-	/* node_eligible_mem_bp metric requires PADDR ops */
-	if (src->ops.id != DAMON_OPS_PADDR) {
+	/* node_eligible_mem_bp metric requires PADDR-family ops */
+	if (!damon_ops_id_is_paddr_family(src->ops.id)) {
 		damon_for_each_scheme(scheme, src) {
 			struct damos_quota *quota = &scheme->quota;
 
@@ -3041,7 +3051,7 @@ static unsigned long damos_get_node_eligible_mem_bp(struct damon_ctx *c,
 	phys_addr_t total_eligible = 0;
 	phys_addr_t node_eligible;
 
-	if (c->ops.id != DAMON_OPS_PADDR)
+	if (!damon_ops_id_is_paddr_family(c->ops.id))
 		return 0;
 
 	if (nid < 0 || nid >= MAX_NUMNODES || !node_online(nid))
-- 
2.43.0

