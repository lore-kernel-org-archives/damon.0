Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294829;
	b=ejHCIQ0UB5iC5bEoEvX67rZCrGNMVdIciwzV2au6s6tfdVF41Unq+YmTxL1xOV6e51GK
	 3x2HAEEUwMULg2ODrAPvx8/q2DKukrHWPFCXiGK/+jmiYmrVASfxbJjS4mpC4jEY69YQf
	 9AU5btYJD+Y5jdyYSmSups76nCSceab8Ktdhbmfpm2lEcNzJU6XG1uhZyZntdyxccewc7
	 k1EfC8cgTbBZRXBCXW90bbVvCGJLxVUoOmT7w9QryV699Cg13dgUCkQCHPPJLeL6CTfzV
	 7aFO4hXRo9gK164B4w6GETCu/aN7v/l7256AdyYTjOrh5XQsGmXJZ3ly/XsCNGJwYhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294829;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sRVXEo9+L3IOL49loDwH1nSlcsh8gFIjIUafHWHgJ4s=;
	b=Aq4EPUjsmp0pSiIGhSrTKE2sf0xI9M+3+JQkLTsZllGSYCWhdrSRgBFZkorad6DtGN4W
	 MJoKPFTNOo/rpjIzgmDtc9McbYmrylOzaGuvQWJ7rgHaZWcL7CRG8YLjecXgWyt8BjnNl
	 VBqN7d3Rw8ioGO263VPS/v4BPrbKMN/dqouzW6E00C9ThmvP0vCUldjMUz2MV0kSDQVFr
	 GFEyE5EEluGR/mfSANcWtxiXkm/yq1D4Er6BmfYpSiUFLdfiYtSEHgW6QxR/d+6jMuEa3
	 kLokf/AmYZQuDgqRhqSHhIzatce8v4bV25sqVJkOgDWkxNimfO2mwZ/erraXYWMfEQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LbVDxgF1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3B9606A334
	for <damon@lists.linux.dev>; Sat, 21 Nov 2026 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LbVDxgF1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF901F000C0;
	Sat, 21 Nov 2026 21:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294829;
	bh=sRVXEo9+L3IOL49loDwH1nSlcsh8gFIjIUafHWHgJ4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LbVDxgF1VHNnR2QH0PKb0mYWKKTDoyVxo1RbnrklL6wOn1nBypBVgzqUQe6X9w7Co
	 vOa+NQRb5THyEOhvADELH+WsuabpaqLCrLmU8W5P8LZaUhsRpWX9AlR6drz+yI4SrQ
	 8DcB1JB77sbeKo9cmFxz1XigHvIzpaQdXeRqWWKRQVbWyrUF9RHvZvvABCC8JEAtWd
	 vgNhGwAPvtyp9INuRBvqdrlGD1+hdOH8lvYIUhybttoycv/T75pTW/vHY4qB+h/6/J
	 u+nfIH5n1uMKzzJ/+agVcia2iozIUXGKZsjXramEC6aEtawbYJV/Jj0djTIeLwyrvi
	 ZcJqhQqrWmPVA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH 23/27] mm/damon/sysfs: implement submit command for report producer
Date: Sat, 21 Nov 2026 13:00:07 -0800
Message-ID: <20261121210013.130397-24-sj@kernel.org>
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

Let users manually submit a report of a data attribute for a given
address range of memory.  Let producer_state receive "submit" input for
that.  For the input, generate the report based on user inputs that are
written to the appropriate sysfs files and submit to DAMON using the
core API, damon_submit_report().

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 5f9bb1955dfd5..0049aac6ab974 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -3107,13 +3107,26 @@ static ssize_t producer_state_store(struct kobject *kobj,
 {
 	struct damon_sysfs_producer *producer = container_of(kobj,
 			struct damon_sysfs_producer, kobj);
+	struct damon_report report;
+	int err;
 
-	if (sysfs_streq(buf, "on"))
+	if (sysfs_streq(buf, "on")) {
 		producer->enabled = true;
-	else if (sysfs_streq(buf, "off"))
+	} else if (sysfs_streq(buf, "off")) {
 		producer->enabled = false;
-	else
+	} else if (sysfs_streq(buf, "submit")) {
+		if (!producer->enabled)
+			return -EINVAL;
+		if (producer->report_type != DAMON_REPORT_TYPE_USER_REPORT)
+			return -EINVAL;
+		report.type = DAMON_REPORT_TYPE_USER_REPORT;
+		report.addr_range = producer->addr_range;
+		err = damon_submit_report(&report);
+		if (err)
+			return err;
+	} else {
 		return -EINVAL;
+	}
 	return count;
 }
 
-- 
2.47.3
