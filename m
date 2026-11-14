Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640240;
	b=ljmt30Egzl9Q+c2mMj30MOLnhVNq6NuQ30bmZOf40kXJEs+vuXh7JYIPyZF9x0MD8fsF
	 nujSdIe8KhR96iU3FdVv5GmxPb4CSnggFvSKTGN4mP1I1rvjGBronjF8Nloecygh7iB1R
	 hQ1fe2Nqp0KohCjxtfaSwIsx6MLXF+kaW+oCRDFzm0OF1y84VWylBgLbyIroopdWjZUwd
	 h7i2UwgDh+sZg54tskInnuwnTEAWzyULzbd62YTuVMoK+M5k2rwbBmK7bMAOhVXfe7AJk
	 +2Jcj0dnFdERzKbNUwH5lMFJ+wNt9g7W3USZcvtVHLBL1odqp8sqs3OGKsxcAs4sZNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TW0pg36vCDijleVRTyqZR6UjU0iehYYk3FdVNC+q6Cw=;
	b=WscDvgKOxr8Zq280VDLM6lHcVXLF+ldCiTLEWptqjSe33qOqlS1UCMobS0q1XJicGfda
	 kcINJKoc+7X/WdKwcC0EuP7o9bjrg2bmwgekrJwpQWAa+PxlZPJ4//zI3wsmqgfYMdurf
	 FNs5P7sriVZpG/2AGupekPXEn3sCR9+1LT2Nl2YRgmFiyLg7JWbYLfMYPjvjecAIK6dNL
	 fBjpyCkChWojQJJbddTBBd7De18BmY9JsIRg7EKhCbdDemcRywE3TsZdnirzaKs6TWMI4
	 VVq1+mBYiBvbm6KoVqgGDd262ypnhWSlZC9udzxomQvmw+04geAaEjWNcs7ORwsWkOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=TE3JlMbU;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AE360A2619
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 07:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5AE360A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=TE3JlMbU
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91ebf4cd218so27850996d6.3
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 23:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640239; x=1795245039; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TW0pg36vCDijleVRTyqZR6UjU0iehYYk3FdVNC+q6Cw=;
        b=TE3JlMbUJAYnSFB6WBXsLcgEn+bQBWcYy8Gp4d8vKosGJUP+bCoeZ/l/dGVjt6wgSd
         kX533FJOKHS5OsLyx5seillcVIu//3TunFSvKkeK4lUyDmWzMAmdJdSKnmFTu3RdkQAP
         KFNEotulcnFRJe42Wcbmy6QKQC0Y7bKVC85IMnCpaPX63BL6U11GyD9wEMJQ8c3ZktFt
         dI3yckXKQSxuMbWFmHJPAZj53+iBhddCkCwc/46yJ6+Cjhba8uziM91jLmgBgxCQ1dH+
         /QC0okzFqSvJk+QXU5a/mt8+f7p0y8m2UHqy6EnZGi7mCjypPshjRZp3jALU0rQaz+/8
         uEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640239; x=1795245039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TW0pg36vCDijleVRTyqZR6UjU0iehYYk3FdVNC+q6Cw=;
        b=JE3XxMrey7225mUbIoH8t7Frl1+wojC6soWTxwc8zemEjpZqvIEKcP4ZMM2gg+K4C4
         gUTALoQccI94pJ3ZVKi9QOiYODrw3n5IMk5CY0y+e1+RuYKKpqPkqewWhS6g9/duq4dv
         HKsM7U7jrggy/BF98AWWd/Ukt3vg4vbjZJyhJDa0t8i+8rJwcpiSgd5oUveXUR3EPaQ4
         chHck2uDR/7p/WuImXKbKQjBNKThYBOd5z1juq5xDBpMlNcK1RoO8LvZnvssyjS0+XIa
         MNhPk/lfvhlzwJ5EswDuuHGa5uF3xNhUW06tf26Udou1OLMQKpzO8FfWKzTu2d1lxL9o
         3oSA==
