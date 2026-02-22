Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69350224AFA
	for <damon@lists.linux.dev>; Sun, 22 Feb 2026 08:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750163; cv=none; b=VACLBRjtj82eYC7JevWjoIdUotyZ9HHMhD0f4e/BDMs9dHEEt0h8/180fNTXSmULcrDg31rw9hcEOQDt37Q0ioaRu+rPR3dVVhAsmc4rEl6JizvpDHlAP02mvuJOrQ/FGrnJF9cmPNomYUVDjWAiQqEfXiTNA9DkOeqZ7QIAvzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750163; c=relaxed/simple;
	bh=jf3GUNQpUN4vGLRS51AgKk9FOMZj8wdoohrYEV9xOxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u24iZM5NgzAF3bK0wLXyuXetSzg99NaYWf9XBX4Czy6o4TayJ5/x09DTWu5R7nK1UU1l1cHCaOXTb2ow+MOCKyYN8lW2tqnCniNX+ZBOTzi+knbdDLolOEpstu+izVLgQw+64LqkCP1wr8jOFNY06mOqq1LTljRwB2Cnohc/rqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=D+3t0JcB; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="D+3t0JcB"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-895071c5527so41404456d6.1
        for <damon@lists.linux.dev>; Sun, 22 Feb 2026 00:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750161; x=1772354961; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDpP2syoLUpQf1rGH2VYZ/yb+Dz8+coRcRrod2PSFvg=;
        b=D+3t0JcBh/OOrJFQUt/vkn0otlqoSwM0H9br6gy8zMH41GhpQu2CWBtIqPVTJaxwtu
         zkqEQBSv3PxjFo3EYcX2I/4Wfa8aF3cBY4KBhJScPnkLz72izvMeTa6x8wPqfuqDlzrv
         X7zbGt8dHZSVGUeH3ww+ZIZI1iahSEYhajJs/vVe113K1R0EVu+DXBdrUS3LVSUTdhci
         XmPXVYEto9q5MAJNOMsacNiW/amyKLp78PjcBkRh/XkowUBtcWD9zDhkkeys7t5JlwIu
         2nPo/Sw/rrNpDZ1Dw2iFh3e1OgJ5H5sPcYBdjn/IKCB295g2ihHfuSyxY/RUwzdNLXJs
         oAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750161; x=1772354961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RDpP2syoLUpQf1rGH2VYZ/yb+Dz8+coRcRrod2PSFvg=;
        b=NJG4qKl1mx/dVb8Fd0WM+ruXBhOK11UrpCTOpfcXKaKvkglAhZfG/4TcOWF7Qai+Z3
         lVmHMnodwSDrkLcJc/ADRjLtM1LN9iMGy1dwT/GSdD5Mgh3y2kUbm1iWcyQOE42MDCT5
         X/wsvv/rNX/sx/7TNUFCKHoyG+xHwmtB7Ggthih1EhKyy8yCB/RP2UuVEIcvCVPvocLP
         TZ/pbJSrtbv/mkrRNkceOHhdXDdGAUZ2ORqovys7ND2zQRK7t+snbcSDIA9dJtEp5RAh
         64FWXnpAURZ6wJjr0Hz9W52vf0ZMIMdnjoFQLf0YI+JcEa/p0BXe5u3WGQbmxo7uDMoh
         GXjA==
X-Forwarded-Encrypted: i=1; AJvYcCX71QYnvABzkVlokOXZ9hEu6teNBnSP5GaZAF1k1Q6CmGWgkArWt2byCwY5+Gf/Xfphnr12CQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzizbntIJIcAwsIuhmyTlOxz6i5vpT+tMtHyS2K/FCLVTYQEB1p
	R+Eez9zR3e0aXRWThOi85y65CIGRmfAZHTvJBqx1bkIsrX7OVkRJ4Sd14x2b+Em6F70=
X-Gm-Gg: AZuq6aKMj7mMVxqh9E/IC9T/hzPq1x3nw8sP11WK83Ez0goyJr/OkPJZln3BBMtUUAc
	SoaQm1k9sR+1ELXnbrYcW4lbEVa/yk9bU6zBis+/6hUNbyc4O9XIfzrdYjCnQ2rBBiUzWTXvKkD
	65xWuF1UjYJLLoiCuylOwIbfcl4CgB4y01UQubJ66fM8ldtxgbCUsX07c0+vQnJms3CPABJu4t0
	AIT+MRtgdoDIYIC7lD6l0Wbfm5xMn+U6JRVcmL6VsUVNbuALerWawPs4apdZljtxeNJ/bkXUdIo
	BDiCob7+UlIjns+ACCvht++4frPniM5rBEn4NvpWlLu3IOLbo7or+XofdM8OIExMKp0tJMXyWBm
	Dy2F7BUVe6g2cm/wDHAEvKB7a+8Z8HFOHk6M8GX2noN59gk7HzdQLYB3bQulvEPSTVAHUMHp3b8
	4HP+RD92N0MkAwBHBXiEZVv6YuWOSWoOolgnYIoMzAE14w6d5xZdaLNp3k7dFo9uJ/UEdIR+mph
	4N6pcu9jWqx3wul4qXuEzcnNg==
X-Received: by 2002:a05:6214:c4b:b0:87f:fecf:17b2 with SMTP id 6a1803df08f44-89979db90eamr79397046d6.64.1771750161345;
        Sun, 22 Feb 2026 00:49:21 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:49:20 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	jackmanb@google.com,
	sj@kernel.org,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	muchun.song@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	jannh@google.com,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	pfalcato@suse.de,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	riel@surriel.com,
	harry.yoo@oracle.com,
	cl@gentwo.org,
	roman.gushchin@linux.dev,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	zhengqi.arch@bytedance.com,
	terry.bowman@amd.com
Subject: [RFC PATCH v4 07/27] mm/madvise: skip madvise for managed-memory folios
Date: Sun, 22 Feb 2026 03:48:22 -0500
Message-ID: <20260222084842.1824063-8-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222084842.1824063-1-gourry@gourry.net>
References: <20260222084842.1824063-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Private node folios are managed by device drivers and should not be
subjectto madvise cold/pageout/free operations that would interfere
with the driver's memory management.

Extend the existing zone_device check to cover private nodes.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/madvise.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index b617b1be0f53..3aac105e840b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -32,6 +32,7 @@
 #include <linux/leafops.h>
 #include <linux/shmem_fs.h>
 #include <linux/mmu_notifier.h>
+#include <linux/node_private.h>
 
 #include <asm/tlb.h>
 
@@ -475,7 +476,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			continue;
 
 		folio = vm_normal_folio(vma, addr, ptent);
-		if (!folio || folio_is_zone_device(folio))
+		if (!folio || unlikely(folio_is_private_managed(folio)))
 			continue;
 
 		/*
@@ -704,7 +705,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		}
 
 		folio = vm_normal_folio(vma, addr, ptent);
-		if (!folio || folio_is_zone_device(folio))
+		if (!folio || unlikely(folio_is_private_managed(folio)))
 			continue;
 
 		/*
-- 
2.53.0

