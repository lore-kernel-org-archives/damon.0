Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640250;
	b=BZdWH+Y772Qdh52ovADdoO/6BrKBWJLdDpOwa6zEupFD2V422PjrI2+jC1ih8Mq6a2i8
	 MtmFkIvZQGRXS9wUOyc3u8mLoQPwDBd5fiwEDDxPTtBdWB8Ru4FtF3ppF03msCJPnpM1v
	 nvb52pXC+fPBRz6ZF8kfDXPDNRdAawCqDaHTWeNVmsT4YFsnTnYZDEEC16FawSVWvQytP
	 Mgi3Q0/YdD6AuKuTfrX/axPUnHR1l0drnX7RLykITOEBDwPl+dXHUVqa1RlWMnxyeUqZL
	 cfaGtCouWLHDqYGIKsILAvJ2ax9nNp2pc2H0Xmw7H7Y14bPc9qPDwxd9+izx7F82iCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640250;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SG9odMntLujN1bfv7U8SkJUk66Dld0t8e7Q+mOyqXTQ=;
	b=anCS/sOMbcKhec8b5zgQm6Fg5E6EDZQyPM1ykkDkvShysmxgz5aMs8Fo5J/jEn/b49EK
	 twmXxzXRXJeJvJlLQPuZSeiyAJzPVtDnEosQxSwiFfcQsuHncOZfPEyDX//fvrmQ+OjPW
	 IqeabuC0RU4fSs92RTm2EuVYhN8vzKh/m4dvwtcyDmnOT6uVrNW+0x/XjY0Qs5YN+JmxC
	 B4Gq15W+h9Rpl9AU9gNpssiwpa5nn1+ZLW+17qr+O4wgPOiwy0cl4m5Vowgdxpsd/K2b/
	 MDVxrM0ALxeRvCZn+fJWPkXrcjBSPNQMHI9/yuka23sEwN0Fs8uGtR9YLdZuzo8C2oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=O+NuE7yJ;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7D2606CD9C
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 07:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD7D2606CD9C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=O+NuE7yJ
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91ecbdf5343so39953066d6.0
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 23:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640249; x=1795245049; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SG9odMntLujN1bfv7U8SkJUk66Dld0t8e7Q+mOyqXTQ=;
        b=O+NuE7yJCUVW6psoSHUYWGYn3ng2wjRiWLi0J5Qq4UrUBBiZJCrgfA8lzn5ZHoLlCB
         eGtb4Gcuxiz5zJVuRwUKpUuKBsN4en0Y4S9gwpLeW7Cc1VFAQNKnrZ5aoANw6wH8To5l
         QPmnMcHeTfOYl6vZdBJO3dP9koJOlbIU6ijbBMtUYEXfhANmOItjylVGxNwFiwFNfhv/
         Satg4WGtMrOU2O03ueZ8QZtFqK94BtEC1Sp4GM28zvWuHmn/XzzFnV/ELqztya+oRfyp
         7GKXfcbic00cf6v7mWGBwlHx2E2DutthCihKctaL2qwuUm29gJI8q9lZZ4pzseEFJS1M
         0b0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640249; x=1795245049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SG9odMntLujN1bfv7U8SkJUk66Dld0t8e7Q+mOyqXTQ=;
        b=YRQ915+XY8GVu/Uf5MkFQgLAG3OV0C/7amHJht8+F0okCNtwchJZSyMWmp0pxw+PnH
         /pgy/L2pcWQbpbSNPlFXM7/dbuMtz34zUATwh/Yp+IDqSj7q4KJ99g+fWzs0QyVFracN
         qBvikULVb5Xf4jLz+bX2MVIW0X+U36Yx3N2G4b2y2GFaV8DYgMb4Q7SeSC35xMP9oyS7
         ADBT1wNCOC6Uf3c3NDMk73SZ90qp1VsB7DL7LdMiC5K8LMlR/29pjU1IrYPJQ9Qg5uZT
         6XP4aDUPjzGoPv4u1gq/sMM5qWGNGXlxdm383xcUushfY+iJef780NV3j5g8Br3wpeHH
         ryAA==
