Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968559;
	b=R7K50KKChyyi/npzkEP/nZd/HllRcvlEbncya+1Aw4fRdVjSVwi63+VivCUvh6A3WvtZ
	 ul13rg8KY36jKvRJpT8L/y9JUz5c0fCRfY6X1DFFNUGPG+Fqf1yOwoFZ4rSS5JEYJtFbo
	 XUYhxoax5V4muPf9tm0fNvr5Yvq8w/0EM6eYCNg7E8CMWyXt6SmiamXy948RP0pBPjyBs
	 GHIKoltnGfFUk7JWFBKDiXeqaI3D9Lk8+4/Ye5q3YXZP5hBdNpP4lkfNXbzpYKkQDLo2L
	 ZIjwozXx8KHEUqpgFoHEMwAqGLl0H6S/MReJGwCNvwmuH9RTJdtyW2D7nX84XFlOwdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968559;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=R4c30zMvWlF/HAu21CDBSrVZTsdtRg90kDV5GhwCdMQ=;
	b=Hh+Q85k9Das/cW1Euo8A88QY8oJjUtEoGG7PKBMC2u4OsuL4gCxA/1UJYIDX1HD9AWrr
	 e6oKSjmh3/ZsgQCfnyrpQbA8Kk6eRsAaNF6cD/Siww+pNVkwTaw9yJ2M9jkpTKx5eg/bO
	 SK1pi4PGF1u3gyo8WYDTa5HtEO6dO0ObeHx8fB18DNZ13Qv8ssG8L4PW+l/UeTjJU5E1d
	 ByGEddvQ4KJ8NVky+/XUnBPtjZj7GSqkmsohMNUqeI9Byn8+QuyzGxOhddU56hd/rg/E5
	 9gKmNznm5/xl445Eq61GlZy4exS3s7APd3h/MbVqWUQPBY5tjiXd+bpF46aU+9Cr2jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lESe/0x4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365D260A5BEA;
	Wed, 18 Nov 2026 02:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lESe/0x4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAABD1F01831;
	Wed, 18 Nov 2026 02:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968559;
	bh=R4c30zMvWlF/HAu21CDBSrVZTsdtRg90kDV5GhwCdMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lESe/0x40pspxTfLO3daU8b2jvOU/u1QdsY6TF86waH4uF/VSqrAFIW/X1B97Eqgi
	 xf793yELsFJOqsV/+cjDnE/jBmO6iSjSogb6pAXwbdjq+vS0Lsp5u0BI9vZKu4gWn5
	 TgyGXgqGWCyBp8TQ2VCZYCS2tchcEucPOxK1s+/NFLwCicYbfZUYhEeJ9JziroQjwr
	 xW9ZPoT8WJOrNEjYAY0nnuUG/9neCLQTS1lS2GVV4ilMovT2klLSUxKqTUlwAae8mR
	 XyDDRLTUa09Hz3ae2cjftOCYaqys8wOAecLxjMKzqRdT8oeAvWAjQelSbA7zGIt6e8
	 kmT6raxgdZWvA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 19/27] Docs/ABI/damon: update for REPORT_MADE probe filter
Date: Tue, 17 Nov 2026 18:22:14 -0800
Message-ID: <20261118022225.100659-20-sj@kernel.org>
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

Update DAMON ABI document for the newly added REPORT_MADE type probe
filter support.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index c9f718f126c70..e558dd4212f2c 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -233,6 +233,13 @@ Description:	Writing 'Y' or 'N' to this file sets whether to allow or reject
 		hitting the probe for the memory that satisfies the 'type' and
 		the 'matching' of the directory.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/<F>/filter_report_type
+Date:		Nov 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	If 'report_made' is written to the 'type' file, writing to and
+		reading from this file sets and gets the 'report_type' of the
+		reports that this filter is working for.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/targets/nr_targets
 Date:		Mar 2022
 Contact:	SJ Park <sj@kernel.org>
-- 
2.47.3
