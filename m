Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4736F3A782E;
	Sat,  7 Mar 2026 19:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772913248; cv=none; b=chHKvt9H+c12dDiTLl5E5Dzy9I+NS5p8dB214+dLVja++F4JDtNhvsmxnxw7PZ+odIeQHYrC/PPdXCZf73Rb/LRwIPNGenmR3AWN6Q9VpsxTm+GIfUNiWloBrWQiE9UhefcaVcZr5lP13xzrldhMKKZlccL/+k3Y6vOkfXO2cKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772913248; c=relaxed/simple;
	bh=B5+v4ahllGQlugFTnl7kA++eThswGO++aezsc7tYPRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hnwxadf6OfS3SYDrNbE/nB7zYdZrzPDo2V9UpXJ2chuAXGq7RGin0PYIkmOnVzrrfUR76LBzX6vxVQlyY5Cnuzb0BixEmZfnEOnNERuCPdi4OUPV1Ga/o8+aSjgGQTjvInE2HuLPjNdmx4vpdZoOGXtnD9eino30ZFXX66HBXAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrjNkbKT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrjNkbKT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03937C2BC87;
	Sat,  7 Mar 2026 19:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772913248;
	bh=B5+v4ahllGQlugFTnl7kA++eThswGO++aezsc7tYPRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BrjNkbKTdGzq+yhUwe5axGBJFPzytHOMQFxyeAh0qSdkRKr0X4KexLPHlVpSXlAW1
	 MNDZfm/0LjewDrAXXM+OawQCbXuLMTUzYXbFUlxXgFuhjU5lIN+rbkac8HawPOJeAe
	 j3cj2CQbZYUdrE3qihZeHzkQEu+PxWJl9+Dp8zQWJpi8QsQuvhq533W6iI7lO08wX2
	 QfccwoG0XrzSWFd+FaAJkRme+NbCw4B7fTLVNesAwZmN8LbMiSJmAZJZ1+xlOZNHLG
	 ytGu37IMAkzbL2ijIsUyofz5pJyhr7k2bxsh638k6gQOXMuuKc/xoOgQeoxhDmRIwX
	 aIWMzn5k066aA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/7] mm/damon: document non-zero length damon_region assumption
Date: Sat,  7 Mar 2026 11:53:52 -0800
Message-ID: <20260307195356.203753-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260307195356.203753-1-sj@kernel.org>
References: <20260307195356.203753-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON regions are assumed to always be non-zero length.  There was a
confusion [1] about it, probably due to lack of the documentation.
Document it.

[1] https://lore.kernel.org/20251231070029.79682-1-sj@kernel.org/

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 9a88cf8d152d8..6bd71546f7b20 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -55,6 +55,8 @@ struct damon_size_range {
  * @list:		List head for siblings.
  * @age:		Age of this region.
  *
+ * For any use case, @ar should be non-zero positive size.
+ *
  * @nr_accesses is reset to zero for every &damon_attrs->aggr_interval and be
  * increased for every &damon_attrs->sample_interval if an access to the region
  * during the last sampling interval is found.  The update of this field should
-- 
2.47.3