X-Forwarded-Encrypted: i=1; AL+hErE3hIjaidcokA4IIa+1Bd0Vm9VwE+jPAKZc+eNju6b+PMSbF3Gye29p8rxl48ZDJKAJk0U0IA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+TK/Q94/6MlLTByefYfMM57oo8nsgemtzvdgP8Q68bmIey8Rcx
	JLeSy9SDmtI5TQuG1Q6QXq00kKc4GSLHGczn3nDXNp4CaqQSGRGTklh2J/UCMaZxNO8=
X-Gm-Gg: AYBFou0cW75Q+fLonCALxZvLssn0tAQhONOBKdqi8KTg32DJq/k4ioYmSzsyzqPEuQW
	bh/WzvHOYozsGL19/Cm4h2GH72elup6tuVGsiYTn/cMOeaOZWPoj9Qcbof9n5/wC75ak4vi+jF+
	LQ3u+bzN0sMBd+UfBYdpzLZxGmVhnLpGjmDMP5xT4yZuV+PU7KyWaXZwVNqTJrb9/is7RS2EiPX
	qkvbzMF5txcO9onHPx7zq9UmbxCfwkWTUfxDbsGOBG/xadty9psD5KxFfD40LLtZkkkB5mWHTXT
	an7p+f5XGPFpj3si4rsa6plkddSkhiQjUNpVF7JyVHMG9QMkKi3O0RnrfaXUXre1UXqN6E0SLTl
	Hk1METkZ8lzBjsv968PllpQFAEQ3wjWBtTpZovY29MxVbUffkVrTCiRJxRa+K59M+0XaQBpc92e
	5JHdbul+Gd2T9vKyCIWCOf2t0CLUblVnpq8ePWkTX7R/cOwert0/uKoTv0oAJH2jjwAGjGRdNIk
	HxBbcnTUtcqKSAtqQVh9vYv49a822uDeMn/WHLwNXAurv0zf0jmCTmcW07uGKmtZtCA5ddRbV2E
	m+rp2X9hiYwS5oybRRw6Ge3Cifj0ehhrxO3l80GDrwcVqI0tmFqa5BK3w4lAFAzDY9k2GUCx6KH
	yCZaaXouCLlpeIK95
X-Received: by 2002:ad4:574d:0:b0:91c:913:462c with SMTP id 6a1803df08f44-91f23f211e7mr73834306d6.0.1794640248788;
        Fri, 13 Nov 2026 23:10:48 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:48 -0800 (PST)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-serial@vger.kernel.org,
	linux-pm@vger.kernel.org,
	damon@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	johan@kernel.org,
	jirislaby@kernel.org,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	pavel@kernel.org,
	lenb@kernel.org,
	hannes@cmpxchg.org,
	brendan.jackman@linux.dev,
	ziy@nvidia.com,
	sj@kernel.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	matthew.brost@intel.com,
	byungchul@sk.com,
	apopple@nvidia.com,
	rientjes@google.com
Subject: [PATCH 21/22] mm/khugepaged: base the recommended min_free_kbytes on common memory
Date: Sat, 14 Nov 2026 02:09:58 -0500
Message-ID: <20261114070959.3490008-22-gourry@gourry.net>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114070959.3490008-1-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

set_recommended_min_free_kbytes() reserves two pageblocks per populated
zone to help THP allocations avoid fragmentation. The reserve serves
ordinary allocations, which use only common memory, so count only the
zones on N_MEMORY_COMMON nodes.

Every node with memory is common, so the recommendation is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b4bd29f25c145..fac314b89a234 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -3149,7 +3149,7 @@ void set_recommended_min_free_kbytes(void)
 		goto update_wmarks;
 	}
 
-	for_each_populated_zone(zone) {
+	for_each_populated_zone_state(zone, N_MEMORY_COMMON) {
 		/*
 		 * We don't need to worry about fragmentation of
 		 * ZONE_MOVABLE since it only has movable pages.
-- 
2.53.1-Meta