X-Forwarded-Encrypted: i=1; AL+hErHNwIaZFHtA6454Iw+RnvZ6PGdZDE9raHV3/v8Md2ox2Mmx4QhzQY6pnwUqmPUag3KnVvr9yw==@lists.linux.dev
X-Gm-Message-State: APuU4Z95nE4Jyr95QhE70qQ8BygLxHsbFDpXUsUUTa/BXPB7W8yjsTuw
	LISiDi2m0W96hMuGxM4sDPMGo79ULG+rXnso/V8yOKgs6csiwXUmVPtIrB6XLhzXLfo=
X-Gm-Gg: AYBFou0GtiJT9FKzRKQqakvQT9Glrin97IYJHAiePzBvYj5P7dr0LWfjqEk/TjLrU0M
	Zr0PC5wA4ryDx1cKlHuUiItlJsITgWxOf+5i4Q0BCWfM/BPmqqERjVd26wZnUZ3HQ8Ezwh12iPN
	fqQiI4Y5oa+5GcnzmctQVAtv2OuoYtnB8XIY0y0dhauc63v2hDLsVPA22rxyLxMApCFqtZk0AgK
	Xk+k1ApZ/wFY51XeuX0xWSkxtsCx3imkXO/amnhrgvUpoUA+taPj5w5lemXHHbLlby30sXP/oLk
	hNJnacM7dTRo0vsshDRX7OvGjTD6z0nQmdU5tBDwPUFbpaC+swaR6zmU0wVyCM+Sxg1YA+QPr3T
	GuYdr1DppO9/Hi4Jngm9/Ua6rEL8hQxNUk/8b5ReO3tZqMPC2j55pjCqZvUrgb0r08W2V9nb8Mn
	UOj54FU2GoF2mzrq0ydUJ8yGQh6Un6U97D0ehaHfAJTfQQbtOthsUlXUW7uj8hiwRx3WhJ+lazB
	JKX/f5XYa5y4nLhT5G/z5UWplu5zdBdiojpkFnx/HzTFm+UKIofy9+qSkJhLHe0y8HZYVbimOiB
	qNVZuB5O7hzFnJ4Paks10PMg+MUdBVWbuxa7ntN90QLsQeZimZgnSc9+2Vy1Mfyc+FtsTsCmps4
	vIkpZSXbeCCxg4dx0yVA52H/R2Yj4/urx8pyA
X-Received: by 2002:a05:6214:1311:b0:91f:2208:b683 with SMTP id 6a1803df08f44-91f2428c6aemr76715686d6.55.1794640238785;
        Fri, 13 Nov 2026 23:10:38 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:38 -0800 (PST)
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
Subject: [PATCH 16/22] tty/sysrq: use common memory for the manual OOM zonelist
Date: Sat, 14 Nov 2026 02:09:53 -0500
Message-ID: <20261114070959.3490008-17-gourry@gourry.net>
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

SysRq-f constructs an OOM request with GFP_KERNEL and supplies a
zonelist for allocation-constraint checks. The request represents an
ordinary allocation, whose fallback domain contains common memory rather
than every node that happens to have memory.

Select the zonelist from the first common-memory node instead of the
first memory node. All memory nodes are common at this point, so
behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 drivers/tty/sysrq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index f4571d05b4962..824f5836b47d7 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -386,7 +386,8 @@ static void moom_callback(struct work_struct *ignored)
 {
 	const gfp_t gfp_mask = GFP_KERNEL;
 	struct oom_control oc = {
-		.zonelist = node_zonelist(first_memory_node, gfp_mask),
+		.zonelist = node_zonelist(first_node_state(N_MEMORY_COMMON),
+					  gfp_mask),
 		.nodemask = NULL,
 		.memcg = NULL,
 		.gfp_mask = gfp_mask,
-- 
2.53.1-Meta

