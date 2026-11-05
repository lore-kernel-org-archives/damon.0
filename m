Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793853884;
	b=UGNFyVrLT0TqW/C10iPeFszgaZ+oybaVdsocaWvzpJsaBDKhpFNYaxcu4mzv4VUiuAJJ
	 R1/z9HhN7zwe5xJprFV/bXZJMfCKKd3q2ll3h7qkOjVfoFt7aMss6I5uTGddeG6vqwIOI
	 gMz51JETuO2LSVc6qsVTgj77C4zy5co4bPeOwi5+ILNR4sCSGOdGpyEe2+srWCYA2D1/2
	 Wz9LV604mCm3Ginl68Fp8plxZrsydeTDcJxhlrnL4m7NYjqHwgv+Z5vR1qDirXRLbcdMY
	 lFhfoAD6gUC/g12PmOOn+Bl+7OixpCbS2ASI7KSZdkQrwHdwk8Y9SR9RkMg5EaLI+rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793853884;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZAbRG5nmi0Dlv5LNX/DTzBA1Q08jKkTod4f3ioIPBRc=;
	b=4pfM5kew9d699ULHL74ug5bKSLU0SbMt1vSvXuGoqtLQEiHfvXPD7DI0fuNSlyiMZQIP
	 NWzUbhIaTMHm//XE27UcMgNsZp1wye8aRcqlf5Rlxe/OXc2KQzB0qrbuTsbBDuO7f4MH8
	 0RxE/h1iWAKQgkjjFgCK0iYG7NPAtjUlHXQIlHMSn9/B49jH0z5QkIq19Te3i8bApVoJO
	 pX8QP+1DlP2bG/tosuP5wNexZuzLdh82ro6ruB59/K5Y9M7ZU3wgpHHZPOs4Lnz8feCmv
	 FlDmDo90LOXAL4rfxGCqqoXMBX9wEQQIX1rysmzEKg9C4vrVsnwlTj2G7QnU8Yt1RgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ErzpgnKh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7BB606A334;
	Thu,  5 Nov 2026 04:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ErzpgnKh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719B51F00919;
	Thu,  5 Nov 2026 04:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793853883;
	bh=ZAbRG5nmi0Dlv5LNX/DTzBA1Q08jKkTod4f3ioIPBRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ErzpgnKhpNjXJQptqM0q6ZwH8gcZHbRs2Yu7ycSRHH3UpU1n8U458+RlKTPspGCX7
	 G0AB0PWCf2Uno+Vk2IyUrwIi+Zkebhcv1tUSIMFn1x0NvxHmIU/V3fuWtLh+NtxvpJ
	 VUTIDCJ79SO6+TkeS+v4NiST4ZfZk0hF9ElKnDSCgMSebmodttae3KI4FB0XopXLrn
	 ECDM1B55/1nM6XIY0m3PwQg5RRzEFaaAYpyv6AF+oGrW7tYcR7Gfli/Vb7MWCQZlNT
	 hBackJ7cUTL5QmMMhdGKbiGt2z67IFutU/7Fm3UjZkw+m502wW4Yh0VgQnwqI+kN86
	 Nn+Vr7hEQx4ig==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 2/4] mm/damon/sysfs-schemes: support DAMOS_FILTER_TYPE_AGE_MS
Date: Wed,  4 Nov 2026 20:44:22 -0800
Message-ID: <20261105044425.87142-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105044425.87142-1-sj@kernel.org>
References: <20261105044425.87142-1-sj@kernel.org>
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

Support use of DAMOS_FILTER_TYPE_AGE_MS via DAMON sysfs ABI.  Add a user
keyword "age_ms" for configuring a filter of the type using the existing
filter configuration interface.  Reuse existing 'min' and 'max' sysfs
files in the filter configuration directory for storing the age range in
milliseconds.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 637f1bd0c950b..230987efac3ac 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -593,6 +593,10 @@ damos_sysfs_filter_type_names[] = {
 		.type = DAMOS_FILTER_TYPE_PROBE_HITS_WSUM,
 		.name = "probe_hits_wsum",
 	},
+	{
+		.type = DAMOS_FILTER_TYPE_AGE_MS,
+		.name = "age_ms",
+	},
 };
 
 static ssize_t type_show(struct kobject *kobj,
@@ -2875,6 +2879,7 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 			filter->sz_range.max = sysfs_filter->range_max;
 			break;
 		case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
+		case DAMOS_FILTER_TYPE_AGE_MS:
 			filter->range_min = sysfs_filter->range_min;
 			filter->range_max = sysfs_filter->range_max;
 			break;
-- 
2.47.3
