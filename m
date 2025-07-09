Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EB0146588
	for <damon@lists.linux.dev>; Wed,  9 Jul 2025 01:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752022822; cv=none; b=k02vnFNjVo1KgVIAhCjBONz1+JqtfHPVhQakW1IHtAHCNxSw7XttfvX4A4d9wUMSd1RWxB+4PuqsmIeYmqWqJOGh6m8N0uFU3UHT03cBxQjVtI/1/qleTld3Pt1xagDncFPZdtRdNGadKVq8nNsdpe/thJlfJWwIeyHshYGuWmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752022822; c=relaxed/simple;
	bh=EcpgCEiHcibyxaOwHRX8bt5yDryjoNGcO1lh9/3JWjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qs9zxqWQ2ei37i3ljkPi0p0uP/N41yigbCUdCrs4kqdzcXVc3rfy85FoZJXVvBFKQ5VHbSBAzMk85ZBawobpDuTihYwE1pXAcGk1bd/GaW8s6LLpcThz6ga0B9fZycBOI9yLBaVpDXSa7RHU8lE7GgvRJZAjxKcH5ET4sbaRF+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gB1rDh1A; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gB1rDh1A"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e82314f9a51so3898070276.0
        for <damon@lists.linux.dev>; Tue, 08 Jul 2025 18:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752022818; x=1752627618; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+S+EPhy8VyFlv7h36Y9eh7ovmZghlSmk5oVJFc5gzbo=;
        b=gB1rDh1AOJEdWswS3JwtM8PE1l0Cq1JTBTJjMUUshkrx9Evw2hCgQ5rHnbGVfQzk7r
         GH4BeSbrmI6ZoRbhhl5Tflbsfes/+sXIXysmkNbuj7lWYAkEH5xEoRjRAA/d7w4aae5F
         GAu9StKO05kvTlHNlC6W08tNr+TinqRPahanSROCDLUAqaQpCQAxlZJEat2+/iCQbZ+O
         2J3c0bZwXKdyqb4whSo8Tjk+23wrkmeQ+YgK7k4KKfhj1QV/dHx1J6dhbEptJU1KIBic
         bqRebI9y4eM2xT4qS/41ISkeBtrwHRQBbxuJnfSYDCvRG/fscnlFPsWY9nlIOI7uE5Kp
         7aXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752022818; x=1752627618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+S+EPhy8VyFlv7h36Y9eh7ovmZghlSmk5oVJFc5gzbo=;
        b=BCL2UZZPZNRI1siFjQPTc5iCqg2ZkAJQrG2/egngJnk8WOcoxVYaq+a26HYm4Xa0B0
         CzLx1+CuR7Ou/1FeaVDn8VC/I9gkQuBtQ036DGOigKVuB4SyTtPq9SMkt7MkoSSzu2Z1
         Bk2k+xUHDHyTcg+y5w9/CmsjyKUbgo1TJiub1qCthlEM1CZ2Q5u+8Jou5kGfEGnI2mxi
         Wag77H/G5nsFjo02CR3ZSyjm/S0Z0/AHPeR22z7Mxz3L9yKsvhk6c6n54ZMFfBKri7Rd
         dNKzOW03gbNcABqdMmqJy8iSEAAalT29R7H/ie5ypFWvzzVAXGdNi52eGFev5+mYOYjT
         XVFQ==
X-Gm-Message-State: AOJu0YzIi7PM7tlfHFoREiEggjopzCdhhNDv5Arl9+VpsOxqmufrQzJg
	HTjDh3/IDFeCHKaLf/P9iouzZw8xGsuazZZHvjAu8BC4VEnlNE2yQKwmERIpx6RRfsw=
X-Gm-Gg: ASbGncuL25ORL6vlifio8LtNu1NyWQBIX9pDTaGMZbW78y+Lz2DPPsuIs+lP8A52ERr
	wowgfqBz4V895Pkw30hN5HhW3YoO0yvTXHzw7pof+jPga9rMDOQ+1UIOlOsrL2Dzn06H7yzX7E7
	hH3kofZxM0OkavVfRaaWI0ky5q3svw12wmUbmqTEmdbrxZR98+unQZTcLwNsTOC443NwtdbzWML
	O87TP2kpxLDyG6IPfzEZRHwoxsZdMOeN7csNsc1tNCbahOZSZTH+78hjS/CyYt3R7DYjBBmt6rx
	dDYpz68NGStU1dZXfuV5RvB8lo4C2hDCD7r466gmZ08SwHGNLMDyuGBWO4HuncEAkEWjCDbk0Sv
	cIrtr36M=
X-Google-Smtp-Source: AGHT+IHgAhVoBn0DlM8BUKh4bCqB1qI3HV71RTmOzTs/ExvjbhBZ4AjtFQcsZLzN7auWvUgFy8e37Q==
X-Received: by 2002:a05:6902:18d4:b0:e81:7f36:5a37 with SMTP id 3f1490d57ef6-e8b6e0bc5cbmr1044311276.8.1752022818118;
        Tue, 08 Jul 2025 18:00:18 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:235f:99bb:f36e:a060])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c43ed8asm3656043276.26.2025.07.08.18.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 18:00:17 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	vtavarespetr@micron.com,
	ajayjoshi@micron.com
Subject: [PATCH v4 01/13] mm/damon: add struct damos_migrate_dests
Date: Tue,  8 Jul 2025 19:59:31 -0500
Message-ID: <20250709005952.17776-2-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709005952.17776-1-bijan311@gmail.com>
References: <20250709005952.17776-1-bijan311@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

Introduce a new struct, namely damos_migrate_dests, for specifying
multiple DAMOS' migration destination nodes and their weights.

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
 include/linux/damon.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index e1fea3119538..07cee590ff09 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -447,6 +447,22 @@ struct damos_access_pattern {
 	unsigned int max_age_region;
 };
 
+/**
+ * struct damos_migrate_dests - Migration destination nodes and their weights.
+ * @node_id_arr:	Array of migration destination node ids.
+ * @weight_arr:		Array of migration weights for @node_id_arr.
+ * @nr_dests:		Length of the @node_id_arr and @weight_arr arrays.
+ *
+ * @node_id_arr is an array of the ids of migration destination nodes.
+ * @weight_arr is an array of the weights for those.  The weights in
+ * @weight_arr are for nodes in @node_id_arr of same array index.
+ */
+struct damos_migrate_dests {
+	unsigned int *node_id_arr;
+	unsigned int *weight_arr;
+	size_t nr_dests;
+};
+
 /**
  * struct damos - Represents a Data Access Monitoring-based Operation Scheme.
  * @pattern:		Access pattern of target regions.
-- 
2.43.0

