Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8033347CC71;
	Tue, 14 Jul 2026 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037690; cv=none; b=WaeFXDwN0WCUQBj2THh9/dSk9SM2/tvJRpRGeeRtoxqwe2dJZRfn18xm+Vg0LtTaG2l27kl6u3Hn4in5WnJcKKwQ8c6AM8COcbjboDjMyyHoVSIC6VG93AL6HKxNetW3D5XOJY4KDslRnTjPILFX37sg/eQEu8fMifkRgMYUBSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037690; c=relaxed/simple;
	bh=OtVWPpV+2lpwIou3CILpckN0IN4WhzOz6UmZTo1n9SI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgY7tnQrMwpUOSQTtvrpndw3M56K+4GEUaI/dYWsqt1A/0syGpx6HG8zcKR4ZP/rh2Rn/LDuCG2UROpuS7gaqtOemQ9MiHuZMLNIRoDkod5aXinI7aa30LT0f+lrSpXwxwaIJlqpzDjVYeI0LLDcKQwBoHgJXcTmHc3dziZnhIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AThCemuk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AThCemuk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02AA1F00AC4;
	Tue, 14 Jul 2026 14:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784037688;
	bh=nxrO/4xtAHaLxdanZUyXTCrmeo6syyrgYQaS5wtPeRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AThCemukE+FX5nDLPu9Yg5ZvIPjYN2ueV8uF/mwdcsfpaEQOY3KvRS69A9xofDNsz
	 yEHrAU7aPgQZxVpUXDv8jsTorgbx8vHDble4znYPcy07+GXAI8OBxkGOKEEkYtqNzM
	 +NAo78s9TP86S7XqXWnvbcY5t6IKRJ/LZZ98FTf+LCbZV0cd75pV3HDdDQ0tlOQL73
	 2HLPA+gwjr2gELizwJUVAV8chByBNEIP33Ps/10vffop2wamFSnlPqZWPNqLBLB4da
	 V/BRmP6NdLwC4/A3mB5LJqq4pK4QxLMtzlqOacLNit1Mq+K4RzEc3K8BHtiO0jYrQG
	 RVKf8IqSDeoTg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Song Hu <husong@kylinos.cn>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	SJ Park <sj@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 3/4] Docs/ABI/damon: document update_tuned_intervals state command
Date: Tue, 14 Jul 2026 07:01:15 -0700
Message-ID: <20260714140117.94147-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714140117.94147-1-sj@kernel.org>
References: <20260714140117.94147-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Song Hu <husong@kylinos.cn>

The 'update_tuned_intervals' command of the 'state' file, added in
commit 1077605396b4 ("mm/damon/sysfs: implement a command to update
auto-tuned monitoring intervals"), is described in usage.rst but
missing from the canonical ABI document.  Add it.

Signed-off-by: Song Hu <husong@kylinos.cn>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index f3c99c79b0f57..1507e63ab1711 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -36,7 +36,10 @@ Description:	Writing 'on' or 'off' to this file makes the kdamond starts or
 		kdamond.  Writing 'clear_schemes_tried_regions' to the file
 		removes contents of the 'tried_regions' directory.  Writing
 		'update_schemes_effective_quotas' to the file updates
-		'.../quotas/effective_bytes' files of this kdamond.
+		'.../quotas/effective_bytes' files of this kdamond.  Writing
+		'update_tuned_intervals' to the file updates 'sample_us' and
+		'aggr_us' files under 'monitoring_attrs/intervals' with the
+		auto-tuned sampling and aggregation intervals.
 
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/pid
 Date:		Mar 2022
-- 
2.47.3
