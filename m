Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA39F182DF
	for <damon@lists.linux.dev>; Mon, 20 May 2024 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716215459; cv=none; b=Y2BVCNZa5Cm55YhlFnkyM3cnjeHVhWZHOA6B7oZJm+jQWW/PCzwJZOOLIryV2NYLpzsEVW3Ruxc625ioEcZYKtgQeWZXXe3xNGguwevn04YEYu27rYm4R4NVxkKwwP/0w8mSkCVO5ClavW7Cavl9ss13LTfmWEGJAyvKP0YxTOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716215459; c=relaxed/simple;
	bh=On9o3LYnuqveZn6sVFXBJrcrNEr4DuCBwisKbjYduqA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BTQtWYspeCgWe3ttwpxMFMQmKuO0n/8KsUvwCrUL9TAZS4P25+x0HjJuTMpJUFrdKvwLnedI4upE8T0eubTQhfd5k34dJXCk9tHPh3oab149/d5Ierg3YPa8lZDFtM5iiSHE8cVoLji9wSnLdcXGioN+oP3QLgclKHwte3wnUn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ajou.ac.kr; spf=pass smtp.mailfrom=ajou.ac.kr; dkim=pass (1024-bit key) header.d=ajou.ac.kr header.i=@ajou.ac.kr header.b=qy7Yuu0z; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ajou.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ajou.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ajou.ac.kr header.i=@ajou.ac.kr header.b="qy7Yuu0z"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f67f4bebadso162767b3a.0
        for <damon@lists.linux.dev>; Mon, 20 May 2024 07:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ajou.ac.kr; s=google; t=1716215457; x=1716820257; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O6/FTo8DypMSA2iS27jq2soJuWf60KYz1PensegxJFM=;
        b=qy7Yuu0zmSkIiaEjShJuB2ixOg7oUZraoia+m5MPMW4yL62euRYmEgWeGfmjpXWrjB
         tL2CUizdj3+FIWKTia92CS99AU4Tpku4rmTReLJ8a0gXijtjVVDG//cUgV0pCfqQjHp/
         wZSl7RZekhkCm06NkEqs+/kMWxeaUvec+3Qjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716215457; x=1716820257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6/FTo8DypMSA2iS27jq2soJuWf60KYz1PensegxJFM=;
        b=KKkiPf4HXCILl1AhcqDIkGTCcqfNpvLPc7kGcbKRzX10riA5L3FVEio/chIzmUKa5E
         Wj2M2qqmxg42Onz/nP1/GVA/W/vUtnBQ0wz/icLnMijZIZKagJYWu1GPpVgYUy9pKvo6
         ftAoaqfasz8KBUHo7/8beEVUAfEGRgRAPXxFQ+bAjISTXdKUyLIRxYHSptvSkEK77aOd
         RAeEO0wrKW1t7jRk8ClcGPBctjX88uj66GTgzWHswp6qJaJwFDHl2WQ7sjfAuCTM5haF
         7Stj1xtfvLdbcc+M0ZAJ125ppka7h6oUGNMlhUyZiydcMqzGQS+AIfhKi8IE/MS8e2Bx
         R2Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUxJ98R3w9Z4mEIou/fOvhC2SH5DvCow3t2XRhYeoyHeS85epci/PQS0Fut7esvGsbqjA8INYjtu8Od/TeYu4ee6prN1mw=
X-Gm-Message-State: AOJu0Yx0vFVwNajDvtb1DmsGEyxdMKUp5lasQ5/GpVNnx7+8Lk42sBII
	TcdV9b2FW7ic1FikldKtL4V2rBbT1pbOOBqZJv1a7md7xi0PCDzuGlQxikEHEGA=
X-Google-Smtp-Source: AGHT+IGh6OTBqd7LzPxRAdZQ3TGtw9oZWZ1eNfXRW7gHa0BL/LuIXVhBeDfCAYMGPVqaaE4rw+HrUQ==
X-Received: by 2002:a05:6a00:1901:b0:6ec:cec1:8fe3 with SMTP id d2e1a72fcca58-6f4e02ac5a3mr34376599b3a.11.1716215456568;
        Mon, 20 May 2024 07:30:56 -0700 (PDT)
Received: from swarm07.ajou.ac.kr ([210.107.197.31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2aa017dsm19714531b3a.96.2024.05.20.07.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 07:30:56 -0700 (PDT)
From: Jonghyeon Kim <tome01@ajou.ac.kr>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Jonghyeon Kim <tome01@ajou.ac.kr>
Subject: [RFC PATCH v2 0/3] Add NUMA-aware DAMOS watermarks
Date: Mon, 20 May 2024 14:30:35 +0000
Message-Id: <20240520143038.189061-1-tome01@ajou.ac.kr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current DAMOS schemes are not considered with multiple NUMA memory nodes.
For example, If we want to proactively reclaim memory of a one NUMA node,
DAMON_RECLAIM has to wake up kdamond before kswapd does reclaim memory.
However, since the DAMON watermarks are based on not a one NUMA memory
node but total system free memory, kdamond is not waked up before invoking
memory reclamation from kswapd of the target node.

These patches allow for DAMON to select monitoring target either total
memory or a specific NUMA memory node.

---
Changes from RFC PATCH v1
(https://lore.kernel.org/all/20220218102611.31895-1-tome01@ajou.ac.kr)
- Add new metric type for NUMA node, DAMOS_WMARK_NODE_FREE_MEM_RATE
- Drop commit about damon_start()
- Support DAMON_LRU_SORT

Jonghyeon Kim (3):
  mm/damon: Add new metric type and target node for watermark
  mm/damon: add module parameters for NUMA system
  mm/damon: add NUMA-awareness to DAMON modules

 include/linux/damon.h     | 11 +++++++++--
 mm/damon/core.c           | 11 ++++++++---
 mm/damon/lru_sort.c       | 14 ++++++++++++++
 mm/damon/modules-common.h |  4 +++-
 mm/damon/reclaim.c        | 14 ++++++++++++++
 mm/damon/sysfs-schemes.c  | 35 +++++++++++++++++++++++++++++++++--
 6 files changed, 81 insertions(+), 8 deletions(-)

-- 
2.34.1

