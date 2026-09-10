Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC7548CD54;
	Thu, 10 Sep 2026 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050162; cv=none; b=Oo83U2rAozj4vJM2jF5zYZJiR8GNgPMDJo4HrDJ+i1slSc+ijjAuGq14+g7ApfaErjhS0dBmA4L6D51y60Q+I001kIVo33/oKJYh1IEPjg5p5wMlmK6n0dAtzueYFthh0ckKor93TL78jK6cb6zn0lS8YC2sswcmEGPTsBCKQps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050162; c=relaxed/simple;
	bh=YKVKaWYEqO5GEEeJQxDrMihfRchCyi/+bnF0sDln3nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvBYZkj2XhrdTZ5npQig9JlMpfG2iMp8Yqu4XXarEaALYNAcz6peHnvZ6SgVrCuGoC3ETogOj0tHsbD31S2Rz8j09N5/pp53yDzpmwkJR7I+tjSgosahIodprZpJewKOhKkjJrEczl1H5iuK5m/b2jQ1RGQIwHZuoTBtano0Sw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRYtb3eO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRYtb3eO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585201F00893;
	Thu, 10 Sep 2026 14:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789050161;
	bh=3ydmrqNiPvZ4mpbkkUedW3SpTRg9lnwme+IK1BHGVlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kRYtb3eOqKitNK80KezJoRPOPFZ8U4uxfCBnZtOA6sLTfFtxxFMgXJJt5n2IlRg4n
	 tBLuqMizz1b98n9NOUFzcVwzpRKbj6wI5DbUMqR8Z7s0DM569fsNCophlhPslONnSz
	 usvta/39C0dK3G3wCtTwL8D1oq0qob1k+DGvXJqjUdO2TXNY0rjwhmaTHw7FR55u4r
	 aFu9l5hWDgCyJcwz6BNFKI5uNkiIrxdBSuZm2r4HqXDfpmhSwytaYwvh1qa7vCu1cX
	 o9IEY7Qp9KOYlbwkAPjDKb2tp4xqYi0d4P8oXXEfabyXGwItFPexPrOI88EWL7wugi
	 SSN8fEYGbVgCg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/5] mm/damon/api: introduce DAMON_FILTER_TYPE_PGIDLE_SET
Date: Thu, 10 Sep 2026 07:22:28 -0700
Message-ID: <20260910142234.171562-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910142234.171562-1-sj@kernel.org>
References: <20260910142234.171562-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_FILTER_TYPE_PGIDLE_UNSET matches only memory that was able to
confirm if it is marked as idle.  If the memory cannot be marked as
idle, it simply doesn't match.  Hence, finding memory that was marked as
idle with only DAMON_FILTER_TYPE_PGIDLE_UNSET is impossible.  Introduce
a new filter for the purpose, DAMON_FILTER_TYPE_PGIDLE_SET.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 4a36f344bbc7c..abb529771091c 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -782,11 +782,13 @@ struct damon_prep {
  * @DAMON_FILTER_TYPE_ANON:		Anonymous pages.
  * @DAMON_FILTER_TYPE_MEMCG:		Specific memcg's pages.
  * @DAMON_FILTER_TYPE_PGIDLE_UNSET:	Pgidle is unset.
+ * @DAMON_FILTER_TYPE_PGIDLE_SET:	Pgidle is set.
  */
 enum damon_filter_type {
 	DAMON_FILTER_TYPE_ANON,
 	DAMON_FILTER_TYPE_MEMCG,
 	DAMON_FILTER_TYPE_PGIDLE_UNSET,
+	DAMON_FILTER_TYPE_PGIDLE_SET,
 };
 
 /**
-- 
2.47.3
