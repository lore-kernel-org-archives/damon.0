Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774549;
	b=Q/c+xdVBd4F3EPPom2wm+26VEk2UJYKtHBLeasKNiT7eMbeotzfhFQI5drmMMnmD1M4T
	 ROFZfvLoMB7AtSExe6QKd9724isGzCMGFIekcJZqiKFsw6hDzvYP+9maLVQLpW5qiaXV0
	 5Oe8WdDK+h+UrQzflIw7YE7Alx8bwOBQi//AD9LKmEQRepOWPxdSoHFH7l4V7OyecqdAh
	 YrBpx36QSjFN3TNOnCpHSFJwiXoL51pLxSpyNq9S+Ae2W55jSEokgeeqURdw+w3THsoBN
	 D/v1DY4+OOVUCUwxuzFekGFj1H+TqCc0GJVThP9dW0JdEutEW2KOPeYCWQ7Ar/UX7zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774549;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FTjjk1bjDwpUg3WWMwzBwOs56rHK1uC/DHx/Q7GkWVo=;
	b=cxNAOyejrmewQEO3LcVZzlFXTiHqb+V3dypgd6w0qf5sAL8PDqnAbuOmi6Qa1fpOfnCm
	 cSXGksloLIyKwo0YYbj7HEWVN40UGSCauo5HB9ERJ35ao9nDVEV1iPDDububqArj+5gQv
	 ODOF+F+Vf/XvQBKXpoSyS2aejiGKHrveg0FY1Ga2g3ttoRha3kWHL/zeg3aDCikIJBkQb
	 Qq3vdynEQul0dd0MuZ+IujKtcCHVEIxQ8efzFXnhWxiGmLQg/EsvMz0pF5InK5rh8IFv5
	 nm1TxcG1BTUtuScID5c+upDaeJKKHFWZgRAOSvL/gTfcuJvXclNwjOyMuQAxJNYZ9eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="iGdpvCQ/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB54606A898;
	Sun, 15 Nov 2026 20:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iGdpvCQ/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596AD1F000C8;
	Sun, 15 Nov 2026 20:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774549;
	bh=FTjjk1bjDwpUg3WWMwzBwOs56rHK1uC/DHx/Q7GkWVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iGdpvCQ/yTW5aKCkDn6KWUTvwimLquIvnuPL1kCchtFEaBfVMAF0ZIU/GZ6F/2zDg
	 rA77nsW6/UE4ZLoJhA1a+TwJy+2RwRO8W3BiduOYjCCsDECEIZAcowQjR+gj9+1ZXw
	 Pa2mvV8R3ciE1KD1N/PZ/zdUwxva0i+W4WuwkAyxsozo798OWzo538br0iOlNcKttG
	 bF//BkSsUOY0IqcycpxoHSbAsUihef6PVNoYC9ENoI9X2q/hNO898JfHebqN18biXw
	 D1v+9Hr6obIJ1RC8x64qGOdl/Jimsl5STYFMOdCXcCFynKOUDPWYJW42ADLMWwbuRH
	 hyTDoGa/aG6YQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 21/27] mm/damon/sysfs: add user_report support for report type input
Date: Sun, 15 Nov 2026 12:28:39 -0800
Message-ID: <20261115202849.99134-22-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261115202849.99134-1-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
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
