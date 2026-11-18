Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968558;
	b=MVLrAJASaDTj0jVF+Qex9WAWlzz3w5v5tOt5c65rGp9+a5BYktBCI47mElfLNobIaW8v
	 /+HEDzEBgY9+gY+q0SUsrjEbcbPA+jc8nxqz3JkwdJT8C9j+xXD6BQr02fT3dMhS19B/Q
	 Z+nZpTMuJs6YYW8CCzm8mN5YbHQMV+ShNzVUp9aMYqz3KfS8IaBAg9tXueKVFTPdLKrAj
	 KsDl4tmkhZcSgjGnprHvTWfH7x7zJoLfCwcIQUpWjzVsebWhzjOQB6BpcGx09eb2T51Qx
	 YPFyxoh1twwD+4hT+9PRDzol9rUfbU849IvspewM1NsGUKp6BQ6jQrsABCsjYk4kPFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968558;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WbZTCynxDA8qlWzkpFXejL39caIBFfSg2B35l700hQg=;
	b=b3RUDHrnH8/nRuUNIOEWyBkAfYLcQdYLk2DucYocgQg1nFEco++9UCUgRj3jJbu5M7BW
	 GdTKwFOJNHmRyIaF3oMWwgwZTFsfDJ5NoXGjcwvfqJ5cfDGHIxnTkb8ABlPdh8Zy9VP3F
	 vkdXxzpA1h7wtOleVqgIfwuGiYBgKjAa44YcgoS+n1b3nS5NZwNJTxNS6pgn3t6vsaqra
	 lBNI90mXIlueoxHxylAHlcveVWR7oeEMb/6mDi/Dzu2ehC1vJXYGjHxFeXLK4erAfjPSA
	 7KFtqjQqEkMWpDcJ9kJed9mMmSLTEK7to4FPuB4LVxU61fWLk0UdTvTA54FWfWLZBgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Es3dFLPb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFEE60A3828;
	Wed, 18 Nov 2026 02:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Es3dFLPb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B755F1F000D4;
	Wed, 18 Nov 2026 02:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968557;
	bh=WbZTCynxDA8qlWzkpFXejL39caIBFfSg2B35l700hQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Es3dFLPbTez9NhDPYj3DPFbNH88TczfMJ58tHJAqZDJuCfkmcQjHGITi69ZUdH/KH
	 aVtgyMeyu3j2+k0A7oOW3wybosmX52+VGcpD6czIJtwNS5oUvpJY35OTKRtCK3C31t
	 m3Zw8g4pb2/Lm5dadlUj+q+TX0q/Cl/GHNsYtluzWKHgFpo1+55TTOrnaaHia2W77x
	 LEAxnK7WhqT1QeP/HKfIEA+NcMUXX4R4DehTGKNVXM0X9R/Kt5UbWDn2Y8OH0m2BI6
	 oMw4KtxpAwPu24RvOS6YZXcTpoYhzohvaH6VM4joTrGEpCxaUSeTzCej9YG7lmC3k7
	 NwpH4jZiM242w==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 16/27] mm/damon/sysfs: support REPORT_MADE type probe filter setup
Date: Tue, 17 Nov 2026 18:22:11 -0800
Message-ID: <20261118022225.100659-17-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261118022225.100659-1-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
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

Accept user keyword "report_made" to probe filter type file.  Set the
damon_filter->type as REPORT_MADE for the input.  Setup
damon_filter->report_type with the filter_report_type user input.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index ca971cf1dcf6d..1c171af4590a8 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1016,6 +1016,10 @@ damon_sysfs_filter_type_names[] = {
 		.type = DAMON_FILTER_TYPE_ACTIVE,
 		.name = "active",
 	},
+	{
+		.type = DAMON_FILTER_TYPE_REPORT_MADE,
+		.name = "report_made",
+	},
 };
 
 static ssize_t type_show(struct kobject *kobj,
@@ -2336,6 +2340,8 @@ static int damon_sysfs_set_filters(struct damon_probe *probe,
 		} else if (filter->type == DAMON_FILTER_TYPE_HUGEPAGE_SIZE) {
 			filter->range_min = sys_filter->range_min;
 			filter->range_max = sys_filter->range_max;
+		} else if (filter->type == DAMON_FILTER_TYPE_REPORT_MADE) {
+			filter->report_type = sys_filter->report_type;
 		}
 		damon_add_filter(probe, filter);
 	}
-- 
2.47.3
