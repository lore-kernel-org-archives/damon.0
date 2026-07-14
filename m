Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297C8150997;
	Tue, 14 Jul 2026 04:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784003684; cv=none; b=K5c0AdztRF1i5VpEjdvrcasDea/FOuQ0HT9vw5ev00NtFS7OegaKyAfWEXv6peEXfHTt4NyYbgszqEhmL19QBOpYc7OXzflZDg3itT9RbKF8qnZCVLPVl71sveDUikTS9/oYhEaY0IBzByEQcTdsocw/EZWB/yOzwFBsl07lp/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784003684; c=relaxed/simple;
	bh=28KQrfeI2zvjHjr6PuDX7oyWWH3SuTV6OXLAVtISIPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VT0IELKzSVdEcCCdxe23/4oRRF1Mp+7ntKb7L+YkQshvbJH/+CBM9rBQLiVx7Uhe3YA2o2q92E5WDmOGHCXqCmCbVT65HxTE7TSC2v0vcagoFrqTm4Ghz62wwX6NMsAhFxkWIg4DhDmZpBt4CsDagjJpR9BouOMk+rEj2CpM9Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQRV77Tb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQRV77Tb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF35F1F00A3A;
	Tue, 14 Jul 2026 04:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784003682;
	bh=O1GFuFV6Qv2wWJnuvFbk/HsH8hWm9YYqEFf3m4C5iW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VQRV77TbKCUCH8IIFl5SmwBxcr7DCsc0PHVTjB4QqHoY4fgGMOvJCZa8DI9M7ykYd
	 AGEPwYZeh2oj6uJ+WMGR3dzoJI+taM8N82sUkKnX16BHWrwQ764XFFU89JxM8nrD0n
	 Qa4b2Plfg3QqQbTBj4n1gIxwOqK1Wp563CBJSwNiCnPKFkRS2TCZm/MvncH2lvpb3r
	 lABcSdLR1kWgyT25ZPbRY6oFCHYGBzJs+n/cOcM3hY3LUqfxN7Sbg/YJ0FCOgxYEMU
	 F7dpH1T+W2uEKXxgqOEKK+xMj1wVz+0fP0C6gtbiNKOfGQZVN5yF6aji/nfj9XDyFH
	 DCl2lFWH4fOOA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 01/10] mm/damon/core: hide private damon_region fields
Date: Mon, 13 Jul 2026 21:34:27 -0700
Message-ID: <20260714043437.95811-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714043437.95811-1-sj@kernel.org>
References: <20260714043437.95811-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_region->list is intended to be used by only the DAMON core layer.
But it is mistakenly not marked as private.  Hide it from the callers by
marking it private.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index f69442a9d4312..d32377e7e535e 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -46,7 +46,6 @@ struct damon_size_range {
  * @sampling_addr:	Address of the sample for the next access check.
  * @nr_accesses:	Access frequency of this region.
  * @probe_hits:		Number of probe-positive region samples.
- * @list:		List head for siblings.
  * @age:		Age of this region.
  *
  * For any use case, @ar should be non-zero positive size.  damon_set_regions()
@@ -68,9 +67,11 @@ struct damon_region {
 	unsigned long sampling_addr;
 	unsigned int nr_accesses;
 	unsigned char probe_hits[DAMON_MAX_PROBES];
-	struct list_head list;
 	unsigned int age;
-/* private: Internal value for age calculation. */
+/* private: internal use only. */
+	/* List head for siblings. */
+	struct list_head list;
+	/* for age calculation. */
 	unsigned int last_nr_accesses;
 	unsigned char last_probe_hits[DAMON_MAX_PROBES];
 };
-- 
2.47.3
