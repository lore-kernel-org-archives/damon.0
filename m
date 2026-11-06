Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793930768;
	b=Udko0WJLEwHQQzr6MzYI557XeaMDftXl1raF6aO0gbRHz6jFfYUIuDD0ILk61J8faPsF
	 /QujhQBlP1axEn3+TVf9m31pnOLBrh1XaSlcV2q/rvQWvZUCOxwQru0Br12FJQlDZk6/r
	 MQg5ZaReB83GK4IkP6LXvhswCMuUaI8M/5H2Bqi+y+zF1YdIR4qBJIVIacElwVkE/szmH
	 CVeSZ9NH1+ijmmTbJaKs9maj5dH9BHHb2bzwPQrH/cSzCseZyFUQwrfgZD98ujyON7YB5
	 IRpKROoSnOiwj91hER8MKOij8lEs+q05LIeGwpd0YWh0krjWJ7OzviP/CkbFjPksW+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793930768;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JU/kEulr0sCfPlgQi9t7wGxnFtKUBD8hcPHbhMmyvTo=;
	b=SAiNInA1GkNy1b7cmSr4Yg5RscAh9GZB5wOCclvwA9jbvSScWJKted+K6YoGou8RutkL
	 laHooU6veJd/xKYQlYCkXkksxMc84daVqJU4vvKkMg9+BDOCt9lqmwYMhUjSb7igCsYXh
	 dncP/eympR9KqYQY3bHYO47bVDLkAhFPa3xMoCU6ISRHvoIU79LFuM+/68hxYcXufinIo
	 o8vJ7erbUA6DwBpW/4kNOdI6TjXINPxPfAH8xpD0RfBYoeRrsMVKSeSdqPBm4lTaTLX8Z
	 94ZElTSrwyIDUiP3zzlOZQQIJFKn8iOfj5zNqyFeoyRJ7CX7TY7V1SpPXY00rvhwNMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IYXRShHc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBD5606A328;
	Fri,  6 Nov 2026 02:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IYXRShHc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A191F008A3;
	Fri,  6 Nov 2026 02:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793930767;
	bh=JU/kEulr0sCfPlgQi9t7wGxnFtKUBD8hcPHbhMmyvTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IYXRShHcXsbYaO0cZRrtcV7bQEp07dVMcV5AHu8xHpmHI7Sn4sKEv3CrQoHEDTpNO
	 AZotsx3lhmFGBIua6I/LILHRLT4tBBBYljA/oYz1hwD5lMetrGbdsk0H45fVGc2SBW
	 Dpy99ebFeB+E6KY9Q4ihu8FIRXyw3uhr25fHIEIqsyWb9pjTA37hT3UxXst3fZ/UdH
	 ErHvpMmy2WyE38c40ruQDGM/ykpfqc1/2eSqewvF5oiQet+6rhp2RJfnjAmHJEnik7
	 L1i1dNeYCiWWqa3irkm6pzHndH0rRVYP9vPIePcBT+eFACJs81sVW1u/OD57ipui4Q
	 ecWH3504Vb5GA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>
Subject: [PATCH 2/4] mm/damon/sysfs-schemes: support DAMOS_FILTER_TYPE_AGE_MS
Date: Thu,  5 Nov 2026 18:05:56 -0800
Message-ID: <20261106020559.98352-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106020559.98352-1-sj@kernel.org>
References: <20261106020559.98352-1-sj@kernel.org>
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

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
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
