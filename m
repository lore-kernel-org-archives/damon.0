Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0F535E1C9;
	Wed,  1 Jul 2026 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917308; cv=none; b=WtN1806UxnynlN9b82Zjs6W+0uACFaO8+rLoPDxQrCGPmmOL9Xk4ix0kBb084GgSTtZ0JsPSqA3h6uuJdYS7aHYEUkXa+Hf6VV+IP7HQdD5a6DGx/JkIRavqu1fgzjT/UGC7pkpjs47/mnLQZKSrptYseql+OgU6t7n2dpqxPPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917308; c=relaxed/simple;
	bh=wzDfGXESiahJas2itrLvNt5M85oi6ewwf7xuOPxl2Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQL04AMaW1RQZqMswFWIK9NMFgEHL0wpCk/JJ3hjb9tIUwis2UMyqIrRnQThzSD1FI2E/NN8sdv0xSVRldwF2DfryM5Z4GvNHNuERIQWF4PO07lqQl1mmBoMfq6GdLBpoccyFtI3Y9nZElhP3s4YBsn7+e+RA8D7NL4uAcLVn5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3kI/k7A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3kI/k7A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABA51F00A3A;
	Wed,  1 Jul 2026 14:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782917307;
	bh=91/eIt5/uTjkLlfjnN3QJGjfo7AqpmKw2P22J/q/8zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j3kI/k7AFBW4j4KYZTivaA5kkmRq4j7EuNzBwhzm1ciJBHV8ckGmRFSiYxyH9meGV
	 EfLJLZ6TwrHO6WltIcpEK0VwQAlB+hmHoHR98MuW42ilBz7k2q+UPHxESD9ieCdK4i
	 tySqDivp+Zi6BeOpL1CWyVTXv8UqSk5V61RgWPL0Ctn0xYslC9vrpVpTuSDD/aIOct
	 CZ9Jwo9nosYcClfQr8cguC6h+gYQNuy2ttxvtqNzngtb3orNx9oqD1ELlLCHQn60LB
	 7ZlUJN9JwAFCAYEUATeUM26wzU902KCsV+knaUPCHefRAqnorenxlSELJy5qr0z0qz
	 Wmajxk9m8+PXw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6/8] mm/damon: document region size validation in damon_set_regions()
Date: Wed,  1 Jul 2026 07:48:08 -0700
Message-ID: <20260701144815.113325-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260701144815.113325-1-sj@kernel.org>
References: <20260701144815.113325-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel doc comment of damon_region clearly specifies every region
should have positive size.  But it is unclear who should verify it.
damon_set_regions() is the recommended DAMON core function for setting
regions from the callers, and has the verification.  Update the comment
to clarify the callers should be ok to pass any values for region
addresses, as long as they use damon_set_regions().

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 616bdf0954b52..2661231c0ae82 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -49,7 +49,8 @@ struct damon_size_range {
  * @list:		List head for siblings.
  * @age:		Age of this region.
  *
- * For any use case, @ar should be non-zero positive size.
+ * For any use case, @ar should be non-zero positive size.  damon_set_regions()
+ * does the validation.
  *
  * @nr_accesses is reset to zero for every &damon_attrs->aggr_interval and be
  * increased for every &damon_attrs->sample_interval if an access to the region
-- 
2.47.3
