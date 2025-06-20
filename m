Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8989228CF75
	for <damon@lists.linux.dev>; Fri, 20 Jun 2025 18:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750442780; cv=none; b=FlN7YS6yqH72TP7WXWJBrgZC3EGt8eop8iGD2hovaIvCikSK3fe5hgWp3DxPL2eQNZDXvH7ITLr6U1yyJSJW6dtGfi5hy86fcgK4NeaYZOprn14OSSKHRiF5iiGSnBtoHlnE5evgof1n/9wRzdqeiIuRIa++aKeFEFfpfQx4c98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750442780; c=relaxed/simple;
	bh=2EU6uSLySp4qVz7CIbQ43H0/LWcWfqXXtcuBhNr1L3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lG3S7Gnt4q/6VQ+KI7K9gjW0kfk3rxQLbTo5xcRoMSw7p3R/FrVyAHl8QJYGTQFzcsPauuFHGN3/0MvKEs5KxENF+uKyP2ZqMDQ3aZoeV6JZ3MLbqxu9sO+INlYw/O2GT3K52JBVIFrzeDasUVyL4APCU2G/wK0GFGk6eK1JsuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cK+jnJbY; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cK+jnJbY"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e812c817de0so1592638276.0
        for <damon@lists.linux.dev>; Fri, 20 Jun 2025 11:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750442777; x=1751047577; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0j/ufomlpd6m0gY5tZubbQcVJb6iw7GaPU3GEZa9iYg=;
        b=cK+jnJbYevqXdMlqqj37jjAXbMSv9tamc0ik/Cz/twCAK1qxCMogNFkeTxqIkhh29t
         K/fh1VjdafwpwfUc98VkLoa79yAcK01lvcp6HL8VqoIS2xGdjFhz7BvolHOl3QHcWxM/
         JHxHp5fL3hHskn5qW4SWVve7P7XKHhRfwlybMjDSTXin+3Z1/Kwqzxuu8vzULUXB13Tm
         gW/hTtMVNoa9kW2ep+I6a/6O5Ev/pcBDel/b2tZAEpiqSXnnZwbg8Vy1ZLrkYwn/Lblo
         rFfqo4GaiPjGiAr7pkjB5POmpvkZSAcbxDtraPIKoTPBgq7qu90PlGJgL6ZTSezozOvH
         B9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750442777; x=1751047577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0j/ufomlpd6m0gY5tZubbQcVJb6iw7GaPU3GEZa9iYg=;
        b=cjIv8ZUej7yLfFpU41eclupSZlLbHoeV60oCzM6VwuEmPdTJBM3asawfbT2GEAo619
         Nebpc4fP48K8YAtGoWnsV42MZlAIKIUfEmqDazUesXzXxQmDQ0OXlQfnzTjq2FEvIVh8
         UCzPq3gemR8twWeFQfIdstjPIwTyZePKfKKHrKzbRDbi8uI0bRbj62ZtpCImlO1GIWFK
         8XDXk3MseNmpMK4kzPHM3zLtHg/CD3NE4OGNrRukhuXt675kPjGe0pk/7ANsArDu9sB0
         3rwfbqe8BlDoZX/nceiL0zjRtbGCTptkaj8tJV/syyYVYx3y1CQH+wjJCH2EwwnAngiv
         jVkw==
X-Gm-Message-State: AOJu0YwdCjOJIkiLChWVAoSa8vkIM+16GULtGAnN46qB3UPiAWWv0v5Y
	AxQoj9HMhT2VknPf8J1daamFrje/BU0cNSBFMfGB9wxyglDyeQ1TDcJgjLubJ4Q/axE=
X-Gm-Gg: ASbGncsXp8y6yMUO+JYk1fgs5hTe7tO5xrLSjtAKysNygV/ECAJVSE0YfwFpPKUUCVn
	t35EPY1qFJ5Xq+AVZ2iboK3ucnppp4AaaeTHSw6vUhyqbusqmVl46Guths+psPKbPT5MKE+B4XV
	Cr+TnED+AX35wgvmTJd+XWSx2zs21TDN458b5jC5XnpKFINjueUPYhQ2QW+zrCkPdsa0XRNk9XA
	J6q8jxItmBKCi46OX8/R1IQF/ioCi200cmpOCNIvRMoHFAyEVShQ9NBTHSnLoHak+juv8LekAC2
	EORQ/T6nrMy3XgzjuLZu5BtrTTL7KUJOPd67Ix+aKZF0Aph0093NL7etODxA/fhjVYE6FmAxlcQ
	zhVSyaCeSkF0Tg+Ry
X-Google-Smtp-Source: AGHT+IFyrQuIheL3Km0qq8ibo1UbzCMHoBa2trOpqwGzPvwov2xn22FY5UXwBEYftqbjKKbgjvEBlA==
X-Received: by 2002:a05:6902:631c:b0:e84:37e7:4efc with SMTP id 3f1490d57ef6-e8437e74ffcmr948126276.29.1750442777132;
        Fri, 20 Jun 2025 11:06:17 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:227e:8527:3def:3ad])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842aaed6e4sm769304276.20.2025.06.20.11.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 11:06:16 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	vtavarespetr@micron.com
Subject: [RFC PATCH v2 1/2] mm/mempolicy: Expose get_il_weight() to MM
Date: Fri, 20 Jun 2025 13:04:57 -0500
Message-ID: <20250620180458.5041-2-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620180458.5041-1-bijan311@gmail.com>
References: <20250620180458.5041-1-bijan311@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bijan Tabatabai <bijantabatab@micron.com>

This patch exposes get_il_weight() in mm/internal.h. This patch is to
allow other parts of the MM subsystem, such as DAMON, to make page
placement decisions based on the global interleave weights.

Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
 mm/internal.h  | 6 ++++++
 mm/mempolicy.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/internal.h b/mm/internal.h
index 3823fb356d3b..b718ebe7cad5 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1169,6 +1169,7 @@ extern int node_reclaim_mode;
 
 extern int node_reclaim(struct pglist_data *, gfp_t, unsigned int);
 extern int find_next_best_node(int node, nodemask_t *used_node_mask);
+extern u8 get_il_weight(int node);
 #else
 #define node_reclaim_mode 0
 
@@ -1181,6 +1182,11 @@ static inline int find_next_best_node(int node, nodemask_t *used_node_mask)
 {
 	return NUMA_NO_NODE;
 }
+
+static inline u8 get_il_weight(int node)
+{
+	return 1;
+}
 #endif
 
 static inline bool node_reclaim_enabled(void)
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 1ff7b2174eb7..b1713430ee9c 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -165,7 +165,7 @@ static unsigned int *node_bw_table;
  */
 static DEFINE_MUTEX(wi_state_lock);
 
-static u8 get_il_weight(int node)
+u8 get_il_weight(int node)
 {
 	struct weighted_interleave_state *state;
 	u8 weight = 1;
-- 
2.43.5

