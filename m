Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794547040;
	b=hmVC+llCdQOv1381PjvXLNqYSAp7A/7lBQHe9M7B7VZk0E246BgHiAwMLRiV44Hj/IR0
	 VnORd+2ZhP53jelR7AMLiFO7/Zsv2YxOfqEcVQ5eer5iK+o1tAT/yKS24pHRNFsjXCgPD
	 9NPlEeufhrylSIBNii/i1FlagEfVIiZfQXVzz6Pcv2VyEpAGcXKVkNShdLL6XQ+M1Wrc9
	 XDb2BO4NdGGiqCug6fC4MY+XW6CFmTDNyNGe8sJEDS2SC1tCfW5E5gFR83LKUZ/vTD/o1
	 JFiejaR4nTW4xf/v7Ohbc8XDTTExLt/d6UaJ/amdKePOTtZAfGYvUMlDf3TG9LjiXBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794547040;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HEvMyrDAXRSzNt1aAK2qvgfoj7RJAzXbHjO64hkCzVk=;
	b=kKCnMtAfsELJMp3hJs+z+hrlve2KYv35in8v6pyPwnmsip2j8GRvaoODmiMWveVHG568
	 WFMk2n3ezxc6bNlhsLCsZ5jdZjRKMSZCLhz4UogS5OKIHtzTckZma6ccBZkRbQKRvoV6u
	 NbHcOdxVJsq32kyWM1NI2QcDydnGK37EqAFVnltkdD2MxC4e/T4pPZunMbSNQx9fUBuEz
	 soPJtkjgL5HQ/IMYbhQD5nZsTOEHiw51VTx6SdXWWAeX0KcE+PCPljfsCOIYVsi+XmKfw
	 sTONdpk0Ki/qzRd5WO46vMPhCotsoaHF86bYVJPZ10cnlnFxutcwsTH0jk69FguQ0fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dWOGVOub;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADBA606A339;
	Fri, 13 Nov 2026 05:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dWOGVOub
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C2B1F000C6;
	Fri, 13 Nov 2026 05:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794547040;
	bh=HEvMyrDAXRSzNt1aAK2qvgfoj7RJAzXbHjO64hkCzVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dWOGVOubQmYgYdR8aCldbmFLhmQ08Gh1b0R0l21HrmWv9XzbUVfELJAKkZOJMPv8K
	 WDtTZkH7Bg7kjkBoPZHw7iUO8DCJ4kVhsT7U3ZI4DxMdJoXHixj0vaF7ZERLCvrdBV
	 dEs5fNKnfHyI5zQSXNppadSq1zgr/jGmYbZDlgFN7tUfRDhieaAYsJF/EK4aj9P1g5
	 xoQKRV81NdW3OoGCUPbqyL8M9wLI/bFo2APYa9Klm007GVSsfzEag76GYDiEzUev0m
	 2CTXe9hFU5BlL+1rB2439VlUpsSb1uGYzwisi8w+I5egUqKlvfNIVSgYbKv/kaV1fW
	 ZT3uHeB23RTMQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/4] mm/damon/sysfs: support LRU-activeness based DAMON filter setup
Date: Thu, 12 Nov 2026 21:17:09 -0800
Message-ID: <20261113051711.89274-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261113051711.89274-1-sj@kernel.org>
References: <20261113051711.89274-1-sj@kernel.org>
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

Support DAMON sysfs interface based setup of DAMON_FILTER_TYPE_ACTIVE
type DAMON filters.  For that, wire the type with a new user keyword,
"active".  Users can set up the new type of filter using the existing
DAMON filter setup interface with the new keyword.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 70a4b64fb8ea9..779c98205a94b 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1011,6 +1011,10 @@ damon_sysfs_filter_type_names[] = {
 		.type = DAMON_FILTER_TYPE_HUGEPAGE_SIZE,
 		.name = "hugepage_size",
 	},
+	{
+		.type = DAMON_FILTER_TYPE_ACTIVE,
+		.name = "active",
+	},
 };
 
 static ssize_t type_show(struct kobject *kobj,
-- 
2.47.3
