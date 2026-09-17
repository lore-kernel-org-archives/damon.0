Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF63233BBC5;
	Thu, 17 Sep 2026 04:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617947; cv=none; b=rDkMgK5ZEpKYX4Hak7d7Iq/WL28Di6eiIaflUVdzN2c6BbE1wvforch2CrI81yVtr1cjClnqipKqJs4GPeleoh0WIEnFnaFhgJjbfVn1AP+wdeKJS6SfrkHizQD5n5kOycsZb/XQUiOj+e4k/RYNHKfi2ieBfubs7f6mbEUev1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617947; c=relaxed/simple;
	bh=5x3DivB9gQB5lxNvwTlsjIfeudSnzImQeh4vtHJ1uLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dM4iA4g0wpAltf7Y5hKJiVbm1tepAo82IAk0X62Be4LqGiwD07AY01BucmGSisAIcUFg2q6AOgesmIYoZoVCh/QYrPeA7MBd15hAMYZ8I/dgnsYQhz3D9AqvwP7Vnj5kv5aknhv7MZmjD7IuVUrnEYIRT7GiDplWHbmiUNPkgFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTN26iIo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTN26iIo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90ADC1F00898;
	Thu, 17 Sep 2026 04:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789617945;
	bh=T7NGmBAgLNyxB6QRiSTsc0KXNRJO/iSY1w2o1E3csW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JTN26iIoHZhelS1NeIJaA/1L6mykFHnMmouYpjQ7s2E2tM4Hdp5ad7L46DnZbdfUH
	 S7bSCftBfMXaJzhFRf/w9OMZSaMWJlZcliIKIiRBngJhOyJRgL4QSj2+rzrHK17gNh
	 qpCC2hkhGferGcj7KF7/FHsVJZmFThTEbywk2ItarAheMjiEYIyWXrmg7fnhJNJYrO
	 6IpAhYsnBhGUFBkZjxtkDHoIuJ5P6klF7lkwSe7f5lElKaLsZbinzse/4wftbalHqP
	 VhvOXd86KOikIksTTR8J0ZyKNT/F6RjLMHVs5y3IM8HtSSsFMJhFcUHRCHfR7LFx2k
	 eixXf+TisSNGA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 01/10] mm/damon/api: remove NR_DAMOS_FILTER_TYPES
Date: Wed, 16 Sep 2026 21:05:27 -0700
Message-ID: <20260917040537.107341-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917040537.107341-1-sj@kernel.org>
References: <20260917040537.107341-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nobody uses NR_DAMOS_FILTER_TYPES.  Remove it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index bbb190b474015..836353c4ab9aa 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -400,7 +400,6 @@ struct damos_stat {
  * @DAMOS_FILTER_TYPE_ADDR:	Address range.
  * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
  * @DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:	probe_hits weighted sum range.
- * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
  *
  * All types except &DAMOS_FILTER_TYPE_ADDR, &DAMOS_FILTER_TYPE_TARGET and
  * &DAMOS_FILTER_TYPE_PROBE_HITS_WSUM are handled by the underlying &struct
@@ -422,7 +421,6 @@ enum damos_filter_type {
 	DAMOS_FILTER_TYPE_ADDR,
 	DAMOS_FILTER_TYPE_TARGET,
 	DAMOS_FILTER_TYPE_PROBE_HITS_WSUM,
-	NR_DAMOS_FILTER_TYPES,
 };
 
 /**
-- 
2.47.3
