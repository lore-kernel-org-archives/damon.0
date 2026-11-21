Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294828;
	b=LSF3neu8lVUOBavd+CzSznKcmE00aAWpfZlcXVYtX3W9BgQM9QABDWihZqKMqR+9OqYU
	 tgbaqaezrHC2Y8TIhB+D3X9sYoOL4Qfo7wtXby3vxGbBmHkv938isx/NoJx0QwBuItAMh
	 iApy93l7XNj+9BtbT7cEIvnm0zljRl2iHWHT8pJYH4jPtMKXDu4iXYRvvLhAoshQ0dyGl
	 CB6eoQ5qelOFgIymPeD5v1Jpkv0swz+e2n8i0S3YljP89Wq+MTCzuywk8Kji5TVrAv46c
	 at6La1qAAPlx+6djomRKk0XiQhloaTKljCYXxqti5NuQARlY08uIRtsSsBTU6A4yquA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294828;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FTjjk1bjDwpUg3WWMwzBwOs56rHK1uC/DHx/Q7GkWVo=;
	b=YazZYv0MFkWCHG4bA/o0sIqV3lYlBM6Y7CrTd1vyXgGHatXANcnklldUBeNkUZHN1jlf
	 EoG+9uPi3ajO8+vnQpG3kqdCMHqkrCZopteu3q8r1Ez/iKoy3P4c3Q4SVVTOS0r2pi6a1
	 A2bGwdlayMB7krJkzopchogENomitwjnruALLxRt3TN7BfqP4zkATJztUBtU7Q9excXBj
	 HRXMPYQTvUK76dHUJswnLdXVyOQtK5iXKxcMMHAUEk5FHQqqebt3BFXP2HKFHu5aroe4D
	 kJI9TfgPD4d7m3NGzHgZemNDntOs+GqpO2Vj4LTzq7jh7Y6x1lugvNVZ+rJXpwCsEVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZaWZkARZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC35606A333
	for <damon@lists.linux.dev>; Sat, 21 Nov 2026 21:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZaWZkARZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475E21F000CF;
	Sat, 21 Nov 2026 21:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294828;
	bh=FTjjk1bjDwpUg3WWMwzBwOs56rHK1uC/DHx/Q7GkWVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZaWZkARZ/HsAd/1YZhKEw78/Dk1rtNNpZCUby5cAAGNxutNEZOOT4xIRhyvLrvAGf
	 FffygDz9LuC1mJR3QHo9lsIo9ESHFFM95CX4fu9M1/xGzK84nbuCln8FZIHln8h5Vf
	 STGIdA5cExVPdfHvHoh6k0mJ5INNG8eNN5Lz9HfuF2YSz3mbg5s++s6jgdVYpa0m1L
	 /xgn5Lh+AlDAuhJBUqz4qPtlMr7+7Aoq25C34SkZGv+i6hCjElnCp4S0wmgQK75QhH
	 jVZV4y3rvAVK/6qhVUU4gP9VDLrpkMq9wsIzUTr7+o7inkDTRXo390rk/MAtmeHWm/
	 zzCV0mM1mPwrA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH 21/27] mm/damon/sysfs: add user_report support for report type input
Date: Sat, 21 Nov 2026 13:00:05 -0800
Message-ID: <20261121210013.130397-22-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261121210013.130397-1-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
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

Extend the mapping list for data attribute report types and user
keywords, for the USER_REPORT report type.  Use "user_report" as the
matching user keyword.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 1c171af4590a8..b4d898ec0c9f7 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1187,6 +1187,10 @@ struct damon_sysfs_report_type_name {
 
 static const struct damon_sysfs_report_type_name
 damon_sysfs_report_type_names[] = {
+	{
+		.type = DAMON_REPORT_TYPE_USER_REPORT,
+		.name = "user_report",
+	},
 };
 
 static ssize_t filter_report_type_show(struct kobject *kobj,
-- 
2.47.3
